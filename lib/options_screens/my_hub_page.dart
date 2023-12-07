import 'package:flutter/material.dart';

class MyHubPage extends StatelessWidget {
  const MyHubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(Icons.settings),
        title: const Text("My Hub"),
        backgroundColor: Colors.teal[700],
      ),
    );
  }
}
