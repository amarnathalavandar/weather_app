

import 'package:credentialtool_web/domain/models/user_details.dart';
import 'package:equatable/equatable.dart';



enum UserStatus {
  initial,
  loading,
  passesavailable,
  passesunavailable,
  /* resume,
  suspend,
  revoke, */
  error;

  bool get isLoading => this == UserStatus.loading;
  bool get isUserPassesLoaded => this == UserStatus.passesavailable;
  bool get isUserPassesNotAvailable => this == UserStatus.passesunavailable;

  /* bool get isPassResumed => this == UserStatus.resume;
  bool get isPassSuspended=> this == UserStatus.suspend;
  bool get isPassRevoked => this == UserStatus.revoke; */
  bool get isError => this == UserStatus.error;
}

class UserManagementState extends Equatable {

  final UserStatus status;
  final String? errorMessage;
  final List<UserDetailsEntity>? userList;
  final bool userStatusUpdated;
  final String? newPassStatus;
  final bool isPassRevoked;
  final String? actionId;

  
  const UserManagementState({
    this.status = UserStatus.initial,
    this.userList, 
    this.errorMessage,
    this.userStatusUpdated=false,
    this.newPassStatus,
    this.isPassRevoked=false,
    this.actionId
    });


  @override
  List<Object?> get props => [
        status,
        userList, 
        errorMessage,
        actionId
      ];

UserManagementState copyWith({
  UserStatus? status,
  String? errorMessage,
  List<UserDetailsEntity>? userList, 
  String? newPassStatus,
  bool? userStatusUpdated,
  bool? isPassRevoked,
  String? actionId

}) {
  return UserManagementState(
    userList: userList ?? this.userList,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage, 
    userStatusUpdated:userStatusUpdated?? this.userStatusUpdated,
    newPassStatus:newPassStatus?? this.newPassStatus,
    isPassRevoked:isPassRevoked?? this.isPassRevoked,
    actionId:actionId,
  );
}

}

