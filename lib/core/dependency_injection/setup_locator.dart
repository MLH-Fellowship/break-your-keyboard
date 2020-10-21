import 'package:get_it/get_it.dart';

import '../service/context/context_provider.dart';
import '../service/context/context_provider_i.dart';
import '../service/router/router.dart';
import '../service/router/router_i.dart';

GetIt sl = GetIt.instance;

T getIts<T>() => sl.get<T>();

void setupLocator() {
  sl.registerSingleton<ContextProviderI>(ContextProvider());
  sl.registerLazySingleton<RouterI>(() => Router(
        contextProvider: getIts<ContextProviderI>(),
      ));
}
