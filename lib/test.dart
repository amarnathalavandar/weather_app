
import 'dart:io';

import 'package:dio/dio.dart';

class HeadersInterceptor extends Interceptor {
  static const String subscriptionKeyHeader = 'Ocp-Apim-Subscription-Key';
  static const String authorizationHeader = 'Authorization';
  static const String timestampHeader = 'Timestamp';

  final versionsPath = '/Versions';

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final headers = <String, dynamic>{
      subscriptionKeyHeader:'6c657d3a94b04387bc68058d43c6250a',
      timestampHeader: timestamp,
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json; charset=UTF-8',
    };
    print('AMAR on request $headers');
    /* if (!options.path.contains(versionsPath)) {
      final result = await locator<AccessTokenRepo>().getAccessToken();

      result.ifSuccess((token) {
        headers[authorizationHeader] = 'bearer ${token.accessToken}';
      });
    } */

    options.headers.addAll(headers);
    handler.next(options);
  }
  
}
