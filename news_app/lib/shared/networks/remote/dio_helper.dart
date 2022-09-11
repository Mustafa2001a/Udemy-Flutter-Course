import 'package:dio/dio.dart';
// base url: https://newsapi.org/
// method url: v2/top-headlines?
// query: country=us&category=business&apiKey=64020e99319f4e1a842db534d75fc35e
// https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=25c7d8da7c5d4f31be7da697d8e02066
class DioHelper
{
  static late Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );

  }

  static Future<Response> getData({
    required String url,
    required Map<String , dynamic> query,
  }) async
    {
      return await dio.get(
        url,
        queryParameters: query,
      );
    }
}