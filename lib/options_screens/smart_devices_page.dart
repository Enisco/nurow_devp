import 'package:flutter/material.dart';
// import 'package:nurow_devp/components/variables_constant.dart';
import 'package:nurow_devp/devices_list_screen.dart';
import 'package:nurow_devp/components/mqtt_emqx_funcs.dart';

class SmartDevicesPage extends StatelessWidget {
  const SmartDevicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(Icons.settings),
        title: const Text("My Smart Devices"),
        backgroundColor: Colors.purple[700],
      ),
      body: DevicesListScreen(switchStateString: switchState),
    );
  }
}
