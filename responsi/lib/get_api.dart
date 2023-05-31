import 'package:dio/dio.dart';

class GetApi {
  final dio = Dio();

  getHttp(String api) async {
    final response = await dio.get(api);
    return response.data;
  }
}
