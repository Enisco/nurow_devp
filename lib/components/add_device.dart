// @dart=2.9
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:nurow_devp/components/variables_constant.dart';
import 'package:nurow_devp/principal_screens/nurow_devices_homepage.dart';
import 'package:nurow_devp/components/mqtt_emqx_funcs.dart';

TextEditingController devNameController = TextEditingController();
TextEditingController devIdController = TextEditingController();
String scannedQRcode;

final List<String> devicesIDs = <String>[];
final List<String> devicesNames = <String>[];
final List<String> devicesStates = <String>[];

// Future<void> scanQR() async {}

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({key}) : super(key: key);

  @override
  _AddDevicePageState createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  // String scanQRcode = 'Unknown';
  // String _scanBarcode = "Unknown";

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      // ignore: avoid_print
      print("qrcode ====> $barcodeScanRes");
      // print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    //barcode scanner flutter ant
    setState(() {
      if (barcodeScanRes.length >= 17 && barcodeScanRes.length < 24) {
        scannedQRcode = barcodeScanRes;
      } else {
        scannedQRcode = " ";
      }
      devIdController.text = scannedQRcode;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // leading: const Icon(Icons.settings),
          title: const Text("Add a Smart Device"),
          backgroundColor: Colors.purple[700],
        ),
        // body:  const DevicesListScreen(),
        body: Stack(
          children: [
            Positioned(
              top: 10.0,
              width: size.width,
              child: InkWell(
                child: TextButton(
                  onPressed: scanQR,
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      height: 120.0,
                      width: size.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.black26, // Set border color
                              width: 3.0), // Set border width
                          borderRadius: const BorderRadius.all(Radius.circular(
                              10.0)), // Set rounded corner radius
                          boxShadow: const [
                            // BoxShadow(
                            //     blurRadius: 10,
                            //     color: Colors.black,
                            //     offset: Offset(1, 3))
                          ] // Make rounded corner of border
                          ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.camera_alt),
                          SizedBox(
                            height: 10.0,
                            width: 10.0,
                          ),
                          Text(
                            "Scan QR Code",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w900,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            //
            Positioned(
              top: 150.0,
              // right: size.width/2,
              child: SizedBox(
                height: 50.0,
                width: size.width,
                child: const Center(
                    child: Text(
                  "OR",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              ),
            ),
            //
            Positioned(
              top: 210.0,
              width: size.width,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                height: 200.0,
                width: size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.black26, // Set border color
                      width: 3.0), // Set border width
                  borderRadius: const BorderRadius.all(
                      Radius.circular(10.0)), // Set rounded corner radius
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          // const Text("Name this device",
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 20.0,
                          //     fontWeight: FontWeight.w400,
                          //   ),),
                          Container(
                            width: size.width - 10,
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              controller: devIdController,
                              maxLength: 23,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Device ID',
                                  hintText: 'Enter the ID on your device'),
                            ),
                          ),
                          //
                          SizedBox(
                            height: 6.0,
                            width: size.width,
                          ),
                          //
                          Container(
                            width: size.width - 10,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            child: TextField(
                              controller: devNameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Device name',
                                hintText: 'Name this device, e.g. Freezer',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        persistentFooterButtons: [
          InkWell(
            child: SizedBox(
              width: size.width - 10.0,
              child: Card(
                color: Colors.purple[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        devicesNames.insert(
                            devicesNames.length, devNameController.text);
                        devicesIDs.insert(
                            devicesIDs.length, devIdController.text);
                        // devicesStates.insert(devicesStates.length, switchState);
                        // ignore: avoid_print
                        print('DevicesState is currently $switchState');
//--------------------------------------------------------------------------
                        devicesIDsTemp = devicesIDs;
                        devicesNamesTemp = devicesNames;
                        devicesStateTemp = devicesStates;

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             const NurowDevicesHomepage()));
                        // Navigator.of(context).pop();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NurowDevicesHomepage()),
                          (Route<dynamic> route) => false,
                        );
                      });
                    },
                    child: const Text("Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
