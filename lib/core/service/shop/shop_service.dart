import 'dart:isolate';
import 'package:injectable/injectable.dart';

import 'shop_service_dto.dart';
import '../../../utils/helper/response_helper.dart';
import '../../networking/api.dart';

@injectable
class ShopServices {
  final Api _api;

  ShopServices(this._api);

  Future<ShopServiceDto> getShops({String? categoryId}) async {
    final response = await _api.httpGet(
      endPath: 'shops/all',
      query: {
        if(categoryId != null) 'categoryId': categoryId,
      }
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

  Future<GetShopDetailsDTO> getShopsDetails({String? shopId}) async {
    final response = await _api.httpGet(
      endPath: 'shops/get/$shopId',
    );

    return Isolate.run(
      () {
        final Map<String, dynamic> responseData =
            ResponseChecker.getSuccessData(
          response: response,
        );

        return GetShopDetailsDTO.fromJson(responseData);
      },
    );
  }


  Future<GetCategoriesDto> getCategory() async {
    final response = await _api.httpGet(
      endPath: 'categories/all',
    );

    return Isolate.run(
      () {
        final Map<String, dynamic> responseData =
            ResponseChecker.getSuccessData(
          response: response,
        );

        return GetCategoriesDto.fromJson(responseData);
      },
    );
  }


  Future<ShopServiceDto> getFavouriteStore() async {
    final response = await _api.httpGet(
      endPath: 'shops/favourites',
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

  Future<void> updateFavoriteStore({required String shopId})async{
    final response = await _api.httpPost(
      endPath: 'shops/favourites',
      body: {
        'shopId': shopId,
      }
    );
  }
}