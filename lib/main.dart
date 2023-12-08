// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:nurow_devp/components/variables_constant.dart';
import 'package:nurow_devp/helpers/hive_helper.dart';
import 'package:nurow_devp/models/annot_devices_data_model.dart';
import 'package:nurow_devp/models/devices_data_model.dart';
import 'views/nurow_devices_homepage.dart';
import 'components/mqtt_emqx_funcs.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  mqttConnect();
  await Hive.initFlutter();
  Hive.registerAdapter(AnnotatedDevicesDataAdapter());
  await Hive.openBox<AnnotatedDevicesData>(devicesBox);

  List<AnnotatedDevicesData> existingDevicesList =
      HiveHelper.fetchAllLocallySavedDevices();

  if (existingDevicesList == []) {
    print("Existing messages list is empty");
    myDevices = [];
  } else {
    List<DevicesData> devicesExisting = [];
    for (var dev in existingDevicesList) {
      DevicesData devData = DevicesData(
        deviceID: dev.deviceID,
        deviceName: dev.deviceName,
        isExtensionBox: dev.isExtensionBox,
        deviceStates: dev.isExtensionBox == true ? [0] : [0, 0, 0, 0],
      );
      devicesExisting.add(devData);
    }
    myDevices = devicesExisting;
    print("Total devices retrieved: ${devicesExisting.length}");
  }

  runApp(const NurowApp());
}

class NurowApp extends StatelessWidget {
  const NurowApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
        indicatorColor: Colors.white,
        primaryColorDark: Colors.black26,
        primaryIconTheme: const IconThemeData(
          color: Colors.black,
          opacity: 0.8,
        ),
      ),
      title: "Smart Devices Control",
      home: const NurowDevicesHomepage(),
    );
  }
}
