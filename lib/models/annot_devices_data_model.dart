import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

part 'annot_devices_data_model.g.dart';

@HiveType(typeId: 0)
class AnnotatedDevicesData {
  @HiveField(0)
  String? deviceName;
  @HiveField(1)
  String? deviceID;
  @HiveField(2)
  bool? isExtensionBox;
  @HiveField(3)
  List<int> deviceStates = [];

  AnnotatedDevicesData({
    required this.deviceID,
    required this.deviceName,
    required this.isExtensionBox,
    required this.deviceStates,
  });

  AnnotatedDevicesData copyWith({
    String? deviceID,
    String? deviceName,
    bool? isExtensionBox,
    List<int>? deviceStates,
  }) =>
      AnnotatedDevicesData(
        deviceID: deviceID ?? this.deviceID,
        deviceName: deviceName ?? this.deviceName,
        isExtensionBox: isExtensionBox ?? this.isExtensionBox,
        deviceStates: deviceStates ?? this.deviceStates,
      );
}
