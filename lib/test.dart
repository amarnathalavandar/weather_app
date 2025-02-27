   onPressed: () {
                                            context.read<UserManagementCubit>().updateUserStatus(user.passId, user.passStatus,user.deviceType);
                                            //CustomSnackBar.show(context, 'The pass was successfully suspended.');
                                          },
