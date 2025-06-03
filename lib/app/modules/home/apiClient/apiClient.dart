import 'package:dio/dio.dart';
import '../model/qcard model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.12.61.164:3000/api/card/'));

  Future<QCardModel?> fetchProfile(String cardId) async {
    try {
      final response = await _dio.get('getCardData?cardId=$cardId');
      return QCardModel.fromJson(response.data);
    } catch (e) {
      print('API Error: $e');
      return null;
    }
  }
}

