import '../models/player_model.dart';
import '../models/room_model.dart';

abstract class GameRepositoryI {
  Future<bool> doesRoomExists(String code);
  Stream<RoomModel> getRoomStream(String code);
  Stream<List<PlayerModel>> getRoomPlayersStream(String code);

  Future<RoomModel> getRoom(String joinCode);
  Future<PlayerModel> getPlayerById(String joinCode, String playerId);
  Future<Stream<RoomModel>> createRoom(
      {String joinCode, int duration, PlayerModel host});
  Future<Stream<List<PlayerModel>>> addPlayerToRoom(
      {String joinCode, PlayerModel player});

  Future<bool> startGame(String joinCode);
  Future<bool> updateUserClicks(
      {String joinCode, String playerUid, int clicks, int speed});
  Future<bool> resetGame({String joinCode});
}
