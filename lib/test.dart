
import 'package:credentialtool_web/data/datasources/remote/api/hid_origo_api.dart';
import 'package:credentialtool_web/domain/models/user_model.dart';
import 'package:credentialtool_web/utils/constants/models/api_response.g.dart';

abstract class OZUserRemoteDataSource {


  Future<User> getUserDetails(String email);

  Future<bool> suspendPass();

  Future<bool> resumePass();

  Future<bool> revokePass();


}

class OZUserRemoteDataSourceImpl implements OZUserRemoteDataSource {


  final ZctHidIOrigoApi api;

  OZUserRemoteDataSourceImpl({required this.api});


  @override
  Future<User> getUserDetails(String email) async {

    final response = await api.getFetchUserPassDetails();
    return response.data.toEmployeeEntity();
    // TODO: implement getUserDetails
  }
  
  @override
  Future<bool> resumePass() {
    // TODO: implement resumePass
    throw UnimplementedError();
  }
  
  @override
  Future<bool> revokePass() {
    // TODO: implement revokePass
    throw UnimplementedError();
  }
  
  @override
  Future<bool> suspendPass() {
    // TODO: implement suspendPass
    throw UnimplementedError();
  }
}


