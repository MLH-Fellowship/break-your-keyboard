import 'package:json_annotation/json_annotation.dart';

part 'player_model.g.dart';

@JsonSerializable(nullable: false)
class PlayerModel {
  final String id;
  final String name;
  final int clicks;
  final int speed;
  final bool isHost;

  PlayerModel({this.id, this.isHost, this.name, this.clicks, this.speed});
  factory PlayerModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerModelToJson(this);

  PlayerModel copyWith(
      {String id, bool isHost, String name, int clicks, int speed}) {
    return PlayerModel(
      id: id ?? this.id,
      isHost: isHost ?? this.isHost,
      name: name ?? this.name,
      clicks: clicks ?? this.clicks,
      speed: speed ?? this.speed,
    );
  }
}
