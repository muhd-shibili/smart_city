import 'dart:isolate';

import 'package:injectable/injectable.dart';

import '../../../utils/helper/response_helper.dart';
import '../../networking/api.dart';
import 'cart_service_dto.dart';

@injectable
class CartService {
  final Api _api;

  CartService(this._api);

  Future<PlaceOrderResponseDTO> placeOrder() async {
    final response = await _api.httpPost(
      endPath: 'order',
    );

    return Isolate.run(
      () {
        final Map<String, dynamic> responseData =
            ResponseChecker.getSuccessData(
          response: response,
        );
        return PlaceOrderResponseDTO.fromJson(responseData);
      },
    );
  }


  Future<GetCartDTO> getCart() async {
    final response = await _api.httpGet(endPath: 'cart');

    return Isolate.run(
      () {
        final Map<String, dynamic> responseData =
            ResponseChecker.getSuccessData(
          response: response,
        );

        return GetCartDTO.fromJson(responseData);
      },
    );
  }

  Future<GetCartDTO> clearCart() async {
    final response = await _api.httpGet(endPath: 'cart/delete-all');

    return Isolate.run(
      () {
        final Map<String, dynamic> responseData =
            ResponseChecker.getSuccessData(
          response: response,
        );

        return GetCartDTO.fromJson(responseData);
      },
    );
  }

  Future<void> removeFromCart({required String productId}) async {
    await _api.httpPost(
      endPath: 'cart/delete-one',
      body: {
        'productId': productId,
      }
    );
  }

  Future<GetCartDTO> updateProductCount(
      {
        required String productId,
      required String shopId,
      required String quantity}) async {
    final response = await _api.httpPost(
        endPath: 'cart', body: {
      'productId': productId,
      'shopId': shopId,
      'quantity': quantity,
    });

    return Isolate.run(
      () {
        final Map<String, dynamic> responseData =
            ResponseChecker.getSuccessData(
          response: response,
        );

        return GetCartDTO.fromJson(responseData);
      },
    );
  }
}
