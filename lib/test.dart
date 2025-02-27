import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mattortho_web/screens/desktop/screens/login/authentication_bloc.dart';
import 'package:mattortho_web/screens/home_screen.dart';
import '../../../../shared/snackbar/snack_bar.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/validate_operations.dart';

class DesktopLogin extends StatefulWidget {
  const DesktopLogin({super.key});

  @override

  State<DesktopLogin> createState() => _DesktopLoginState();
}

class _DesktopLoginState extends State<DesktopLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

   return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Row(
        children: [
          /// LEFT SIDE CONTAINER WITH FADE EFFECT
          Container(
            width: width / 2,
            height: height,
            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Stack(
                children: [
                  // Background image with fade effect
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/login_bg.jpg', // Replace with your image path
                      fit: BoxFit.cover, // Ensures the image covers the entire area
                    ),
                  ),
                  // Fade effect overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7), // Start with more opacity at bottom
                            Colors.black.withOpacity(0.5), // Middle opacity
                            Colors.transparent, // Fully transparent at the top
                          ],
                          stops: [0.0, 0.5, 1.0], // Adjust the stops for more control
                        ),
                      ),
                    ),
                  ),
                  // Content goes here
                  Padding(
                    padding: const EdgeInsets.all(80),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/matt_logo.png',
                          scale: 5,
                          colorBlendMode: BlendMode.dstATop,
                        ),
                        const SizedBox(height: 50.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(14)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                color: Colors.transparent,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                            child: Text(
                              splashMessage,
                              style: textTheme.titleMedium!.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// RIGHT SIDE FORM CONTAINER
          Container(
            width: width / 2,
            height: height,
            padding: const EdgeInsets.all(40),
            child: Container(
              padding: const EdgeInsets.only(left: 30, right: 70),
              decoration: const BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.2),
                    // Let's Sign In Text
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Let’s',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: ' Sign In  👇',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontSize: 25.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Email Input Field
                    TextFormField(
                      validator: (value) => ValidateOperations.emailValidation(value),
                      controller: emailIdController,
                      onSaved: (value) {
                        emailIdController.text = value!;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Password Input with Toggle Visibility
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        return TextFormField(
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                          validator: (value) => ValidateOperations.normalValidation(value),
                          obscureText: state is PasswordVisibilityToggled
                              ? state.isObscured
                              : true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon: const Icon(Icons.lock_outline, color: Colors.white),
                            suffixIcon: IconButton(
                              onPressed: () {
                                context.read<AuthenticationBloc>().add(TogglePasswordVisibility());
                              },
                              icon: Icon(
                                state is PasswordVisibilityToggled
                                    ? state.isObscured
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SignInButton(
                      emailIdController: emailIdController,
                      passwordController: passwordController,
                      textTheme: textTheme,
                      formKey: _formKey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}


class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.emailIdController,
    required this.passwordController,
    required this.textTheme, 
    required this.formKey,
  });

  final TextEditingController emailIdController;
  final TextEditingController passwordController;
  final TextTheme textTheme;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final localStorage = GetStorage();

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        if (state is OnFailedValidation) {
          print('Supplied credentials are invalid.');
          showCustomSnackBar(
            context,
            'Username/Password is invalid, Please try again!',
            Icons.warning_amber_outlined,
          );
        } else if (state is OnSuccessfulValidation) {
          print('USER VALIDATION IS SUCCESSFUL');
          final userId = localStorage.read('USERID');
          print('localStorage user id $userId');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const HomeScreen()), // Navigate to HomeScreen
          );
        }
      },
      builder: (context, state) {
        // Check if the user is validating
        final isLoading = state is OnUserValidating;
        return SizedBox(
          height: 50,
          width: 150,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
              ),
            ),
            onPressed: isLoading
                ? null
                : () {
             /* if (formKey.currentState?.validate() == true)*/ {
                context.read<AuthenticationBloc>().add(
                  UserLogin(
                    emailIdController.text.isNotEmpty ? emailIdController.text : 'a@a.com',
                    passwordController.text.isNotEmpty ? passwordController.text : '123456',
                  ),
                );
              }
            },

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        strokeWidth: 3,
                      )
                    : Text(
                        'Sign In',
                        style: textTheme.titleMedium!
                            .copyWith(color: Colors.black),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
