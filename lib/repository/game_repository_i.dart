import '../models/room_model.dart';

abstract class GameRepositoryI {
  Future<bool> doesRoomExists(String code);
  Stream<RoomModel> getRoomStream();
}
