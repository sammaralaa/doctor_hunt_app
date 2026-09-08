import 'dart:io';

import 'package:dio/dio.dart';

class CloudinaryServices {
  final Dio _dio = Dio();

  static const String _cloudName = 'ug4exgmz';
  static const String _uploadPreset = 'unspre';

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
      throw Exception('Failed to upload image to Cloudinary: $e');
    }
  }
}