import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'components/add_device.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'components/single_devices_widget.dart';
import 'package:nurow_devp/components/variables_constant.dart';

int index = 0;
int devicesCount = 0;
String msg = "Devices added";
// final List<String> devicesIDs = <String>[];
// final List<String> devicesNames = <String>[];
// final List<int> msgCount = <int>[];

// ignore: must_be_immutable
class DevicesListScreen extends StatefulWidget {
  String switchStateString;
  DevicesListScreen({Key? key, required this.switchStateString}) : super(key: key);

  @override
  _DevicesListScreenState createState() => _DevicesListScreenState();
}

class _DevicesListScreenState extends State<DevicesListScreen> {
  void addNewDevice() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddDevicePage()));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    devicesIDsTemp = devicesIDs;
    devicesNamesTemp = devicesNames;

    // if (devicesCount == 0) {
    if (devicesIDsTemp.isEmpty) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: "btn1",
          onPressed: () {
            // devicesCount = 1;
            addNewDevice();
          },
          backgroundColor: Colors.purple[700],
          child: const Icon(Icons.add),
        ),
        body: Center(
          child: Text(
            "No $msg",
            style: const TextStyle(
              color: Colors.black26,
            ),
          ),
        ),
      );
    } else {
      return MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              devicesCount = 1;
              addNewDevice();
            },
            backgroundColor: Colors.purple[700],
            child: const Icon(Icons.add),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: devicesNames.length,
                  itemBuilder: (BuildContext context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.purple,
                            width: 1.0),
                      ),
                      child: SizedBox(
                        height: 60.0,
                        width: size.width - 10.0,
                        child: SingleDeviceWidget(
                          deviceName: devicesNames[index],
                          deviceID: devicesIDs[index],
                          // switchState: devicesStateTemp[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

//   A1:B2:C3:D4:E5:F6
