import 'package:flutter/material.dart';
import 'okta_auth_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final OktaAuthService _authService = OktaAuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Okta Web',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Okta Web'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await _authService.login();
            },
            child: Text('Login with Okta'),
          ),
        ),
      ),
    );
  }
}