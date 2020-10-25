import '../service/context/context_provider.dart';
import '../service/context/context_provider_i.dart';
import '../service/error_message/error_message_provider.dart';
import '../service/error_message/error_message_provider_i.dart';
import '../service/remote_datasource/remote_datasource.dart';
import '../service/remote_datasource/remote_datasource_i.dart';
import '../service/router/router.dart';
import '../service/router/router_i.dart';
import 'setup_locator.dart';

void setupServices(){
  sl.registerSingleton<ContextProviderI>(ContextProvider());
  sl.registerLazySingleton<RemoteDataSourceProviderI>(() => RemoteDataSourceProvider());
  sl.registerLazySingleton<RouterI>(() => Router(
    contextProvider: getIts<ContextProviderI>(),
  ));
  sl.registerLazySingleton<ErrorMessageProviderI>(() => ErrorMessageProvider());
}
