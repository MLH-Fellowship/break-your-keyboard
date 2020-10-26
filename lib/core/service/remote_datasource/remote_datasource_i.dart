import '../../../models/player_model.dart';
import '../../../models/room_model.dart';

abstract class RemoteDataSourceProviderI {
  Future<bool> doesRoomExists(String code);
  Stream<RoomModel> getRoomStream(String code);
  Stream<List<PlayerModel>> getRoomPlayersStream(String code);
}
