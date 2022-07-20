// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SwitchStatusAdapter extends TypeAdapter<SwitchStatus> {
  @override
  final int typeId = 1;

  @override
  SwitchStatus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SwitchStatus(
      status: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SwitchStatus obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SwitchStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
