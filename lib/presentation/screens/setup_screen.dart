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
    try {
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
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDepartment == null || _selectedLevel == null) {
      AppHelpers.showSnackBar(context, message: 'يرجى اختيار القسم والمستوى');
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
          phone: _phoneController.text.trim(),
          photoPath: _selectedImage?.path,
          isSetupComplete: true,
          createdAt: DateTime.now(),
        ),
      );

      // هندسياً: يجب تحديث الـ Provider قبل الانتقال
      ref.invalidate(currentStudentProvider);
      await ref.read(currentStudentProvider.future);

      if (!mounted) return;
      context.go(AppRoutes.home);
    } catch (e) {
      AppHelpers.showSnackBar(context, message: 'خطأ أثناء الحفظ: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إعداد الملف الشخصي'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildImagePicker(),
              const SizedBox(height: 32),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'الاسم الكامل *', prefixIcon: Icon(Icons.person)),
                validator: (v) => (v == null || v.isEmpty) ? 'الاسم مطلوب' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _studentIdController,
                decoration: const InputDecoration(labelText: 'الرقم الجامعي *', prefixIcon: Icon(Icons.badge)),
                validator: (v) => (v == null || v.isEmpty) ? 'الرقم الجامعي مطلوب' : null,
              ),
              const SizedBox(height: 16),
              _buildDropdowns(),
              const SizedBox(height: 16),
              TextFormField(
                controller: _sectionController,
                decoration: const InputDecoration(labelText: 'الشعبة *', prefixIcon: Icon(Icons.group)),
                validator: (v) => (v == null || v.isEmpty) ? 'الشعبة مطلوبة' : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('بدء استخدام التطبيق'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey[200],
        backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
        child: _selectedImage == null ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey) : null,
      ),
    );
  }

  Widget _buildDropdowns() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: _selectedDepartment,
          decoration: const InputDecoration(labelText: 'القسم *', prefixIcon: Icon(Icons.school)),
          items: AppConstants.departments.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => setState(() => _selectedDepartment = v),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _selectedLevel,
          decoration: const InputDecoration(labelText: 'المستوى *', prefixIcon: Icon(Icons.layers)),
          items: AppConstants.levels.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => setState(() => _selectedLevel = v),
        ),
      ],
    );
  }
}
