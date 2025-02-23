import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserListScreen(),
    );
  }
}

class UserListScreen extends StatelessWidget {
  final List<Map<String, String>> users = [
    {
      "name": "Alexandre Makovetsky",
      "email": "example1@example.com",
      "device": "Apple iPhone",
      "status": "Active"
    },
    {
      "name": "Alexandre Makovetsky",
      "email": "example2@example.com",
      "device": "Apple Watch",
      "status": "Active"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User List")),
      body: users.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // ✅ Header only appears when there is data
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    color: Colors.grey[200],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text("Email", style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text("Device Type", style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),

                  // ✅ ListView.builder inside Expanded
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return Card(
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text(user["name"] ?? "")),
                                Expanded(child: Text(user["email"] ?? "")),
                                Expanded(child: Text(user["device"] ?? "")),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(user["status"] ?? "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () {},
                                        icon: Icon(Icons.pause, color: Colors.blue),
                                        label: Text("Suspend",
                                            style: TextStyle(color: Colors.blue)),
                                      ),
                                      TextButton.icon(
                                        onPressed: () {},
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        label: Text("Delete",
                                            style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Text(
                "No Data Available",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}
