// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:nurow_devp/components/variables_constant.dart';
import 'package:nurow_devp/helpers/hive_helper.dart';
import 'package:nurow_devp/models/annot_devices_data_model.dart';
import 'package:nurow_devp/models/devices_data_model.dart';
import 'package:nurow_devp/views/nurow_devices_homepage.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({key}) : super(key: key);

  @override
  _AddDevicePageState createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  TextEditingController devNameController = TextEditingController();
  TextEditingController devIdController = TextEditingController();
  String? scannedQRcode;
  bool isExtensionBox = false;
  @override
  void initState() {
    super.initState();
    isExtensionBox = false;
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      print("qrcode ====> $barcodeScanRes");
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    setState(() {
      if (barcodeScanRes.length >= 17 && barcodeScanRes.length < 24) {
        scannedQRcode = barcodeScanRes;
      } else {
        scannedQRcode = " ";
      }
      devIdController.text = scannedQRcode!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add a Smart Device",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.chevron_left_rounded,
                color: Colors.white,
              )),
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 15),
              InkWell(
                child: TextButton(
                  onPressed: scanQR,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    height: 120.0,
                    width: size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 3.0,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          10.0,
                        ),
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.teal,
                        ),
                        SizedBox(
                          height: 10.0,
                          width: 10.0,
                        ),
                        Text(
                          "Scan QR Code",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w900,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50.0,
                width: size.width,
                child: const Center(
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                width: size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 3.0,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Container(
                  width: size.width - 10,
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: devIdController,
                    maxLength: 23,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Device ID',
                      hintText: 'Enter the ID on your device',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 6.0,
                width: size.width,
              ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  Text(
                    "Name your device",
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: devNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Device name',
                    hintText: 'Name this device, e.g. Freezer',
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Is this an Extension Box?",
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Switch(
                    value: isExtensionBox,
                    thumbColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.red;
                      }
                      return Colors.white;
                    }),
                    activeColor: Colors.teal,
                    activeTrackColor: Colors.teal,
                    inactiveThumbColor: Colors.grey,
                    onChanged: (val) {
                      setState(
                        () {
                          isExtensionBox = val;
                        },
                      );
                      print("Is Extension Box: $isExtensionBox");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          InkWell(
            child: SizedBox(
              width: size.width - 10.0,
              child: Card(
                color: Colors.teal[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(
                      () {
                        DevicesData newDevice = DevicesData(
                          deviceID: devIdController.text.trim(),
                          deviceName: devNameController.text.trim(),
                          deviceStates: [0],
                          isExtensionBox: isExtensionBox,
                        );
                        myDevices.add(newDevice);

                        // Save locally
                        List<AnnotatedDevicesData> devicesToSave = [];
                        for (var dev in myDevices) {
                          AnnotatedDevicesData data = AnnotatedDevicesData(
                            deviceID: dev.deviceID,
                            deviceName: dev.deviceName,
                            deviceStates: [0],
                            isExtensionBox: dev.isExtensionBox,
                          );
                          devicesToSave.add(data);
                        }
                        HiveHelper.saveDevicesLocally(devicesToSave);

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NurowDevicesHomepage(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                    );
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
