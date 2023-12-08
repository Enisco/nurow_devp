// ignore_for_file: avoid_print

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nurow_devp/components/variables_constant.dart';
import 'package:nurow_devp/models/annot_devices_data_model.dart';

class HiveHelper {
  static saveDevicesLocally(List<AnnotatedDevicesData> savedDevicessData) {
    final Box devBox = Hive.box<AnnotatedDevicesData>(devicesBox);
    for (var data in savedDevicessData) {
      devBox.put(data.deviceID, data);
    }
    print("////////------------------------------//////");
  }

  static fetchAllLocallySavedDevices() {
    print('======================Retrieving devices Data');
    final devBox = Hive.box<AnnotatedDevicesData>(devicesBox);
    final List<AnnotatedDevicesData> deviceDataList = devBox.values.toList();

    print('>>>>>>>>>>>>> Retrieved deviceData: ${deviceDataList.length}');
    return deviceDataList;
  }
}
