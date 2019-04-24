
import 'package:dio/dio.dart';
import 'package:the_fish_fly/common/common_code.dart';

class HttpUtil {
  static HttpUtil instance;
  Dio dio;
  BaseOptions options;

  static HttpUtil getInstance() {
    print('getInstance');
    if (instance == null) {
      instance = new HttpUtil();
    }
    return instance;
  }

  HttpUtil() {
    print('dio赋值');
    options = BaseOptions(
        baseUrl: CommonCode.BASE_URL,
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: {});
    dio = new Dio(options);
  }

  get(url, {data, options}) async {
    print('get请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await dio.get(
          url,
          queryParameters: data
      );
      print('get请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      }
      print('get请求发生错误：$e');
    }
    return response.data;
  }

  post(url, {data, options}) async {
    print('post请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await dio.post(
        url,
        queryParameters: data,
      );
      print('post请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      }
      print('post请求发生错误：$e');
    }
    return response.data;
  }

}