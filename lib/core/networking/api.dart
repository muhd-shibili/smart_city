import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:smart_city/utils/constants/app_constants.dart';

import '../provider/auth_provider.dart';
import '../repository/settings_repository.dart';
import '../../../utils/snack_bar/snack_bar_alert.dart';
import '../injection/injection.dart';

enum _DialogEnum { notFound, server, socket, timeout, other, custom, unauthorized }

@lazySingleton
class Api {
  final SettingsRepository _settingsRepository;

  static const String _path = 'api/frontend';

  final SnackBarAlert _snackBarAlert;
  final Dio dio;

  String get _token {
    if(_settingsRepository.settings.isLoggedIn) {
      return _settingsRepository.settings.token;
    } else {
      return '';
    }
  }

  Api(this._snackBarAlert, this.dio, this._settingsRepository);

  Map<String, String> get _headers {
    final Map<String, String> head = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    if (_token.isNotEmpty) {
      head.addAll({
        'Authorization': 'Bearer $_token',
        'apikey': '',
      });
    }

    return head;
  }

  final String _baseUrl = AppConstants.baseUrl;

  // void setToken(String token) => _token = token;

  Future<Response?> httpGet({
    required String endPath,
    Map<String, String>? query,
  }) async {
    final Map<String, String> newQuery = query ?? {};

    final Uri uri = Uri.https(_baseUrl, '$_path/$endPath', newQuery);

    developer.log(uri.toString(), name: 'Get - Http');
    developer.log(_headers.toString(), name: 'Get - Header - Http');

    try {
      final response = await dio.getUri(
        uri,
        options: Options(
          headers: _headers,
        ),
      );

      return _handleResponse(response);
    } catch (e, stackTrace) {
      _handleException(e, stackTrace);
    }

    return null;
  }

  Future<Response?> httpPost({
    required String endPath,
    Object? body,
  }) async {
    body ??= {};

    final Map<String, String> newQuery = {};

    final Uri uri = Uri.https(_baseUrl, '$_path/$endPath', newQuery);
    developer.log(
      'URL: ${uri.toString()} \n Body: $body \n Headers: ${jsonEncode(_headers)}',
      name: 'Post - Http',
    );

    try {
      final Response response = await dio.postUri(
        uri,
        data: body,
        options: Options(
          headers: _headers,
        ),
      );

      return _handleResponse(response);
    } catch (e, stackTrace) {
      _handleException(e, stackTrace);
    }

    return null;
  }

  Future<Response?> httpPut({
    required String endPath,
    Object? body,
  }) async {
    body ??= {};

    final Map<String, String> newQuery = {};

    final Uri uri = Uri.https(_baseUrl, '$_path/$endPath', newQuery);
    developer.log(
      'URL: ${uri.toString()} \n Body: $body \n Headers: ${jsonEncode(_headers)}',
      name: 'Put - Http',
    );

    try {
      final Response response = await dio.putUri(
        uri,
        data: body,
        options: Options(
          headers: _headers,
        ),
      );

      return _handleResponse(response);
    } catch (e, stackTrace) {
      _handleException(e, stackTrace);
    }

    return null;
  }

  Future<Response?> httpDelete({
    required String endPath,
    Object? body,
  }) async {
    body ??= {};

    final Map<String, String> newQuery = {};

    final Uri uri = Uri.https(_baseUrl, '$_path/$endPath', newQuery);
    developer.log(
      'URL: ${uri.toString()} \n Body: $body \n Headers: ${jsonEncode(_headers)}',
      name: 'Delete - Http',
    );

    try {
      final Response response = await dio.deleteUri(
        uri,
        data: body,
        options: Options(
          headers: _headers,
        ),
      );

      return _handleResponse(response);
    } catch (e, stackTrace) {
      _handleException(e, stackTrace);
    }

    return null;
  }

  Future<Response?> httpPostWithFile({
    required String endPath,
    required List<File> files,
    required List<String> fileNames,
    Map<String, dynamic>? body,
    bool isPut = false,
  }) async {
    assert(files.length == fileNames.length);
    body ??= {};

    final Uri uri = Uri.https(_baseUrl, '$_path/$endPath');
    developer.log(uri.toString(), name: 'PostFile - Http');
    developer.log('Headers: ${jsonEncode(_headers)}', name: 'Post - Http');

    final Map<String, dynamic> formDataMap = {...body};

    for (int index = 0; index < files.length; index++) {
      final dataHeader = await files[index].readAsBytes();
      final String? mime = lookupMimeType(files[index].path, headerBytes: dataHeader);
      final multipartData = await MultipartFile.fromFile(
        files[index].path,
        contentType: mime != null ? MediaType.parse(mime) : null,
      );
      formDataMap.addAll({fileNames[index]: multipartData});
    }

    developer.log(formDataMap.toString(), name: 'Test');

    try {
      final Response response = await dio.postUri(
        uri,
        data: FormData.fromMap(formDataMap),
        options: Options(headers: _headers, method: isPut ? 'PUT' : 'POST'),
      );

      return _handleResponse(response);
    } catch (e, stackTrace) {
      _handleException(e, stackTrace);
    }

    return null;
  }

  Response? _handleResponse(
      Response response,
      ) {
    developer.log('Status Code: ${response.statusCode}\nBody : ${response.data}', name: 'Http Response');
    if (response.statusCode == null) {
      return null;
    } else if (response.statusCode == 401) {
      _showDialog(_DialogEnum.unauthorized);
      locator<AuthProvider>().unAuthenticatedLogout();

      return null;
    } else if (response.statusCode == 403 || response.statusCode == 404) {
      final Map data = response.data as Map;
      developer.log(data['message']);
      if (response.statusCode == 404 && data['message'] == 'User not found') {
        _showDialog(_DialogEnum.custom, custom: data['message']);
        locator<AuthProvider>().unAuthenticatedLogout();

        return null;
      }

      _showDialog(_DialogEnum.notFound);

      return null;
    } else if (response.statusCode == 422) {
      final Map data = response.data as Map;
      _showDialog(
        _DialogEnum.custom,
        custom: data['message'],
      );

      return null;
    } else if (response.statusCode! >= 500) {
      _showDialog(_DialogEnum.server);

      return null;
    }

    return response;
  }

  void _handleException(
      Object error,
      StackTrace stackTrace,
      ) {
    if (error is SocketException) {
      _showDialog(_DialogEnum.socket);
    } else if (error is TimeoutException) {
      _showDialog(_DialogEnum.timeout);
    } else {
      developer.log('$error', name: 'API Exception', stackTrace: stackTrace);
      _showDialog(_DialogEnum.other);
    }
  }

  void _showDialog(
      _DialogEnum e, {
        String? custom,
      }) {
    switch (e) {
      case _DialogEnum.server:
        _snackBarAlert.showToast(
          message: 'Server is busy. Please try again later.',
        );

      case _DialogEnum.notFound:
        _snackBarAlert.showToast(
          message: 'Page you are looking is not found.',
        );
      case _DialogEnum.socket:
        _snackBarAlert.showToast(
          message: 'No internet connection.',
        );
      case _DialogEnum.timeout:
        _snackBarAlert.showToast(
          message: 'Connection timeout. Please try again later.',
        );
      case _DialogEnum.other:
        _snackBarAlert.showToast(
          message: 'Something went wrong. Please try again later.',
        );
      case _DialogEnum.custom:
        _snackBarAlert.showToast(
          message: custom ?? 'Please enter a valid inputs.',
        );
      case _DialogEnum.unauthorized:
        locator<AuthProvider>().unAuthenticatedLogout();
        _snackBarAlert.showToast(
          message: 'Token expired. Please login again.',
        );
    }
  }
}