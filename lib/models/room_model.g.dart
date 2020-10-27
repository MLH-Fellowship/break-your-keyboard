// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) {
  return RoomModel(
    startTime: json['startTime'] as String,
    endTime: json['endTime'] as String,
    joinCode: json['joinCode'] as String,
    duration: json['duration'] as int,
  );
}

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'joinCode': instance.joinCode,
      'duration': instance.duration,
    };
