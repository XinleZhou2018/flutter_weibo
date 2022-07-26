import 'package:dio/dio.dart';
import 'package:weibo/core/network/core/interceptor.dart';

enum RequestProtocolType {
  https,
  http,
  ftp,
}

Dio? dio;
Dio? baiduDio;

class DioBuilder {
  BaseOptions? options;

  String protocol = "http";

  String baseUrl = "localhost";

  Map<String, dynamic> headers = {};

  /// 连接服务器超时时间，单位是毫秒
  int connectTimeout = 60 * 1000;

  /// 代理地址
  String proxyHost = "";
  String proxyPort = "";

  List<Interceptor> interceptors = [];

  DioBuilder setProtocol(RequestProtocolType protocolType) {
    switch (protocolType) {
      case RequestProtocolType.ftp:
        protocol = "ftp";
        break;
      case RequestProtocolType.https:
        protocol = "https";
        break;
      default:
        protocol = "http";
    }
    return this;
  }

  DioBuilder setBaseUrl(String baseUrl) {
    this.baseUrl = baseUrl;
    return this;
  }

  DioBuilder setHeaders(Map<String, dynamic> headers) {
    headers.forEach((String key, dynamic value) {
      this.headers[key] = value;
    });
    return this;
  }

  DioBuilder setConnectTimeout(int connectTimeout) {
    this.connectTimeout = connectTimeout;
    return this;
  }

  DioBuilder addInterceptor(Interceptor interceptor) {
    interceptors.add(interceptor);
    return this;
  }

  DioBuilder addProxy(String proxyHost, String proxyPort) {
    this.proxyHost = proxyHost;
    this.proxyPort = proxyPort;
    return this;
  }

  build() {
    options = BaseOptions(
        baseUrl: "$protocol://$baseUrl",
        connectTimeout: connectTimeout,

        /// [如果返回数据是json(content-type)，dio默认会自动将数据转为json，无需再手动转](https://github.com/flutterchina/dio/issues/30)
        responseType: ResponseType.json,

        ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
        ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
        ///  注意: 这并不是接收数据的总时限.
        receiveTimeout: connectTimeout,
        headers: headers,
        contentType: Headers.jsonContentType);
    dio = Dio(options);

    interceptors.add(BaseInterceptor());

    for (Interceptor element in interceptors) {
      dio!.interceptors.add(element);
    }
  }
}
