abstract class RemoteDataSourceProviderI {
  Future<bool> doesRoomExists(String code);
  Future<List<dynamic>> getRooms();
}
