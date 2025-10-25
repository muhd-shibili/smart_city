import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_city/core/model/settings/settings_model.dart';
import 'package:smart_city/core/model/user/user_model.dart';

import '../routes/app_router.dart';
import 'injection.config.dart';

final GetIt locator = GetIt.instance;

@InjectableInit(generateForDir: ['lib'])
Future<void> configureInjection() async => locator.init();

@module
abstract class RegisterModule {

  @lazySingleton
  AppRouter get instance => AppRouter();

  @lazySingleton
  Dio get dio =>
      Dio()
        ..interceptors.add(LogInterceptor())
        ..httpClientAdapter = Http2Adapter(
          ConnectionManager(idleTimeout: const Duration(seconds: 10)),
        );

  @lazySingleton
  @preResolve
  Future<Box<UserModel>> get userBox => Hive.openBox<UserModel>('user');

  @lazySingleton
  @preResolve
  Future<Box<SettingsModel>> get settingsBox => Hive.openBox<SettingsModel>('settings');
}
