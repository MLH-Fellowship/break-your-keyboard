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
  }

  @override
  Stream<List<PlayerModel>> getRoomPlayersStream(String joinCode) {
    final CollectionReference documentRef = FirebaseFirestore.instance
        .collection('rooms')
        .doc(joinCode)
        .collection('players');

    return documentRef.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => PlayerModel.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Stream<RoomModel> getRoomStream(String joinCode) {
    final DocumentReference documentRef =
        FirebaseFirestore.instance.collection('rooms').doc(joinCode);

    return documentRef.snapshots().map((snapshot) {
      return RoomModel.fromJson(snapshot.data());
    });
  }

  @override
  Future<RoomModel> getRoom(String joinCode) async {
    final documentRef =
        FirebaseFirestore.instance.collection('rooms').doc(joinCode);

    final Map<String, dynamic> dataMap = (await documentRef.get()).data();
    return RoomModel.fromJson(dataMap);
  }

  @override
  Future<PlayerModel> getPlayerById(String joinCode, String playerId) async {
    final documentRef = FirebaseFirestore.instance
        .collection('rooms')
        .doc(joinCode)
        .collection('players')
        .doc(playerId);

    final Map<String, dynamic> dataMap = (await documentRef.get()).data();
    return PlayerModel.fromJson(dataMap);
  }

  @override
  Future<Stream<RoomModel>> createRoom(
      {String joinCode, int duration, PlayerModel host}) async {
    final RoomModel roomModel =
        RoomModel(duration: duration, joinCode: joinCode);

    // Create the room
    await FirebaseFirestore.instance
        .collection('rooms')
        .doc(joinCode)
        .set(roomModel.toJson());

    // Fetch the room
    final roomDocumentRef =
        FirebaseFirestore.instance.collection('rooms').doc(joinCode);

    // Add the host to the players collection
    await roomDocumentRef.collection('players').add(host.toJson());

    // Return a stream of the room
    return roomDocumentRef.snapshots().map((snapshot) {
      return RoomModel.fromJson(snapshot.data());
    });
  }

  @override
  Future<Stream<List<PlayerModel>>> addPlayerToRoom(
      {String joinCode, PlayerModel player}) async {
    final CollectionReference documentRef = FirebaseFirestore.instance
        .collection('rooms')
        .doc(joinCode)
        .collection('players');

    await documentRef.add(player.toJson());

    return documentRef.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => PlayerModel.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Future<bool> startGame({String joinCode}) async {
    final documentRef =
        FirebaseFirestore.instance.collection('rooms').doc(joinCode);

    return documentRef
        .update(<String, dynamic>{
          'startTime': DateTime.now().add(const Duration(seconds: 4)).toString()
        })
        .then((value) => true)
        .catchError((dynamic _) => false);
  }
}
