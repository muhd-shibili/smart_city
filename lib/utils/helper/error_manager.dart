import 'dart:developer';

import 'package:injectable/injectable.dart';

@injectable
class ErrorManager {
  void analyticsLog({required String name, required Object? e, required StackTrace? s}) => log(
    '$name ---> ',
    error: e,
    stackTrace: s,
  );
}