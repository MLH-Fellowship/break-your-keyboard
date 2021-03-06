import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/player_model.dart';
import '../../../models/room_model.dart';
import '../utils/consts.dart';
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
    await roomDocumentRef.collection('players').doc(host.id).set(host.toJson());

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

    await documentRef.doc(player.id).set(player.toJson());

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

    final RoomModel room = await getRoom(joinCode);

    final newStartTime =
        DateTime.now().toUtc().add(const Duration(seconds: Consts.trafficLightDelay));
    final newEndTime = newStartTime.add(Duration(seconds: room.duration));

    print(newStartTime);
    print(newEndTime);

    return documentRef
        .update(<String, dynamic>{
          'startTime': newStartTime.toString(),
          'endTime': newEndTime.toString()
        })
        .then((value) => true)
        .catchError((dynamic _) => false);
  }

  @override
  Future<bool> resetGame({String joinCode}) async {
    final documentRef =
        FirebaseFirestore.instance.collection('rooms').doc(joinCode);

    final players = documentRef.collection('players').get();
    await players.then((value) => value.docs.forEach((element) {
          element.reference.update(<String, dynamic>{'clicks': 0, 'speed': 0});
        }));

    return documentRef
        .update(<String, dynamic>{'startTime': null, 'endTime': null})
        .then((value) => true)
        .catchError((dynamic _) => false);
  }

  @override
  Future<bool> updateUserClicks(
      {String joinCode, String playerUid, int clicks, int speed}) async {
    print('joinCode: $joinCode and player: $playerUid');
    final documentRef = FirebaseFirestore.instance
        .collection('rooms')
        .doc(joinCode)
        .collection('players')
        .doc(playerUid);

    return documentRef
        .update(<String, dynamic>{'clicks': clicks, 'speed': speed})
        .then((value) => true)
        .catchError((dynamic _) => false);
  }
}
