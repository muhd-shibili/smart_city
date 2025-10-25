import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'core/provider/base/multi_providers.dart' show MultiProviders;
import 'utils/constants/app_typography.dart';
import 'core/hive/hive_adapter.dart';
import 'core/injection/injection.dart';
import 'core/repository/settings_repository.dart';
import 'core/routes/app_router.dart';

Future<void> main() async {
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  await _initialize(binding);

  runApp(MultiProvider(
    providers: MultiProviders.providers,
    child: const MyApp(),
  ));
}

Future<void> _initialize(WidgetsBinding binding) async {
  await Hive.initFlutter();
  HiveAdapter.register();
  await configureInjection();
  await _initializeConfig();
}

Future<void> _initializeConfig() async {
  await locator<SettingsRepository>().init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = locator<AppRouter>();
    return OverlaySupport.global(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
        ),
        child: MaterialApp.router(
          routerConfig: appRouter.config(),
          theme: ThemeData(
            fontFamily: AppTypography.defaultFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, ),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
