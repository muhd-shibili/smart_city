import 'package:injectable/injectable.dart';

import 'base/base_provider.dart';

@injectable
class LocalityProvider extends BaseProvider {
  LocalityProvider();

  Future<bool> getLocality() async {
    try {
      setViewBusy();
      return true;
    } catch (e) {
    } finally {
      setViewIdeal();
    }
    return false;
  }
}