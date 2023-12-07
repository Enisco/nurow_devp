import 'package:flutter/material.dart';
import 'package:nurow_devp/devices_list_screen.dart';

class SmartDevicesPage extends StatelessWidget {
  const SmartDevicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Smart Devices"),
        backgroundColor: Colors.teal[700],
      ),
      body: const DevicesListScreen(),
    );
  }
}
