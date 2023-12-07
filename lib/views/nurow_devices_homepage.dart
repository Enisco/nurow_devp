import 'package:flutter/material.dart';
import 'package:nurow_devp/views/settings_page.dart';
import 'package:nurow_devp/options_screens/about_page.dart';
import 'package:nurow_devp/options_screens/my_hub_page.dart';
import 'package:nurow_devp/devices_list_screen.dart';

class NurowDevicesHomepage extends StatefulWidget {
  const NurowDevicesHomepage({Key? key}) : super(key: key);

  @override
  State<NurowDevicesHomepage> createState() => _NurowDevicesHomepageState();
}

class _NurowDevicesHomepageState extends State<NurowDevicesHomepage> {
  int optionValue = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NUROW",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.teal,
        actions: [
          InkWell(
            child: PopupMenuButton(
              color: Colors.teal,
              iconColor: Colors.white,
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onSelected: (optionValue) {
                if (optionValue == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHubPage(),
                    ),
                  );
                }

                if (optionValue == 2) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const SmartDevicesPage(),
                  //   ),
                  // );
                }

                if (optionValue == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                }
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    child: Text(
                      'My Hub',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    value: 1,
                  ),
                  const PopupMenuItem(
                    child: Text(
                      'My Smart Device',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    value: 2,
                  ),
                  const PopupMenuItem(
                    child: Text(
                      'About',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    value: 3,
                  ),
                ];
              },
            ),
          ),
          InkWell(
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              elevation: 0.0,
              child: const Icon(
                Icons.settings,
                color: Colors.teal,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: const DevicesListScreen(),
    );
  }
}
