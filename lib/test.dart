import 'package:credentialtool_web/domain/models/user_details_remote_entity.dart';
import 'package:credentialtool_web/utils/constants/models/api_response.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'hid_origo_api.g.dart';


const String baseUrl = "https://blu-sit-apimanagement-middleware.azure-api.net/private/onezurich";


@RestApi(baseUrl:baseUrl) 
abstract class ZctHidIOrigoApi {
  factory ZctHidIOrigoApi(Dio dio) = _ZctHidIOrigoApi;


  @POST("/origohid/v1.0.0/HIDOrigo/FetchUserPassDetails")
  Future<ZCTApiResponse<List<UserDetailsRemoteEntity>>> getFetchUserPassDetails(
    @Body() Map<String, dynamic> body,
    );

  
  @GET("/origohid/v1.0.0/api/Examples")
  Future<void> getExamples(
    
);


  /* @PUT('/suspend')
  Future<List<User>> suspendUserPss();


  @GET("/spotlight/newsfeed-events/{eventId}/likes")
  Future<LikesRemoteEntity> getLikes(
    @Path("eventId") String eventId,
  ); */
}




import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class ZCTApiResponse<T> {
  final T? data;
  final ApiResponseError? error;

  ZCTApiResponse({this.data, this.error});

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
