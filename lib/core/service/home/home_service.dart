import 'dart:isolate';
import 'package:injectable/injectable.dart';

import 'home_service_dto.dart';
import '../../../utils/helper/response_helper.dart';
import '../../networking/api.dart';

@injectable
class HomeService {
  final Api _api;

  HomeService(this._api);

  Future<GetHomeDTO> getHome() async {
    final response = await _api.httpGet(
      endPath: 'home/',
    );

    return Isolate.run(
          () {
        final Map<String, dynamic> responseData =
        ResponseChecker.getSuccessData(
          response: response,
        );

        return GetHomeDTO.fromJson(responseData);
      },
    );
  }
}
