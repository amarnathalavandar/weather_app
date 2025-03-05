

import 'package:dio/dio.dart';

class HeadersInterceptor extends Interceptor {
  static const String subscriptionKeyHeader = 'Ocp-Apim-Subscription-Key';
  static const String authorizationHeader = 'Authorization';
  static const String timestampHeader = 'Timestamp';

  final versionsPath = '/Versions';

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    print('AMAR  onResponse :reponse :${response.statusCode}');
    print('AMAR  onResponse :reponse :${response.data}');
    print('AMAR  onResponse :reponse :${response.extra}');
    print('AMAR  onResponse :reponse :${response.statusMessage}');
    handler.next(response);
    //return super.onResponse(response,handler);

  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler
  ){
    print('API Rquest failed 1 :${err.requestOptions.uri}');
    print('API Rquest failed 2 :${err.error.toString()}');
    print('API Rquest failed 3:${err.response?.data}');
    handler.next(err);
  }


  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final headers = <String, dynamic>{
      //subscriptionKeyHeader:'6c657d3a94b04387bc68058d43c6250a',
      subscriptionKeyHeader:'77ee0320ff254c62bbd446b0fc0ea61e',
      'Content-Type': 'application/json; charset=UTF-8'
    };
    print('AMAR on request $headers');
    /* if (!options.path.contains(versionsPath)) {
      final result = await locator<AccessTokenRepo>().getAccessToken();

      result.ifSuccess((token) {
        headers[authorizationHeader] = 'bearer ${token.accessToken}';
      });
    } */

    options.headers.addAll(headers);
    if (options.headers['Content-Type'] ==
          'application/x-www-form-urlencoded') {
        options.data = FormData.fromMap(options.data);
      }
      print('AMAR1 on request $headers');

    super.onRequest(options, handler);
  }
}
