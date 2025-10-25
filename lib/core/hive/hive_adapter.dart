import 'package:hive/hive.dart';

import '../model/settings/settings_model.dart';
import '../model/user/user_model.dart';

abstract class HiveAdapter {
  static void register() {
    _HiveAdapter.registerAdapter(UserAdapter()); // 0
    _HiveAdapter.registerAdapter(SettingsAdapter()); // 1
  }
}

abstract class _HiveAdapter {
  static void registerAdapter<T>(TypeAdapter<T> adapter) {
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }
  }
}