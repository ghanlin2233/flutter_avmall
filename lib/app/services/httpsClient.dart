import 'package:dio/dio.dart';

class HttpsClient {
  static String domin = "https://miapp.itying.com/";
  static Dio dio = Dio();

  HttpsClient() {
    dio.options.baseUrl = domin;
    dio.options.connectTimeout = const Duration(milliseconds:5000);
    dio.options.receiveTimeout = const Duration(milliseconds:5000);
  }

  Future get(apiUrl) async {
    try {
      var response = await dio.get(apiUrl);
      return response;
    } catch (e) {
      print("请求超时");
      return null;
    }
  }

  Future post(String apiUrl, {Map? data}) async {
    try {
      var response = await dio.post(apiUrl, data: data);
      return response;
    } catch (e) {
      print("请求超时");
      return null;
    }
  }

  static replaceUri(picUrl){
    String temUrl = domin + picUrl;
    return temUrl.replaceAll(RegExp(r'\\'), '/');
  }
}
