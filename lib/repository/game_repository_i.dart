abstract class GameRepositoryI {
  Future<bool> doesRoomExists(String code);
  Future<List<dynamic>> getRooms();
}
