import 'dart:io';

import 'package:dio/dio.dart';

class CloudinaryServices {
  final Dio _dio = Dio();

  static const String _cloudName = 'ug4exgmz';
  static const String _uploadPreset = 'unspre';
  // static final ImagePicker _picker = ImagePicker();

  // static Future<File?> pickProfileImage({ImageSource source = ImageSource.gallery}) async {
  //   final XFile? pickedFile = await _picker.pickImage(
  //     source: source,
  //     maxWidth: 512,
  //     maxHeight: 512,
  //     imageQuality: 80,
  //   );

  //   if (pickedFile == null) return null;
  //   return File(pickedFile.path);
  // }

  Future<String?> uploadImage(File imageFile) async {
    try {
      final String uploadUrl =
          'https://api.cloudinary.com/v1_1/$_cloudName/image/upload';

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path),
        'upload_preset': _uploadPreset,
      });

      final response = await _dio.post(uploadUrl, data: formData);

      if (response.statusCode == 200) {
        return response.data['secure_url'] as String?;
      }
      return null;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}