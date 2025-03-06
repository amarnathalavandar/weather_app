import 'package:credentialtool_web/presentation/cubit/user_management/cubit/user_management_cubit.dart';
import 'package:credentialtool_web/presentation/pages/user_management/widgets/SearchButton.dart';
import 'package:flutter/material.dart';
import 'package:credentialtool_web/utils/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailSearchTextField extends StatefulWidget {
  const EmailSearchTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<EmailSearchTextField> createState() => _EmailSearchTextFieldState();
}

class _EmailSearchTextFieldState extends State<EmailSearchTextField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  bool _showError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    // Clear error when the user taps the text field
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _showError = false;
          _errorMessage = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 636,
      height: 75,
      child: Form(
        key: _formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// EMAIL INPUT FIELD
            SizedBox(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    child: TextFormField(
                      focusNode: _focusNode,
                      controller: widget.controller,
                      decoration: InputDecoration(
                        fillColor: ZCTColors.trueWhite,
                        filled: true,
                        labelText: 'Search by email',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelStyle: Theme.of(context).primaryTextTheme.labelMedium,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        errorText: _showError ? _errorMessage : null,
                        suffixIcon: widget.controller.text.isEmpty
                            ? const Icon(Icons.search)
                            : IconButton(
                                splashColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: widget.controller.clear,
                                icon: const Icon(Icons.clear),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30),

            /// SEARCH BUTTON
            Searchbutton(
              controller: widget.controller,
              onPressed: () {
                final email = widget.controller.text;
                if (email.isEmpty) {
                  setState(() {
                    _showError = true;
                    _errorMessage = 'Please enter your email';
                  });
                  return;
                }
                if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                    .hasMatch(email)) {
                  setState(() {
                    _showError = true;
                    _errorMessage = 'Enter a valid email';
                  });
                  return;
                }

                _showError = false;
                _errorMessage = null;
                context.read<UserManagementCubit>().searchUser(email);
              },
              buttonName: 'Search',
            ),
          ],
        ),
      ),
    );
  }
}
