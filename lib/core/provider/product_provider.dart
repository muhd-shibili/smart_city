import 'dart:developer';

import 'package:injectable/injectable.dart';
import '../model/banner/banner_model.dart';
import '../model/product/product_model.dart';
import '../service/product/product_service.dart';
import '../../utils/helper/error_manager.dart';
import 'base/base_provider.dart';

@injectable
class ProductProvider extends BaseProvider {
  final ProductService _productServices;
  final ErrorManager _errorManager;

  ProductProvider(this._productServices, this._errorManager);

  List<ProductModel> _products = [];
  List<BannerModel> _banners = [];

  List<BannerModel> get banners => _banners;

  List<ProductModel> get products => _products;


  Future<bool> getStoreProduct(String shopId, String? search) async {
    try {
      setViewBusy();
      final response = await _productServices.getStoreProduct(shopId, search);
      log(response.product.toString(), name: 'products');
      _products = response.product;
      _banners = response.banners;
      return true;
    } catch (e,s) {
      _errorManager.analyticsLog(name: 'getProducts', e: e, s: s);
    } finally {
      setViewIdeal();
    }
    return false;
  }
}
