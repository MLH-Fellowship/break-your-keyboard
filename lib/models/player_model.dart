import 'package:flutter/material.dart';

@immutable
class PlayerModel {
  final String name;
  final String avatar;

  const PlayerModel({this.name, this.avatar});

  PlayerModel copyWith({String name, String avatar}) {
    return PlayerModel(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }
}
