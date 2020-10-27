import '../../../models/player_model.dart';
import '../../../models/room_model.dart';

abstract class RemoteDataSourceProviderI {
  Future<bool> doesRoomExists(String joinCode);
  Stream<RoomModel> getRoomStream(String joinCode);
  Stream<List<PlayerModel>> getRoomPlayersStream(String joinCode);
  Future<RoomModel> getRoom(String joinCode);
  Future<PlayerModel> getPlayerById(String joinCode, String playerId);
  Future<Stream<RoomModel>> createRoom(
      {String joinCode, int duration, PlayerModel host});
  Future<Stream<List<PlayerModel>>> addPlayerToRoom(
      {String joinCode, PlayerModel player});
  Future<bool> startGame({String joinCode});
}
