import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:smart_city/core/provider/cart_provider.dart';

import '../../utils/helper/error_manager.dart';
import '../../utils/snack_bar/snack_bar_alert.dart';
import '../injection/injection.dart';
import '../model/user/user_model.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';
import '../routes/app_router.dart';
import '../routes/app_router.gr.dart';
import '../service/auth/auth_services.dart';
import 'base/base_provider.dart';

@lazySingleton
class AuthProvider extends BaseProvider {
  final AuthServices _authServices;
  final ErrorManager _errorManager;
  final SettingsRepository _settingsRepository;
  final SnackBarAlert _snackBarAlert;
  final UserRepository _userRepository;
  final AppRouter _appRouter;

  AuthProvider(
    this._authServices,
    this._errorManager,
    this._snackBarAlert,
    this._userRepository,
    this._appRouter,
    this._settingsRepository,
  );

  UserModel? _user;

  UserModel? get user {
    _user ??= _userRepository.user;
    if (_user == null) {
      logout();
      return null;
    }
    return _user;
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      setViewBusy();
      final response = await _authServices.login(
        email: email,
        passWord: password,
      );

      _userRepository.save(response.user);
      _settingsRepository.saveToken(response.token);
      _user = response.user;

      _snackBarAlert.showToast(message: 'Login Successful');
      await startApp();
      return true;
    } catch (e, s) {
      _errorManager.analyticsLog(name: 'Login', e: e, s: s);
    } finally {
      setViewIdeal();
    }
    return false;
  }

  Future<void> getUser() async {
    try {
      setViewBusy();
      _user = _userRepository.user;
      if(_user == null){
        unAuthenticatedLogout();
      }
    } catch (e,s){
      _errorManager.analyticsLog(name: 'getUser', e: e, s: s);
    } finally {
      setViewIdeal();
    }
  }

  Future<bool> register({
    required String name,
    required String number,
    required String email,
    required String passWord,
    // required String state,
    // required String district,
    // required String locationId,
  }) async {
    try {
      setViewBusy();
      await _authServices.register(
        name: name,
        number: number,
        email: email,
        passWord: passWord,
        // state: state,
        // district: district,
        // locationId: locationId,
      );
      return true;
    } catch (e, s) {
      _errorManager.analyticsLog(name: 'register', e: e, s: s);
    } finally {
     await  startApp();
      setViewIdeal();
    }
    return false;
  }

  void editProfile({
    required String name,
    required String email,
    required String number,
    required String dob,
    required String gender,
  }) async {
    try {
      setViewBusy();
      final user = await _authServices.editProfile(
        name: name,
        email: email,
        number: number,
        dob: dob,
        gender: gender,
      );
      _userRepository.save(user.user);
    } catch (e, s) {
      _errorManager.analyticsLog(name: 'editProfile', e: e, s: s);
    } finally {
      setViewIdeal();
    }
  }

  Future<bool> logout() async {
    try {
      setViewBusy();
      log('Logout', name: 'User');
      await _userRepository.reset();
      await _settingsRepository.reset();
      return true;
    } catch (e, s) {
      _errorManager.analyticsLog(name: 'Logout', e: e, s: s);
    } finally {
     await startApp();
      setViewIdeal();
    }
    return false;
  }

  Future<void> unAuthenticatedLogout() async {
    if (_settingsRepository.settings.isLoggedIn) {
      await logout();
    }
  }

  Future<void> startApp() async {
    if (_settingsRepository.settings.isLoggedIn) {
      _user = _userRepository.user;
      _appRouter.replaceAll([const HomeRoute()]);
      await locator<CartProvider>().getCart();
    } else {
      _appRouter.replaceAll([const LoginRoute()]);
    }
  }
}
