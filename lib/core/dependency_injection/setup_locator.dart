import 'package:break_your_keyboard/module/create_game/create_game_view_model.dart';
import 'package:get_it/get_it.dart';

import '../../module/home/home_view_model.dart';
import '../service/api/database.dart';
import '../service/api/database_i.dart';
import '../service/context/context_provider.dart';
import '../service/context/context_provider_i.dart';
import '../service/error_message/error_message_provider.dart';
import '../service/error_message/error_message_provider_i.dart';
import '../service/router/router.dart';
import '../service/router/router_i.dart';

GetIt sl = GetIt.instance;

T getIts<T>() => sl.get<T>();

void setupLocator() {
  ///Services
  sl.registerSingleton<ContextProviderI>(ContextProvider());
  sl.registerLazySingleton<DatabaseI>(() => Database());
  sl.registerLazySingleton<RouterI>(() => Router(
        contextProvider: getIts<ContextProviderI>(),
      ));
  sl.registerLazySingleton<ErrorMessageProviderI>(() => ErrorMessageProvider());

  ///View Models
  sl.registerFactory(() => HomeViewModel());
  sl.registerFactory(() => CreateGameViewModel());
}
