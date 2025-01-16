 Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path.contains(test)) {
      final result = await locator<testDataSource>()
          .getTestAutorizationDetails();
      final headers = <String, dynamic>{};
      if (result?.accessToken != null) {
        headers[accessToken] = result!.accessToken;
      }
      options.headers.addAll(headers);

      if (options.headers['Content-Type'] ==
          'application/x-www-form-urlencoded') {
        options.data = FormData.fromMap(options.data);
      }

      super.onRequest(options,handler);
    }
  }
