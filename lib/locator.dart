import 'package:get_it/get_it.dart';
import 'package:ioc_app/services/shared_preferences_service.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final sharedPreferencesService = SharedPreferencesService();
  await sharedPreferencesService.ensureInitialized();
  locator.registerSingleton<SharedPreferencesService>(sharedPreferencesService);
}
