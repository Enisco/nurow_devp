// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:nurow_devp/principal_screens/settings_page.dart';
import 'package:nurow_devp/options_screens/about_page.dart';
import 'package:nurow_devp/options_screens/my_hub_page.dart';
import 'package:nurow_devp/devices_list_screen.dart';
import 'package:nurow_devp/components/mqtt_emqx_funcs.dart';

// import 'package:nurow_devp/components/variables_constant.dart';

class NurowDevicesHomepage extends StatefulWidget {
  const NurowDevicesHomepage({Key? key}) : super(key: key);

  @override
  State<NurowDevicesHomepage> createState() => _NurowDevicesHomepageState();
}

class _NurowDevicesHomepageState extends State<NurowDevicesHomepage> {
  int optionValue = 0;

//-----------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    switchState;
    // devicesNames;
    // const AddDevicePage();
  }
//-----------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NUROW"),
        backgroundColor: Colors.purple[700],
        actions: [
          InkWell(
            child: PopupMenuButton(
              //The options button
              // icon: const Icon(Icons.settings),
              color: Colors.purple[300],
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),

              onSelected: (optionValue) {
                //When an option is chosen from the list of pop up items

                if (optionValue == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHubPage()),
                  );
                }

                if (optionValue == 2) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const SmartDevicesPage()),
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
                  // In this case, we need 5 popupmenuItems one for each option.
                  const PopupMenuItem(
                    child: Text(
                      'My Hub',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    value: 1, //value for "onSelected" action
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
                    value: 2, //value for "onSelected" action
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
                    value: 3, //value for "onSelected" action
                  ),
                ];
              },
            ),
          ),

          //Inkwell provides ripple effect, but less functions that gesturedectector widget
          //Here, the FloatingActionButton is embedded into the InkWell widget
          InkWell(
            child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.purple[700],
                elevation: 0.0,
                child: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()),
                  );
                }),
          )
        ],
      ),
      //body of the homepage screen at "DevicesListScreen"
      body: DevicesListScreen(switchStateString: switchState,),
      // body: const AddDevicePage(),
    );
  }
}
