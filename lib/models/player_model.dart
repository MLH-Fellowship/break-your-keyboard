import 'package:json_annotation/json_annotation.dart';

part 'player_model.g.dart';

@JsonSerializable(nullable: false)
class PlayerModel {
  final String name;
  final String avatar;
  final int clicks;
  final int speed;

  PlayerModel({this.name, this.avatar, this.clicks, this.speed});
  factory PlayerModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerModelToJson(this);

  PlayerModel copyWith({String name, String avatar, int clicks, int speed}) {
    return PlayerModel(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      clicks: clicks ?? this.clicks,
      speed: speed ?? this.speed,
    );
  }
}
