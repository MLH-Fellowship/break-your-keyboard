import 'package:get_it/get_it.dart';

import 'setup_repository.dart';
import 'setup_services.dart';
import 'setup_view_models.dart';

GetIt sl = GetIt.instance;

T getIts<T>() => sl.get<T>();

void setupLocator() {
  setupServices();
  setupViewModels();
  setupRepository();
}
