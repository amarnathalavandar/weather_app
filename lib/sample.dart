import 'package:credentialtool_web/domain/models/user_details.dart';
import 'package:credentialtool_web/domain/repositories/user_management_repository.dart';
import 'package:credentialtool_web/presentation/cubit/user_management/cubit/user_management_state.dart';
import 'package:credentialtool_web/presentation/widgets/snackbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit(this.userManagementRepository) : super(const UserManagementState());

  final UserManagementRepository userManagementRepository;

  Future<void> searchUser(String query) async {
    print('Query: $query');

    emit(state.copyWith(status: UserStatus.loading,userStatusUpdated: false,isPassRevoked: false));

  try {
  final userDetailsList = await userManagementRepository.getUserDetailsByEmailId(query);
  userDetailsList.isNotEmpty ?
  emit(state.copyWith(status: UserStatus.passesavailable, userList: userDetailsList)): 
  emit(state.copyWith(status:UserStatus.passesunavailable));

} catch (error,stackTrace) {
  print('ERROR OCCURRED in CUBIT $stackTrace');
  emit(state.copyWith(status: UserStatus.error,
  errorMessage: 'An error occurred. Please try again. If the issue persists, contact your administrator.'));
}
}



Future<void> revokePass(String passId,String emailId) async {
    emit(state.copyWith(status: UserStatus.loading,userStatusUpdated: false));
    print('passId : -$passId');
    try {
  final isDeleted = await userManagementRepository.revokePass(passId);
  print('isDeleted : $isDeleted');
  if(isDeleted) {
    emit(state.copyWith(status: UserStatus.initial,isPassRevoked: true));
  }
} catch (error) {
  print('ERROR OCCURRED in revokePass CUBIT $error');
  emit(state.copyWith(status: UserStatus.error,
  errorMessage: 'An error occurred. Please try again. If the issue persists, contact your administrator.'));}
  }






  Future<void> updateUserStatus(String passId, String currentStatus, String deviceType) async {
    print('DELAY 2..');
    await Future.delayed(const Duration(seconds:2));
    emit(state.copyWith(actionId: passId));
  await Future.delayed(const Duration(seconds:2));
    try {
  String newStatus = currentStatus == 'ACTIVE' ? 'SUSPEND' : 'RESUME';
  print('pass id: $passId - deviceType :$deviceType CURRENT: $currentStatus - NEW :$newStatus');
  //final isStatusChanged = await userManagementRepository.togglePassStatus(passId, newStatus);
  final isStatusChanged=true;
  if (isStatusChanged) {
    print("YES STATUS CHANGED: $isStatusChanged ${state.userList![0].passId}");
    final updatedUserList = List<UserDetailsEntity>.from(state.userList!); 
    final userIndex = updatedUserList.indexWhere((user) => user.passId == passId);
    print('updatedUserList[userIndex] OLD : ${updatedUserList[userIndex].passStatus }');
    print('userIndex:$userIndex');
    if (userIndex != -1) {
      updatedUserList[userIndex] = updatedUserList[userIndex].copyWith(
        passStatus: newStatus = (newStatus == 'RESUME') ? 'ACTIVE' : newStatus
      );
      print('updatedUserList[userIndex] NEW : ${updatedUserList[userIndex].passStatus }');
    }
  
    emit(state.copyWith(
      isStatusLoading: false,
      newPassStatus:newStatus,
      userStatusUpdated:true,
      userList: updatedUserList, 
      status: UserStatus.passesavailable, 
    ));
  } 
} catch (error) {
  print('ERROR OCCURRED in updateUserStatus CUBIT $error');
  emit(state.copyWith(status: UserStatus.error,
  errorMessage: 'An error occurred. Please try again. If the issue persists, contact your administrator.'));}
}
  }
