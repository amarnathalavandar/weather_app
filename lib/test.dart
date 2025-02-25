
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class ZCTApiResponse<T> {
  final bool isError;
  final T? data;
  final ApiResponseError? error;

  ZCTApiResponse({required this.isError, this.data, this.error});

  factory ZCTApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ZCTApiResponseFromJson(json, fromJsonT);
}

@JsonSerializable(createToJson: false)
class ApiResponseError {
  final String message;
  final String stackTrace;

  ApiResponseError({
    this.message = '',
    this.stackTrace = '',
  });

  factory ApiResponseError.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseErrorFromJson(json);
}
