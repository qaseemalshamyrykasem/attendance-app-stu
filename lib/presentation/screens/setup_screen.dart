/// شاشة الإعداد الأولي
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

class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _phoneController = TextEditingController();
  final _sectionController = TextEditingController();

  String? _selectedDepartment;
  String? _selectedLevel;
  File? _selectedImage;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _phoneController.dispose();
    _sectionController.dispose();
    super.dispose();
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
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDepartment == null || _selectedLevel == null) {
      AppHelpers.showSnackBar(
        context,
        message: AppMessages.departmentRequired,
        backgroundColor: AppColors.error,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final studentRepo = ref.read(studentRepositoryProvider);

      await studentRepo.saveStudent(
        StudentModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: _nameController.text.trim(),
          studentId: _studentIdController.text.trim(),
          department: _selectedDepartment!,
          level: _selectedLevel!,
          section: _sectionController.text.trim(),
          phone: _phoneController.text.trim().isNotEmpty 
              ? _phoneController.text.trim() 
              : null,
          photoPath: _selectedImage?.path,
          isSetupComplete: true,
          createdAt: DateTime.now(),
        ),
      );

      if (!mounted) return;

      AppHelpers.showSnackBar(
        context,
        message: AppMessages.profileSaved,
        icon: Icons.check_circle,
      );

      // الانتقال للشاشة الرئيسية
      context.go('/home');
    } catch (e) {
      AppHelpers.showSnackBar(
        context,
        message: 'حدث خطأ: $e',
        icon: Icons.error,
        backgroundColor: AppColors.error,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppMessages.setupTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة الملف الشخصي
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                      border: Border.all(
                        color: AppColors.primary,
                        width: 3,
                      ),
                      image: _selectedImage != null
                          ? DecorationImage(
                              image: FileImage(_selectedImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _selectedImage == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 32,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'إضافة صورة',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          )
                        : null,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // حقل الاسم
              TextFormField(
                controller: _nameController,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  labelText: 'الاسم الكامل *',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppMessages.nameRequired;
                  }
                  if (value.trim().length < 3) {
                    return 'يجب أن يكون الاسم 3 أحرف على الأقل';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // حقل الرقم الجامعي
              TextFormField(
                controller: _studentIdController,
                keyboardType: TextInputType.text,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'الرقم الجامعي *',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                validator: (value) {
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
                decoration: const InputDecoration(
                  labelText: 'القسم *',
                  prefixIcon: Icon(Icons.business_outlined),
                ),
                items: AppConstants.departments.map((dept) {
                  return DropdownMenuItem(
                    value: dept,
                    child: Text(dept, style: const TextStyle(fontFamily: 'Cairo')),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedDepartment = value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppMessages.departmentRequired;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // المستوى
              DropdownButtonFormField<String>(
                initialValue: _selectedLevel,
                decoration: const InputDecoration(
                  labelText: 'المستوى *',
                  prefixIcon: Icon(Icons.school_outlined),
                ),
                items: AppConstants.levels.map((level) {
                  return DropdownMenuItem(
                    value: level,
                    child: Text(level, style: const TextStyle(fontFamily: 'Cairo')),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedLevel = value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppMessages.levelRequired;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // الشعبة
              TextFormField(
                controller: _sectionController,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'الشعبة *',
                  prefixIcon: Icon(Icons.meeting_room_outlined),
                  hintText: 'مثال: A, B, C أو 1, 2, 3',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppMessages.sectionRequired;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // رقم الهاتف (اختياري)
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف (اختياري)',
                  prefixIcon: Icon(Icons.phone_outlined),
                  hintText: '05xxxxxxxx',
                ),
              ),

              const SizedBox(height: 40),

              // زر الحفظ
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'حفظ البيانات والبدء',
                          style: TextStyle(fontSize: 18, fontFamily: 'Cairo'),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
