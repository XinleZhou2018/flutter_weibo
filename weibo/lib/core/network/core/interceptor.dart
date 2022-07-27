import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';


class BaseInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
   

    return handler.next(response); // continue
  }

      @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
      // 非200 服务器错误都会走到这

      //     if (err.requestOptions.path == ApiUtil.OPERATE_PLAYER_DATA) {
      //   Map<String, dynamic> jsonData = response.data;
      //   ResponseResult rr = ResponseResult.fromJson(jsonData);
      //   throw APIError(errorCode: rr.code, message: rr.message);
      // }


     super.onError(err, handler);
  }
}
