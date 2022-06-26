
import 'package:blaghaty/shared/constants.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static Dio? _dio;

  static init() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: ConstantManger.BASE_URL,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      headers: {
        "Authorization":"key=${ConstantManger.ServerKey}",
        "Content-Type":"application/json"
      },
    );
    _dio = Dio(baseOptions);
  }

 /* Future<Response> getData(
      {required path, required Map<String, dynamic> map}) async {
    return await _dio!.get(path, queryParameters: map);
  }*/

  Future<Response> postData({
    required path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    return await _dio!.post(path, queryParameters: query, data: data);
  }

}