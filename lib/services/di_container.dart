import 'package:get_it/get_it.dart';
import 'local_persistence_service.dart';
import 'notification_service.dart';

final sl = GetIt.instance;

Future<void> setupDependencyInjection() async {
  sl.registerLazySingleton<LocalPersistenceService>(() => LocalPersistenceService());
  sl.registerLazySingleton<NotificationService>(() => NotificationService());

  final persistence = sl<LocalPersistenceService>();
  await persistence.init();
}
