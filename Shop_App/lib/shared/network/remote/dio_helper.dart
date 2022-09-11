// base url: https://newsapi.org/
// method url: v2/top-headlines?
// query: country=us&category=business&apiKey=64020e99319f4e1a842db534d75fc35e
// https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=25c7d8da7c5d4f31be7da697d8e02066
import 'package:dio/dio.dart';

class DioHelper
{
  static late Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type':'application/json'
        }
      ),
    );

  }

  static Future<Response> getData({
    required String url,
    Map<String , dynamic>? query,
    String lang = 'en',
    String? token='',
  }) async
    {
      dio.options.headers =
      {
        'Content-Type':'application/json',
        'lang':lang,
        'Authorization': token,
      };
      print('token: $token');
      return await dio.get(
        url,
        queryParameters: query,
      );
    }


  static Future<Response> postData({
    required String url,
    Map<String , dynamic>? query,
    required Map<String , dynamic>? data,
    String lang = 'en',
    String? token='',
  }) async
  {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization': token,
    };

    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String , dynamic>? query,
    required Map<String , dynamic>? data,
    String lang = 'en',
    String? token='',
  }) async
  {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization': token,
    };

    return dio.put(
      url,
      queryParameters: query,
      data: data,
      options: Options(

        followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,
      ),
    );
  }
}