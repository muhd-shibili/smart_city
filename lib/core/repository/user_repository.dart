import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../model/user/user_model.dart';

@lazySingleton
class UserRepository {
  final Box<UserModel> _box;
  final String _boxName = 'user';

  UserRepository(this._box);

  UserModel? get user => _box.get(_boxName);

  Future<void> reset() async => _box.clear();

  Future<void> save(UserModel user) => _box.put(_boxName, user);
}
