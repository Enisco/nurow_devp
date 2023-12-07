import 'package:flutter/material.dart';
import 'package:nurow_devp/components/variables_constant.dart';
import 'package:nurow_devp/models/annot_devices_data_model.dart';
import 'views/nurow_devices_homepage.dart';
import 'components/mqtt_emqx_funcs.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  mqttConnect();
  await Hive.initFlutter();
  Hive.registerAdapter(AnnotatedDevicesDataAdapter());
  await Hive.openBox<AnnotatedDevicesData>(devicesBox);

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
