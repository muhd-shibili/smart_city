import 'dart:isolate';
import 'package:injectable/injectable.dart';

import 'product_service_dto.dart';
import '../../../utils/helper/response_helper.dart';
import '../../networking/api.dart';

@injectable
class ProductService {
  final Api _api;

  ProductService(this._api);

  Future<GetProductDTO> getStoreProduct(String shopId, String? search) async {
    final response = await _api.httpGet(
      endPath: 'products/all',
      query: {
        'shopId':shopId,
        if(search != null && search.isNotEmpty) 'search' : search,
      }
    );

    return Isolate.run(
          () {
        final Map<String, dynamic> responseData =
        ResponseChecker.getSuccessData(
          response: response,
        );

        return GetProductDTO.fromJson(responseData);
      },
    );
  }

}
