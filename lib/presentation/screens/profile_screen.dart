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
import '../../core/router/app_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isEditing = false;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _studentIdController;
  late TextEditingController _phoneController;
  late TextEditingController _sectionController;
  
  String? _selectedDepartment;
  String? _selectedLevel;
  File? _newImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _studentIdController = TextEditingController();
    _phoneController = TextEditingController();
    _sectionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _phoneController.dispose();
    _sectionController.dispose();
    super.dispose();
  }

  void _initFields(StudentModel student) {
    _nameController.text = student.name;
    _studentIdController.text = student.studentId;
    _phoneController.text = student.phone ?? '';
    _sectionController.text = student.section;
    _selectedDepartment ??= student.department;
    _selectedLevel ??= student.level;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _newImage = File(pickedFile.path));
    }
  }

  Future<void> _saveChanges(StudentModel currentStudent) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final updatedStudent = currentStudent.copyWith(
        name: _nameController.text.trim(),
        studentId: _studentIdController.text.trim(),
        department: _selectedDepartment!,
        level: _selectedLevel!,
        phone: _phoneController.text.trim(),
        photoPath: _newImage?.path ?? currentStudent.photoPath,
      );

      await ref.read(studentRepositoryProvider).updateStudent(updatedStudent);
      ref.invalidate(currentStudentProvider);
      
      setState(() {
        _isEditing = false;
        _isLoading = false;
      });
      AppHelpers.showSnackBar(context, message: 'تم تحديث البيانات بنجاح');
    } catch (e) {
      setState(() => _isLoading = false);
      AppHelpers.showSnackBar(context, message: 'خطأ في التحديث: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentAsync = ref.watch(currentStudentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ملفي الشخصي'),
        actions: [
          IconButton(
            onPressed: () => setState(() => _isEditing = !_isEditing),
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
          ),
        ],
      ),
      body: studentAsync.when(
        data: (student) {
          if (student == null) return const Center(child: Text('لم يتم العثور على بيانات'));
          _initFields(student);
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildAvatar(student),
                  const SizedBox(height: 32),
                  _buildTextField(_nameController, 'الاسم الكامل', Icons.person),
                  const SizedBox(height: 16),
                  _buildTextField(_studentIdController, 'الرقم الجامعي', Icons.badge),
                  const SizedBox(height: 16),
                  _buildDropdowns(),
                  const SizedBox(height: 32),
                  if (_isEditing)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : () => _saveChanges(student),
                        child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('حفظ التعديلات'),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('خطأ: $e')),
      ),
    );
  }

  Widget _buildAvatar(StudentModel student) {
    return GestureDetector(
      onTap: _isEditing ? _pickImage : null,
      child: CircleAvatar(
        radius: 60,
        backgroundColor: AppColors.primary.withValues(alpha: 0.1),
        backgroundImage: _newImage != null 
            ? FileImage(_newImage!) 
            : (student.photoPath != null ? FileImage(File(student.photoPath!)) : null),
        child: (_newImage == null && student.photoPath == null) 
            ? const Icon(Icons.person, size: 60, color: AppColors.primary) 
            : null,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      enabled: _isEditing,
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
      validator: (v) => (v == null || v.isEmpty) ? 'هذا الحقل مطلوب' : null,
    );
  }

  Widget _buildDropdowns() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: _selectedDepartment,
          decoration: const InputDecoration(labelText: 'القسم', prefixIcon: Icon(Icons.school)),
          items: AppConstants.departments.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: _isEditing ? (v) => setState(() => _selectedDepartment = v) : null,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _selectedLevel,
          decoration: const InputDecoration(labelText: 'المستوى', prefixIcon: Icon(Icons.layers)),
          items: AppConstants.levels.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: _isEditing ? (v) => setState(() => _selectedLevel = v) : null,
        ),
      ],
    );
  }
}
