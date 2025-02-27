import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SnackBarDemo(),
    );
  }
}

class SnackBarDemo extends StatelessWidget {
  void _showSnackBar(BuildContext context) {
    var snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - kToolbarHeight - 80, // 30px below AppBar
        left: 20,
        right: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: Colors.red, // Set background color
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.error_outline, color: Colors.white),
          Expanded(
            child: Text(
              "Error occurred, please try again later",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
      duration: Duration(seconds: 2), // Auto dismiss after 2 seconds
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Floating SnackBar Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showSnackBar(context),
          child: Text('Show SnackBar'),
        ),
      ),
    );
  }
}
