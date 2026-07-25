/// شاشة الملف الشخصي
library;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constants/app_constants.dart';
import '../../core/di/di_setup.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/helpers.dart';
import '../../data/models/student_model.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  StudentModel? _student;
  bool _isLoading = true;
  bool _isEditing = false;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _phoneController = TextEditingController();
  final _sectionController = TextEditingController();
  
  String? _selectedDepartment;
  String? _selectedLevel;
  File? _newImage;

  @override
  void initState() {
    super.initState();
    _loadStudentData();
  }

  Future<void> _loadStudentData() async {
    try {
      final studentRepo = ref.read(studentRepositoryProvider);
      final student = await studentRepo.getStudent();
      
      if (mounted) {
        setState(() {
          _student = student;
          _isLoading = false;
          
          if (student != null) {
            _nameController.text = student.name;
            _studentIdController.text = student.studentId;
            _phoneController.text = student.phone ?? '';
            _sectionController.text = student.section;
            _selectedDepartment = student.department;
            _selectedLevel = student.level;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() => _newImage = File(pickedFile.path));
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDepartment == null || _selectedLevel == null) return;

    setState(() => _isLoading = true);

    try {
      final studentRepo = ref.read(studentRepositoryProvider);
      
      final updatedStudent = (_student ?? StudentModel.empty()).copyWith(
        name: _nameController.text.trim(),
        studentId: _studentIdController.text.trim(),
        department: _selectedDepartment!,
        level: _selectedLevel!,
        section: _sectionController.text.trim(),
        phone: _phoneController.text.trim().isNotEmpty 
            ? _phoneController.text.trim() 
            : null,
        photoPath: _newImage?.path ?? _student?.photoPath,
      );

      await studentRepo.updateStudent(updatedStudent);

      if (!mounted) return;

      AppHelpers.showSnackBar(
        context,
        message: AppMessages.profileUpdated,
        icon: Icons.check_circle,
      );

      setState(() {
        _isEditing = false;
        _isLoading = false;
        _student = updatedStudent;
      });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        AppHelpers.showSnackBar(
          context,
          message: 'خطأ في حفظ البيانات',
          icon: Icons.error,
          backgroundColor: AppColors.error,
        );
      }
    }
  }

  Future<void> _deleteAccount() async {
    final confirm = await AppHelpers.showConfirmDialog(
      context,
      title: 'حذف البيانات',
      message: 'هل أنت متأكد من حذف جميع بياناتك؟ لا يمكن التراجع عن هذا الإجراء.',
      confirmText: 'نعم، احذف',
    );

    if (confirm != true) return;

    setState(() => _isLoading = true);

    try {
      final studentRepo = ref.read(studentRepositoryProvider);
      await studentRepo.deleteStudent();

      if (!mounted) return;

      context.go('/setup');
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        AppHelpers.showSnackBar(
          context,
          message: 'خطأ في حذف البيانات',
          icon: Icons.error,
          backgroundColor: AppColors.error,
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _phoneController.dispose();
    _sectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && _student == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppMessages.profileTitle),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => setState(() => _isEditing = !_isEditing),
            icon: Icon(_isEditing ? Icons.close : Icons.edit_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // صورة الملف الشخصي
            Center(
              child: GestureDetector(
                onTap: _isEditing ? _pickImage : null,
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 4,
                        ),
                      ),
                      child: (_newImage?.path ?? _student?.photoPath) != null &&
                              File(_newImage?.path ?? _student!.photoPath!).existsSync()
                          ? ClipOval(
                              child: Image.file(
                                File(_newImage?.path ?? _student!.photoPath!),
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => _buildDefaultAvatar(),
                              ),
                            )
                          : _buildDefaultAvatar(),
                    ),
                    if (_isEditing)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // نموذج البيانات
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // الاسم
                  TextFormField(
                    controller: _nameController,
                    enabled: _isEditing,
                    textDirection: TextDirection.rtl,
                    decoration: const InputDecoration(
                      labelText: 'الاسم الكامل',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (!_isEditing) return null;
                      if (value == null || value.trim().isEmpty) {
                        return AppMessages.nameRequired;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // الرقم الجامعي
                  TextFormField(
                    controller: _studentIdController,
                    enabled: _isEditing,
                    keyboardType: TextInputType.text,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'الرقم الجامعي',
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                    validator: (value) {
                      if (!_isEditing) return null;
                      if (value == null || value.trim().isEmpty) {
                        return AppMessages.studentIdRequired;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // القسم
                  DropdownButtonFormField<String>(
                    initialValue: _selectedDepartment,
                    disabledHint: Text(
                      _selectedDepartment ?? '',
                      style: const TextStyle(fontFamily: 'Cairo'),
                    ),
                    decoration: const InputDecoration(
                      labelText: 'القسم',
                      prefixIcon: Icon(Icons.business_outlined),
                    ),
                    items: AppConstants.departments.map((dept) {
                      return DropdownMenuItem(
                        value: dept,
                        child: Text(dept, style: const TextStyle(fontFamily: 'Cairo')),
                      );
                    }).toList(),
                    onChanged: _isEditing ? (value) {
                      setState(() => _selectedDepartment = value);
                    } : null,
                  ),

                  const SizedBox(height: 16),

                  // المستوى
                  DropdownButtonFormField<String>(
                    initialValue: _selectedLevel,
                    disabledHint: Text(
                      _selectedLevel ?? '',
                      style: const TextStyle(fontFamily: 'Cairo'),
                    ),
                    decoration: const InputDecoration(
                      labelText: 'المستوى',
                      prefixIcon: Icon(Icons.school_outlined),
                    ),
                    items: AppConstants.levels.map((level) {
                      return DropdownMenuItem(
                        value: level,
                        child: Text(level, style: const TextStyle(fontFamily: 'Cairo')),
                      );
                    }).toList(),
                    onChanged: _isEditing ? (value) {
                      setState(() => _selectedLevel = value);
                    } : null,
                  ),

                  const SizedBox(height: 16),

                  // الشعبة
                  TextFormField(
                    controller: _sectionController,
                    enabled: _isEditing,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'الشعبة',
                      prefixIcon: Icon(Icons.meeting_room_outlined),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // رقم الهاتف
                  TextFormField(
                    controller: _phoneController,
                    enabled: _isEditing,
                    keyboardType: TextInputType.phone,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'رقم الهاتف',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // أزرار الإجراءات
                  if (_isEditing) ...[
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _saveChanges,
                        icon: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const Icon(Icons.save_rounded),
                        label: Text(
                          _isLoading ? 'جاري الحفظ...' : 'حفظ التعديلات',
                          style: const TextStyle(fontSize: 16, fontFamily: 'Cairo'),
                        ),
                      ),
                    ),
                  ] else ...[
                    // معلومات إضافية
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildInfoRow('تاريخ التسجيل', _formatDate(_student?.createdAt)),
                            const Divider(),
                            _buildInfoRow('آخر تحديث', _formatDate(_student?.updatedAt)),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // زر الحذف
                    OutlinedButton.icon(
                      onPressed: _deleteAccount,
                      icon: const Icon(Icons.delete_outline, color: AppColors.error),
                      label: const Text(
                        'حذف البيانات وإعادة التعيين',
                        style: TextStyle(color: AppColors.error, fontFamily: 'Cairo'),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.error),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    final name = _nameController.text.trim();
    return CircleAvatar(
      radius: 56,
      backgroundColor: AppColors.primary.withValues(alpha: 25.5),
      child: Text(
        name.isEmpty ? 'ط' : (name.length >= 2 ? name.substring(0, 2) : name),
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontFamily: 'Cairo',
            ),
          ),
          Text(
            value ?? 'غير محدد',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'غير محدد';
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }
}
