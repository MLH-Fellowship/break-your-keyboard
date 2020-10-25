import 'package:cloud_firestore/cloud_firestore.dart';

import 'database_i.dart';

class Database implements DatabaseI {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<bool> roomExists(String code) async {
    final room = await _db.collection('rooms').doc(code).get();
    return room.exists;
    // TODO: check the room's validity by comparing startTime and endTime
  }

  @override
  Future<List> getRooms() {
    // TODO: implement getRooms
    throw UnimplementedError();
  }
}
