import 'package:credentialtool_web/domain/repositories/user_management_repository.dart';
import 'package:credentialtool_web/presentation/cubit/user_management/cubit/user_management_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit(this.userManagementRepository) : super (const UserManagementState());

   //List<User> _allUsers =  List<User>.from(User.predefinedUsers);

   final UserManagementRepository userManagementRepository;


  Future<void> searchUser(String query) async {
    print('Query: $query');

    emit(state.copyWith(status: UserStatus.loading),);

    final userDetailsList = await userManagementRepository.getUserDetailsByEmailId(query);
    
   
    emit(state.copyWith(status: UserStatus.userloaded,userList: userDetailsList),);
  }

  Future<void> updateUserStatus(String passId, String currentStatus,String deviceType) async {
    emit(state.copyWith(isStatusLoading: true),);
    String newStatus='';
    if(currentStatus=='ACTIVE')
    {
      newStatus='SUSPEND';
    }
    else
    {
      newStatus='RESUME';

    }
    print('pass id: $passId - deviceType :$deviceType CURENT: $currentStatus - NEW :$newStatus');
    final isStatusChanged = await userManagementRepository.togglePassStatus(passId,newStatus);
    print("YES STATUS CHANGED :$isStatusChanged");

    /* _allUsers = _allUsers.map((user) {
      if (user.username == username && user.deviceType==deviceType) {
        /// Here just updating user model in place of calling API service to do actual suspend / active
        return User(   
          username: user.username,
          email: user.email,
          deviceType: user.deviceType,
          passStatus: newStatus, 
        );
      }
      return user;
    }).toList();  */
    /* print('Updated Users: ${_allUsers.map((user) =>
    '${user.username} - ${user.email} ${user.deviceType} (${user.passStatus})'
    ).toList()}');


    final filteredUsers = _allUsers
        .where((user) => user.username.toLowerCase().contains(username.toLowerCase()))
        .toList(); */

       emit(state.copyWith(status: UserStatus.userloaded, userList:  []));

  }


}
