// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListItemAdapter extends TypeAdapter<ListItem> {
  @override
  final int typeId = 1;

  @override
  ListItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListItem(
      id: fields[0] as String,
      subject_name: fields[1] as String,
      date: fields[2] as DateTime,
      latitude: fields[3] as double,
      longitude: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ListItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subject_name)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
