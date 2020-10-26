import '../models/player_model.dart';
import '../models/room_model.dart';

abstract class GameRepositoryI {
  Future<bool> doesRoomExists(String code);
  Stream<RoomModel> getRoomStream();
  Stream<List<PlayerModel>> getRoomPlayersStream(String code);
}
