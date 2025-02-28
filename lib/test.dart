Future<void> updateUserStatus(String passId, String currentStatus, String deviceType) async {
  
    emit(state.copyWith(actionId: passId));
  await Future.delayed(const Duration(seconds:5));
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
  emit(state.copyWith(status: UserStatus.eimport 'package:credentialtool_web/presentation/cubit/user_management/cubit/user_management_cubit.dart';
import 'package:credentialtool_web/presentation/cubit/user_management/cubit/user_management_state.dart';
import 'package:credentialtool_web/presentation/pages/user_management/widgets/SearchButton.dart';
import 'package:credentialtool_web/presentation/widgets/snackbar.dart';
import 'package:credentialtool_web/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersList extends StatelessWidget {
  UsersList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        width: 1300,
        decoration: BoxDecoration(
          color: ZCTColors.trueWhite,
          borderRadius: BorderRadius.circular(24),
        ),
        child: BlocConsumer<UserManagementCubit, UserManagementState>(
            listener: (context, state) {
          print('userStatusUpdated:: ${state.userStatusUpdated}');
          print('newPassStatus:: ${state.newPassStatus}');
          if (state.userStatusUpdated) {
            if (state.newPassStatus == 'ACTIVE')
              CustomSnackBar.show(
                  context, "The pass was successfully resumed.", Colors.green);
            if (state.newPassStatus == 'SUSPEND')
              CustomSnackBar.show(context,
                  "The pass was successfully suspended.", Colors.green);
          } else if (state.status == UserStatus.error) {
            CustomSnackBar.show(context, state.errorMessage!, ZCTColors.peachAA);
          } else if (state.isPassRevoked)
            CustomSnackBar.show(
                context, "The pass was successfully deleted.", Colors.green);
        }, builder: (context, state) {
          print('state: ${state.status}');
          switch (state.status) {
            case UserStatus.initial:
              return Center(
                  child: Text("Search for a user to manage their credentials",
                      style: Theme.of(context).primaryTextTheme.displayMedium));
            case UserStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case UserStatus.passesavailable:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    decoration: BoxDecoration(
                      color: ZCTColors.trueWhite,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    height: 60,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: 300,
                          child: Text("Name",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium),
                        ),
                        SizedBox(
                            width: 350,
                            child: Text("Email",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium)),
                        SizedBox(
                            width: 180,
                            child: Text("Device Type",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium)),
                        SizedBox(
                            width: 200,
                            child: Text("Status",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium)),
                        SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text("Actions",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium),
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.userList!.length,
                      itemBuilder: (context, index) {
                        bool isBlue = (index == 0);
                        final user = state.userList![index];
                        return Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          decoration: BoxDecoration(
                            color: isBlue
                                ? ZCTColors.lightBlue.withOpacity(0.2)
                                : ZCTColors.trueWhite,
                            borderRadius: !isBlue
                                ? BorderRadius.circular(24)
                                : BorderRadius.zero,
                          ),
                          width: 1300,
                          height: 60,
                          child: Row(
                            children: [
                              SizedBox(width: 300, child: Text(user.username)),
                              SizedBox(width: 350, child: Text(user.email)),
                              SizedBox(
                                  width: 180, child: Text(user.deviceType)),
                              SizedBox(
                                width: 200,
                                height: 24,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: user.passStatus == 'ACTIVE'
                                            ? Colors.green
                                            : Colors.red,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                            user.passStatus == 'ACTIVE'
                                                ? 'Active'
                                                : 'Suspended',
                                            style: const TextStyle(
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    state.actionId==user.passId
                                        ? const Center(
                                            child: SizedBox(width:15,height:15,child: CircularProgressIndicator(strokeWidth: 2,)))
                                        : TextButton.icon(
                                            onPressed: () async {
                                              context
                                                  .read<UserManagementCubit>()
                                                  .updateUserStatus(
                                                      user.passId,
                                                      user.passStatus,
                                                      user.deviceType);
                                            },
                                            icon: Icon(
                                                user.passStatus == 'ACTIVE'
                                                    ? Icons.pause
                                                    : Icons.play_arrow,
                                                color: Colors.blue),
                                            label: Text(
                                                user.passStatus == 'ACTIVE'
                                                    ? 'Suspend'
                                                    : 'Resume',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: ZCTColors
                                                            .darkBlue)),
                                          ),
                                    const SizedBox(width: 15),
                                    TextButton.icon(
                                      onPressed: () {
                                        showRevokeConfirmationDialog(
                                            context, user.passId, user.email);
                                      },
                                      icon: const Icon(
                                          Icons.delete_outline_outlined,
                                          color: Colors.redAccent),
                                      label: Text("Delete",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: Colors.redAccent)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            case UserStatus.passesunavailable:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    "We\’re sorry, but we couldn\’t find any matches for your search. ",
                    style: Theme.of(context).primaryTextTheme.displayMedium,
                  )),
                  Center(
                      child: Text(
                    "Check for spelling errors and try again.",
                    style: Theme.of(context).primaryTextTheme.displayMedium,
                  ))
                ],
              );
            case UserStatus.error:
              return Center(
                child: Text(
                    state.errorMessage ?? 'Uknown Error Occurred!,Try again.',style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(color:ZCTColors.peachAA),),
              );
          }
        }));
  }
  /* : const Center(
            child: Text(
              "No Data Available",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
  ); */

  void showRevokeConfirmationDialog(
      BuildContext context, String passID, String emailId) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: Container(
              width: 540,
              height: 230,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Are you sure?',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .labelMedium!
                            .copyWith(
                                fontSize: 24, fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'This action can\'t be undone. Do you still want to delete this?',
                      style: Theme.of(context).primaryTextTheme.labelMedium,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Searchbutton(
                          labelColor: ZCTColors.darkBlue,
                          buttonHeight: 56,
                          buttonWidth: 101,
                          color: Colors.white,
                          buttonRadius: 36,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          buttonName: 'Cancel',
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Searchbutton(
                          buttonHeight: 56,
                          buttonWidth: 101,
                          color: Colors.red,
                          buttonRadius: 36,
                          onPressed: () {
                            context
                                .read<UserManagementCubit>()
                                .revokePass(passID, emailId);
                            Navigator.of(context).pop();
                          },
                          buttonName: 'Delete',
                        ),
                      ],
                    )
                  ]),
            ));
      },
    );
  }
}
rror,
  errorMessage: 'An error occurred. Please try again. If the issue persists, contact your administrator.'));}
}



