import 'dart:isolate';
import 'package:injectable/injectable.dart';


import '../shop/shop_service_dto.dart';
import '../../../utils/helper/response_helper.dart';
import '../../networking/api.dart';

@injectable
class LocalityService {
  final Api _api;

  LocalityService(this._api);

  Future<ShopServiceDto> getLocality() async {
    final response = await _api.httpGet(
      endPath: 'localities',
    );

    return Isolate.run(
          () {
        final Map<String, dynamic> responseData =
        ResponseChecker.getSuccessData(
          response: response,
        );

        return ShopServiceDto.fromJson(responseData);
      },
    );
  }
}
