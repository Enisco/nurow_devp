// @dart=2.9

import 'package:flutter/material.dart';
import 'principal_screens/nurow_devices_homepage.dart';
import 'components/mqtt_emqx_funcs.dart';

void main() {
  mqttConnect();
  runApp(const NurowApp());
}

class NurowApp extends StatelessWidget {
  const NurowApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
        indicatorColor: Colors.white,
        primaryColorDark: Colors.black26,
        primaryIconTheme: const IconThemeData(
          color: Colors.black,
          opacity: 0.8,
        ),
      ),
      title: "Smart Devices Control",
      home:
          const NurowDevicesHomepage(), //homepage where available devices will be shown
    );
  }
}
