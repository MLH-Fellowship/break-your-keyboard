import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/player_model.dart';
import '../../../models/room_model.dart';
import 'remote_datasource_i.dart';

class RemoteDataSourceProvider implements RemoteDataSourceProviderI {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<bool> doesRoomExists(String code) async {
    final room = await _db.collection('rooms').doc(code).get();
    return room.exists;
    // TODO: check the room's validity by comparing startTime and endTime
  }

  @override
  Stream<List<PlayerModel>> getRoomPlayersStream(String code) {
    final documentStream = FirebaseFirestore.instance
        .collection('rooms')
        .doc('E8tuS5FFB32Umj2B7N9I').collection('players');
    return documentStream.snapshots().map((event) {
      print(event.docs.map((e) => e.data()));
      return event.docs.map((e) => PlayerModel.fromJson(e.data())).toList();
    });
  }

  @override
  Stream<RoomModel> getRoomStream(String code) {
    final documentStream = FirebaseFirestore.instance
        .collection('rooms')
        .doc('E8tuS5FFB32Umj2B7N9I');
    return documentStream.snapshots().map((event) {
      print(event.data().toString());
      return RoomModel.fromJson(event.data());
    });
  }
}
