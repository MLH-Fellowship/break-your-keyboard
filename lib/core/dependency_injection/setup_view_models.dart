import '../../module/create_game/create_game_view_model.dart';
import '../../module/game/practice_mode/practice_mode_view_model.dart';
import '../../module/home/home_view_model.dart';
import '../../module/join_game/join_game_view_model.dart';
import '../../repository/game_repository_i.dart';
import '../service/error_message/error_message_provider_i.dart';
import '../service/router/router_i.dart';
import 'setup_locator.dart';

void setupViewModels() {
  sl.registerFactory(() => HomeViewModel(
    router: getIts<RouterI>(),
  ));

  sl.registerFactory(() => CreateGameViewModel(
    router: getIts<RouterI>(),
  ));

  sl.registerFactory(() => JoinGameViewModel(
    router: getIts<RouterI>(),
    errorMessageProvider: getIts<ErrorMessageProviderI>(),
    repository: getIts<GameRepositoryI>(),
  ));

  sl.registerFactory(() => PracticeModeViewModel());
}
