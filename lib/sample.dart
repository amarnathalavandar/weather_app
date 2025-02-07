import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Add to Google Wallet')),
        body: Center(
          child: AddToGoogleWalletButton(
            onPressed: () {
              // Handle button press
              print('Add to Google Wallet button pressed');
            },
          ),
        ),
      ),
    );
  }
}

class AddToGoogleWalletButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddToGoogleWalletButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white, // Background color
        onPrimary: Colors.black, // Text color
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/google_wallet_logo.png', // Add your Google Wallet logo asset
            width: 24,
            height: 24,
          ),
          SizedBox(width: 8),
          Text(
            'Add to Google Wallet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
