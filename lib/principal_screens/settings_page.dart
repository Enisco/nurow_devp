
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(Icons.settings),
        title: const Text("Settings"),
        backgroundColor: Colors.purple[700],
      ),
    );
  }
}
