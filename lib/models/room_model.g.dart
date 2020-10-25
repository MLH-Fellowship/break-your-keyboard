// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) {
  return RoomModel(
    players: (json['players'] as List)
        .map((e) => PlayerModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    joinCode: json['joinCode'] as String,
    startTime: json['startTime'] as String,
    endTime: json['endTime'] as String,
    duration: json['duration'] as int,
  );
}

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'players': instance.players.map((e) => e.toJson()).toList(),
      'joinCode': instance.joinCode,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'duration': instance.duration,
    };
