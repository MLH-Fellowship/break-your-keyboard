import 'package:flutter/material.dart';

import '../core/service/remote_datasource/remote_datasource_i.dart';
import '../models/player_model.dart';
import '../models/room_model.dart';
import 'game_repository_i.dart';

// TODO: This middleman-class is super repetitive.
// Needs refactoring, or completely getting rid of.

class GameRepository implements GameRepositoryI {
  final RemoteDataSourceProviderI remoteDataSource;
  String currentRoomCode;
  PlayerModel currentModel;

  GameRepository({@required this.remoteDataSource});

  @override
  Future<bool> doesRoomExists(String code) {
    return remoteDataSource.doesRoomExists(code);
  }

  @override
  Stream<RoomModel> getRoomStream(String code) {
    return remoteDataSource.getRoomStream(code);
  }

  @override
  Stream<List<PlayerModel>> getRoomPlayersStream(String code) {
    return remoteDataSource.getRoomPlayersStream(code);
  }

  @override
  Future<RoomModel> getRoom(String joinCode) async {
    return remoteDataSource.getRoom(joinCode);
  }

  @override
  Future<PlayerModel> getPlayerById(String joinCode, String playerId) async {
    return remoteDataSource.getPlayerById(joinCode, playerId);
  }

  @override
  Future<Stream<RoomModel>> createRoom(
      {String joinCode, int duration, PlayerModel host}) async {
    return remoteDataSource.createRoom(
        joinCode: joinCode, duration: duration, host: host);
  }

  @override
  Future<Stream<List<PlayerModel>>> addPlayerToRoom(
      {String joinCode, PlayerModel player}) async {
    return remoteDataSource.addPlayerToRoom(joinCode: joinCode, player: player);
  }

  @override
  Future<bool> startGame(String joinCode) {
    return remoteDataSource.startGame(joinCode: joinCode);
  }

  @override
  Future<bool> updateUserClicks(
      {String joinCode, String playerUid, int clicks, int speed}) {
    return remoteDataSource.updateUserClicks(
      joinCode: joinCode,
      clicks: clicks,
      playerUid: playerUid,
      speed: speed,
    );
  }
}
