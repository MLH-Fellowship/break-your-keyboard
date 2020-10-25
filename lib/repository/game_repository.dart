import 'package:flutter/material.dart';

import '../core/service/remote_datasource/remote_datasource_i.dart';
import 'game_repository_i.dart';

class GameRepository implements GameRepositoryI {
  final RemoteDataSourceProviderI remoteDataSource;

  GameRepository({@required this.remoteDataSource});

  @override
  Future<bool> doesRoomExists(String code){
    return remoteDataSource.doesRoomExists(code);
  }

  @override
  Future<List<dynamic>> getRooms(){
    return remoteDataSource.getRooms();
  }
}
