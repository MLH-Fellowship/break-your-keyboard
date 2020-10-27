// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerModel _$PlayerModelFromJson(Map<String, dynamic> json) {
  return PlayerModel(
    id: json['id'] as String,
    isHost: json['isHost'] as bool,
    name: json['name'] as String,
    clicks: json['clicks'] as int,
    speed: json['speed'] as int,
  );
}

Map<String, dynamic> _$PlayerModelToJson(PlayerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'clicks': instance.clicks,
      'speed': instance.speed,
      'isHost': instance.isHost,
    };
