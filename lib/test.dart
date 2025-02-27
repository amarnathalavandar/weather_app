import 'package:credentialtool_web/presentation/pages/user_management/widgets/SearchButton.dart';
import 'package:credentialtool_web/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ZCTMenu extends StatelessWidget {
  const ZCTMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode buttonFocusNode = FocusNode(debugLabel: 'Menu Button');
    return Container(
      height: 80,
        margin: const EdgeInsets.only(left: 30),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 30 / 2,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          // Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10),
        ),
        child: MenuAnchor(
          childFocusNode: buttonFocusNode,
          menuChildren: <Widget>[
            MenuItemButton(
              onPressed: () {
                print('CLICKING SIGN OUT BUTTON');
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return  AlertDialog(
                        title:
                        const Text('Do you want to exit this application?'),
                        content: const Text('We hate to see you leave...'),
                        backgroundColor: Colors.white,
                        actions: <Widget>[
                          Searchbutton(onPressed: (){Navigator.of(context).pop(true);}, buttonName: 'No',),
                          Searchbutton(onPressed: (){Navigator.of(context).pop(true);}, buttonName: 'Yes',),
                        ],
                      );
                    });
              },
              child: const Text('Logout'),
            ),
          ],
          builder: (_, MenuController controller, Widget? child) {
            return 
            GestureDetector(
              onTap: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              child: Row(
                children: [
                   SvgPicture.asset(
                    'icons/user_profile.svg',
                  ),
                   const SizedBox(width: 10),
                  Text('System Admin', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ZCTColors.zurichBlue)),
                ],
              ),
            );
            /* Row(
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
            ); */
          },
        ));
  }
}
