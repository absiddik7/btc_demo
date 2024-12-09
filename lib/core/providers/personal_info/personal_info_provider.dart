import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';

class PersonalInfoProvider with ChangeNotifier {
  // List of avatars
  final List<Map<String, dynamic>> avatars = [
    {'icon': AppAssets.profileImg},
    {'icon': AppAssets.profileImg},
    {'icon': AppAssets.profileImg},
    {'icon': AppAssets.profileImg},
    {'icon': AppAssets.profileImg},
    {'icon': AppAssets.profileImg},
    {'icon': AppAssets.profileImg},
    {'icon': AppAssets.profileImg},
    {'icon': AppAssets.profileImg},
    {'icon': AppAssets.profileImg},
    {'icon': AppAssets.profileImg},
    {'icon': AppAssets.profileImg},
    {'icon': AppAssets.profileImg},
    {'icon': AppAssets.profileImg},
    {'icon': AppAssets.profileImg}
  ];

  int? _selectedAvatarIndex = 0;
  int? get selectedAvatarIndex => _selectedAvatarIndex;

  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  PersonalInfoProvider() {
    _nameController.text = 'Jason Wilson';
  }

  void selectAvatar(int index) {
    _selectedAvatarIndex = index;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _selectedImage = File(image.path);
      notifyListeners();
    }
  }

  Future<void> captureImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _selectedImage = File(image.path);
      notifyListeners();
    }
  }

  void deleteImage() {
    _selectedImage = null;
    notifyListeners();
  }

  void saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      // Add your logic here if needed
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
