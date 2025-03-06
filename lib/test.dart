
import 'package:credentialtool_web/presentation/cubit/user_management/cubit/user_management_cubit.dart';
import 'package:credentialtool_web/presentation/pages/user_management/widgets/SearchButton.dart';
import 'package:flutter/material.dart';
import 'package:credentialtool_web/utils/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EmailSearchTextField extends StatefulWidget {
  const EmailSearchTextField({
    super.key, required this.controller,
  });

  final TextEditingController controller;
  @override
  State<EmailSearchTextField> createState() => _EmailSearchTextFieldState();
}
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _EmailSearchTextFieldState extends State<EmailSearchTextField> {

  @override
  void initState() {
    super.initState();
    //widget.controller.text='amarnath.alavandar@zurichna.com';
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      height: 48,
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            SizedBox(
              width: 500,
              height: 48,
              child: TextFormField(
              
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
                      .hasMatch(value)) {
                    return 'Enter a valid email';
                  } 
                  return null;
                },
                controller: widget.controller,
                decoration: InputDecoration(
                  fillColor:ZCTColors.trueWhite,
                  filled: true,
                  alignLabelWithHint: true,
                  labelText: 'Search by email',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelStyle: Theme.of(context).primaryTextTheme.labelMedium,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24)
                 ),
                 hoverColor:  ZCTColors.trueWhite,
                 suffixIcon: widget.controller.text.isEmpty ? const Icon(Icons.search): IconButton(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: widget.controller.clear,
                  icon: const Icon(Icons.clear),
                ) 
                ),
              ),
            ),
            SizedBox(width: 30,),
             /// SEARCH BUTTON
         Searchbutton(
          controller: widget.controller,onPressed:(){
            print('SEARCH PRESSED');
            if (_formKey.currentState?.validate() == true) {
              context.read<UserManagementCubit>().searchUser(widget.controller.text);
            }
          },
          buttonName: 'Search',),
          ],
        ),
       
        
      ),
      
    );
  }
}

