import 'package:json_annotation/json_annotation.dart';
import 'user_details_remote_entity.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ZCTApiResponse<T> {
  final T? data;
  final ApiResponseError? error;
  final String? timestamp;

  ZCTApiResponse({this.data, this.error, this.timestamp});

  factory ZCTApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ZCTApiResponseFromJson(json, fromJsonT);
}

@JsonSerializable()
class PassesResponse {
  final List<UserDetailsRemoteEntity> passes;

  PassesResponse({required this.passes});

  factory PassesResponse.fromJson(Map<String, dynamic> json) =>
      _$PassesResponseFromJson(json);
}

@JsonSerializable()
class ApiResponseError {
  final String? message;
  final String? stackTrace;

  ApiResponseError({this.message, this.stackTrace});

  factory ApiResponseError.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseErrorFromJson(json);
}





@POST("/origohid/v1.0.0/HIDOrigo/FetchUserPassDetails")
Future<ZCTApiResponse<PassesResponse>> getFetchUserPassDetails(
  @Body() Map<String, dynamic> body,
);
