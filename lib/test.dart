import 'package:credentialtool_web/presentation/cubit/user_management/cubit/user_management_cubit.dart';
import 'package:credentialtool_web/presentation/cubit/user_management/cubit/user_management_state.dart';
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
            child: BlocBuilder<UserManagementCubit, UserManagementState>(
              builder: (context, state) {
                switch(state.status){
                  case UserStatus.initial:
                  return  Center(child: Text("Enter a username to search",style: Theme.of(context).textTheme.titleMedium!.copyWith(color:ZCTColors.darkBlue)));
                  case UserStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                  case UserStatus.userloaded:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10,0,0,0),
                        decoration: BoxDecoration(
                          color: ZCTColors.trueWhite,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        height: 60,
                        child:  Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: 300,
                                child: Text("Name",
                                    style:Theme.of(context).primaryTextTheme.titleMedium
                                        ),),
                             SizedBox(
                              width: 350,
                                child: Text("Email",
                                    style:
                                    Theme.of(context).primaryTextTheme.titleMedium)),
                             
                                    SizedBox(
                                      width: 180,
                                child: Text("Device Type",
                                    style:
                                    Theme.of(context).primaryTextTheme.titleMedium)),
                             SizedBox(
                              width: 200,
                                child: Text("Status",
                                    style:
                                    Theme.of(context).primaryTextTheme.titleMedium)),
                             SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5,0,0,0),
                                  child: Text("Actions",
                                      style:
                                      Theme.of(context).primaryTextTheme.titleMedium),
                                )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.userList!.length,
                          itemBuilder: (context, index) {
                            bool isBlue=(index==0);
                            final user = state.userList![index];
                            return Container(
                              padding: EdgeInsets.fromLTRB(10,0,0,0),
                              decoration: BoxDecoration(
                                color: isBlue? ZCTColors.lightBlue.withOpacity(0.2) :ZCTColors.trueWhite,
                                borderRadius: !isBlue? BorderRadius.circular(24):BorderRadius.zero,
                              ),
                              width: 1300,
                              height: 60,
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: 300, child: Text(user.username)),
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
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(user.passStatus,
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
                                        TextButton.icon(
                                          onPressed: () {
                                            context.read<UserManagementCubit>().updateUserStatus(user.passId, user.passStatus,user.deviceType);
                                          },
                                          icon: Icon(user.passStatus=='ACTIVE'? Icons.pause : Icons.play_arrow,
                                              color: Colors.blue),
                                          label:  Text(
                                            user.passStatus=='ACTIVE'? 'Suspend' : 'Resume',
                                          style:Theme.of(context).textTheme.bodyMedium!.copyWith(color:ZCTColors.darkBlue)
                                        ),
                                        ),
                                        const SizedBox(width:15),
                                        TextButton.icon(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.delete_outline_outlined,
                                              color: Colors.redAccent),
                                          label:  Text("Delete",
                                              style:Theme.of(context).textTheme.bodyMedium!.copyWith(color:Colors.redAccent)
                                                  ),
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
                  case UserStatus.error:
                  return Center(
                    child: Text(state.errorMessage ??
                        'ERROR OCCURRED'),
                  );
                }
            }
          ));
     
  }
  /* : const Center(
            child: Text(
              "No Data Available",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ); */
}
