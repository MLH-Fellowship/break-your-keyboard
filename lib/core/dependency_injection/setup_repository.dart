import '../../repository/game_repository.dart';
import '../../repository/game_repository_i.dart';
import '../service/remote_datasource/remote_datasource_i.dart';
import 'setup_locator.dart';

void setupRepository() {
  sl.registerLazySingleton<GameRepositoryI>(
    () => GameRepository(
      remoteDataSource: getIts<RemoteDataSourceProviderI>(),
    ),
  );
}
