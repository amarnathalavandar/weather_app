
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Flutter Web',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _currentScreen = const HomeScreen();

  void _navigateTo(String screen) {
    setState(() {
      if (screen == 'Home') {
        _currentScreen = const HomeScreen();
      } else if (screen == 'User Management') {
        _currentScreen = const UserManagementScreen();
      } else if (screen == 'Logout') {
        _showLogoutDialog();
      }
    });
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Add logout logic here
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double sidebarWidth = constraints.maxWidth * 0.15;
        double contentWidth = constraints.maxWidth * 0.85;

        if (constraints.maxWidth < 600) {
          // Mobile Layout: Collapsible sidebar
          sidebarWidth = 60;
          contentWidth = constraints.maxWidth - sidebarWidth;
        }

        return Scaffold(
          body: Row(
            children: [
              // Sidebar (Adjustable Width)
              Container(
                width: sidebarWidth,
                color: Colors.blueGrey[900],
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildMenuItem("Home"),
                    _buildMenuItem("User Management"),
                    _buildMenuItem("Logout"),
                  ],
                ),
              ),

              // Main Content (Adjustable Width)
              SizedBox(
                width: contentWidth,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _currentScreen,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(String title) {
    return InkWell(
      onTap: () => _navigateTo(title),
      onHover: (isHovering) {
        setState(() {}); // For hover effect
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Home Screen", style: TextStyle(fontSize: 24)),
    );
  }
}

// User Management Screen
class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("User Management Screen", style: TextStyle(fontSize: 24)),
    );
  }
}
