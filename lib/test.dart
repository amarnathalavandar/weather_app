import 'package:credentialtool_web/domain/repositories/user_management_repository.dart';
import 'package:credentialtool_web/presentation/cubit/user_management/cubit/user_management_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit(this.userManagementRepository) : super(const UserManagementState());

  final UserManagementRepository userManagementRepository;

  // Search for user by email
  Future<void> searchUser(String query) async {
    print('Query: $query');

    emit(state.copyWith(status: UserStatus.loading));

    final userDetailsList = await userManagementRepository.getUserDetailsByEmailId(query);

    emit(state.copyWith(status: UserStatus.userloaded, userList: userDetailsList));
  }

  // Update user status (Suspend/Resume)
  Future<void> updateUserStatus(String passId, String currentStatus, String deviceType) async {
    // Set loading state for status change
    emit(state.copyWith(isStatusLoading: true));

    String newStatus = currentStatus == 'ACTIVE' ? 'SUSPEND' : 'RESUME';
    print('pass id: $passId - deviceType :$deviceType CURRENT: $currentStatus - NEW :$newStatus');

    // Call the repository to toggle the user status
    final isStatusChanged = await userManagementRepository.togglePassStatus(passId, newStatus);
    print("YES STATUS CHANGED: $isStatusChanged");

    if (isStatusChanged) {
      // Update the user status in the user list
      final updatedUserList = List.from(state.userList!); // Make a copy of the user list
      final userIndex = updatedUserList.indexWhere((user) => user.passId == passId);

      if (userIndex != -1) {
        // If the user is found, update their status
        updatedUserList[userIndex] = updatedUserList[userIndex].copyWith(
          passStatus: newStatus,
        );
      }

      // Emit the updated state with the new user list
      emit(state.copyWith(
        isStatusLoading: false,
        userList: updatedUserList, // Set the updated list
        status: UserStatus.userloaded, // Assuming the data was successfully updated
      ));
    } else {
      // Handle failure to change status (e.g., show error)
      emit(state.copyWith(
        isStatusLoading: false,
        errorMessage: 'Failed to update user status.',
      ));
    }
  }
}
