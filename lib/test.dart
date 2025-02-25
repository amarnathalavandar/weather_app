import 'package:credentialtool_web/domain/models/user_details_remote_entity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'hid_origo_api.g.dart';


const String baseUrl = "https://zna-sit-appservice-middleware.azurewebsites.net/HIDOrigo";


@RestApi(baseUrl:baseUrl) 
abstract class ZctHidIOrigoApi {

  factory ZctHidIOrigoApi(Dio dio) = _ZctHidIOrigoApi;


  @POST("/FetchUserPassDetails")
  Future<List<UserDetailsRemoteEntity>> getFetchUserPassDetails(
    @Query("emailAddress") String emailId,
  );

  
  /* @PUT('/suspend')
  Future<List<User>> suspendUserPss();


  @GET("/spotlight/newsfeed-events/{eventId}/likes")
  Future<LikesRemoteEntity> getLikes(
    @Path("eventId") String eventId,
  ); */
}
