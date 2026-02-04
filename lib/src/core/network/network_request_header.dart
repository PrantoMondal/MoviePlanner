import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RequestHeaderInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNGJlMzc5YWUyNmQ1YTQ0Njc5ZDFiY2I4NzFmYjczMSIsIm5iZiI6MTc0ODUxNDMzMy4xNCwic3ViIjoiNjgzODM2MWRkZjg5NWUxZGIxNzMwZjE5Iiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.bngNoU5fayklrrhNxz9NN8xRfMI8aUc_N-hFnsbkrTE';
    options.headers['content-type'] = 'application/json';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      if (kDebugMode) {
        print("Unauthorized request: ${err.requestOptions.uri}");
      }
    } else if (err.response?.statusCode == 500) {
      if (kDebugMode) {
        print("Server error: ${err.requestOptions.uri}");
      }
    }

    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print("Response: ${response.statusCode} ${response.requestOptions.uri}");
    }
    super.onResponse(response, handler);
  }
}
