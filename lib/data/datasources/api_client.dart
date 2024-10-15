import 'dart:convert';
import 'package:dio/dio.dart';
import '../../presentation/screens/home.dart/home_model.dart';


class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
    ));
  }

  Future<HomeModel> fetchGenres() async {
    try {
      final response = await _dio.get(
        'https://webtoon.p.rapidapi.com/canvas/genres/list?language=en',
        options: Options(
          headers: {
            'x-rapidapi-key':
                "26b01ea0cfmsh2348f15f3f966abp158041jsnd252eda93ce7",
            'x-rapidapi-host': "webtoon.p.rapidapi.com",
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      print("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print(response.data);

        return homeModelFromJson(json.encode(response.data));
      } else if (response.statusCode == 403) {
        throw Exception(
            '403 Forbidden: Check your API key, permissions, or rate limits.');
      } else {
        throw Exception('Failed to load genres: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching genres: $e");
      throw Exception('Failed to load genres');
    }
  }
}
