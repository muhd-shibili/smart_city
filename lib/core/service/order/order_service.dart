import 'dart:isolate';

import 'package:injectable/injectable.dart';
import '../../../utils/helper/response_helper.dart';
import '../../networking/api.dart';
import 'order_service_dto.dart';

@injectable
class OrderService {
  final Api _api;

  OrderService(this._api);

  Future<OrderServiceDto> getOrder() async {
    final response = await _api.httpGet(
        endPath: 'order',
    );
    return Isolate.run(
          () {
        final Map<String, dynamic> responseData =
        ResponseChecker.getSuccessData(
          response: response,
        );

        return OrderServiceDto.fromJson(responseData);
      },
    );
  }

  Future<GetOrderDetailsDTO> getOrderDetails({required String orderId}) async {
    final response = await _api.httpGet(
        endPath: 'order/$orderId',
    );
    return Isolate.run(
          () {
        final Map<String, dynamic> responseData =
        ResponseChecker.getSuccessData(
          response: response,
        );

        return GetOrderDetailsDTO.fromJson(responseData);
      },
    );
  }
}