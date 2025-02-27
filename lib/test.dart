import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mattortho_web/shared/widgets/header/widgets/elevated_button.dart';
import 'package:mattortho_web/shared/widgets/header/widgets/search_field.dart';
import '../../../../../utils/app_constants.dart';
import '../../../screens/desktop/screens/login/authentication_bloc.dart';
import '../../../screens/desktop/screens/login/desktop_login.dart';
import '../../../screens/desktop/screens/user/user_profile_screen.dart';
import '../../snackbar/snack_bar.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.title,
    this.isSearch = false,
  });

  final String title;
  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
        const Spacer(flex: 2),
        const SizedBox(width: 200, child: MOSearchField()),
        const ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');

    return Container(
        margin: const EdgeInsets.only(left: defaultPadding),
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2D3E),
          // Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10),
        ),
        child: MenuAnchor(
          childFocusNode: _buttonFocusNode,
          menuChildren: <Widget>[
            MenuItemButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const Dialog(
                      child: UserProfileScreen(),
                    );
                  },
                );
              },
              child: const Text('User Profile'),
            ),
            MenuItemButton(
              onPressed: () {
                print('CLICKIN SIGN OUT BUTTON');
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return  AlertDialog(
                        title:
                            const Text('Do you want to exit this application?'),
                        content: const Text('We hate to see you leave...'),
                        backgroundColor: secondaryColor,
                        actions: <Widget>[
                          MOElevatedButton(buttonText: 'No',onPressed: (){Navigator.of(context).pop(true);},),
                          MOElevatedButton(buttonText: 'Yes',onPressed:()
                          {
                            context.read<AuthenticationBloc>().add(UserLogout());
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DesktopLogin()), // Navigate to HomeScreen
                            );
                            showCustomSnackBar(context, 'You have been successfully logged out!',Icons.info_outline
                            );
                          }),
                        ],
                      );
                    });
              },
              child: const Text('Logout'),
            ),
          ],
          builder: (_, MenuController controller, Widget? child) {
            return Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/profile.svg",
                  height: 20,
                  width: 20,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                  child: Text(
                    "Matt User1",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                  focusNode: _buttonFocusNode,
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  icon: const Icon(Icons.more_vert),
                )
              ],
            );
          },
        ));
  }
}

