
class DevicesData {
  String? deviceName;
  String? deviceID;
  bool? isExtensionBox;
  List<int> deviceStates = [];

  DevicesData({
    required this.deviceID,
    required this.deviceName,
    required this.isExtensionBox,
    required this.deviceStates,
  });

  DevicesData copyWith({
    String? deviceID,
    String? deviceName,
    bool? isExtensionBox,
    List<int>? deviceStates,
  }) =>
      DevicesData(
        deviceID: deviceID ?? this.deviceID,
        deviceName: deviceName ?? this.deviceName,
        isExtensionBox: isExtensionBox ?? this.isExtensionBox,
        deviceStates: deviceStates ?? this.deviceStates,
      );
}
