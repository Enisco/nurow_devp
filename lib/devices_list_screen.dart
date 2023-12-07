import 'package:flutter/material.dart';
import 'package:nurow_devp/components/extension_box_widget.dart';
// // // ignore: import_of_legacy_library_into_null_safe
import 'views/add_device.dart';
import 'components/single_devices_widget.dart';
import 'package:nurow_devp/components/variables_constant.dart';

class DevicesListScreen extends StatefulWidget {
  const DevicesListScreen({Key? key}) : super(key: key);

  @override
  _DevicesListScreenState createState() => _DevicesListScreenState();
}

class _DevicesListScreenState extends State<DevicesListScreen> {
  void addNewDevice() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddDevicePage(),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (myDevices.isEmpty) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: "btn1",
          onPressed: () {
            addNewDevice();
          },
          backgroundColor: Colors.teal[700],
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: const Center(
          child: Text(
            "No devices added yet",
            style: TextStyle(
              color: Colors.black26,
            ),
          ),
        ),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              addNewDevice();
            },
            backgroundColor: Colors.teal[700],
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: myDevices.length,
                  itemBuilder: (BuildContext context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.teal.shade200,
                          width: 2.5,
                        ),
                      ),
                      child: SizedBox(
                        // height: 60.0,
                        width: size.width - 10.0,
                        child: myDevices[index].isExtensionBox == true
                            ? ExtensionBoxWidget(
                                deviceName: myDevices[index].deviceName,
                                deviceID: myDevices[index].deviceID,
                              )
                            : SingleDeviceWidget(
                                deviceName: myDevices[index].deviceName,
                                deviceID: myDevices[index].deviceID,
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
