// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annot_devices_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnnotatedDevicesDataAdapter extends TypeAdapter<AnnotatedDevicesData> {
  @override
  final int typeId = 0;

  @override
  AnnotatedDevicesData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnnotatedDevicesData(
      deviceID: fields[1] as String?,
      deviceName: fields[0] as String?,
      isExtensionBox: fields[2] as bool?,
      deviceStates: (fields[3] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, AnnotatedDevicesData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.deviceName)
      ..writeByte(1)
      ..write(obj.deviceID)
      ..writeByte(2)
      ..write(obj.isExtensionBox)
      ..writeByte(3)
      ..write(obj.deviceStates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnnotatedDevicesDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
