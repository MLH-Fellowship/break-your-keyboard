abstract class DatabaseI {
  Future<bool> roomExists(String code);
  Future<List<dynamic>> getRooms();
}
