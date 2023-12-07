// ignore_for_file: avoid_print

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nurow_devp/components/variables_constant.dart';
import 'package:nurow_devp/models/annot_devices_data_model.dart';

class HiveHelper {
  static saveDevicesLocally(List<AnnotatedDevicesData> savedDevicessData) {
    // Save data to Hive local storage
    final Box devBox = Hive.box<AnnotatedDevicesData>(devicesBox);

    for (var data in savedDevicessData) {
      devBox.put(data.deviceID, data);
    }
    print("////////------------------------------//////");
  }

  static fetchAllLocallySavedDevices() {
    print('======================Retrieving message Data');
    // Retrieve data from Hive local storage
    final devBox = Hive.box<AnnotatedDevicesData>(devicesBox);
    // Read all data from the box and add to a list
    final List<AnnotatedDevicesData> messagesDataList = devBox.values.toList();

    print('>>>>>>>>>>>>> Rectrieved messageData: ${messagesDataList.length}');
    return messagesDataList;
  }
  /*
*/
}
