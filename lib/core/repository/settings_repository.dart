import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../model/settings/settings_model.dart';

@lazySingleton
class SettingsRepository {
  final Box<SettingsModel> _box;
  final String _boxName = 'settings';

  SettingsRepository(this._box);

  SettingsModel get settings => _box.get(_boxName) ?? const SettingsModel();

  Future<void> init() async {
    if(_box.isEmpty){
      await _save(const SettingsModel());
    }
  }

  Future<void> reset() async => _box.put(
      _boxName,
      settings.copyWith(
        token: '',
        isLoggedIn: false,
      ));

  Future<void> saveToken(String token) {
    return _save(
      settings.copyWith(
        token: token,
        isLoggedIn: token.isNotEmpty,
      ),
    );
  }

  Future<void> _save(SettingsModel user) => _box.put(_boxName, user);
}
