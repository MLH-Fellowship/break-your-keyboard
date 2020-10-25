// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerModel _$PlayerModelFromJson(Map<String, dynamic> json) {
  return PlayerModel(
    name: json['name'] as String,
    avatar: json['avatar'] as String,
    clicks: json['clicks'] as int,
    speed: json['speed'] as int,
  );
}

Map<String, dynamic> _$PlayerModelToJson(PlayerModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
      'clicks': instance.clicks,
      'speed': instance.speed,
    };
