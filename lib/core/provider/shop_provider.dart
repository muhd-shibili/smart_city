import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../model/category/category_model.dart';
import '../model/shop/shop_model.dart';
import '../service/shop/shop_service.dart';
import '../../utils/helper/error_manager.dart';
import 'base/base_provider.dart';

@injectable
class ShopProvider extends BaseProvider {
  final ShopServices _shopServices;
  final ErrorManager _errorManager;

  ShopProvider(this._shopServices, this._errorManager);

  List<ShopModel> _shops = [];
  ShopModel? _shopDetails;
  bool _isFavoriteLoading = false;
  bool get isFavoriteLoading => _isFavoriteLoading;
  List<CategoryModel> _categories = [];


  List<ShopModel> get shops => _shops;
  ShopModel? get shopDetails => _shopDetails;
  List<CategoryModel> get categories => _categories;


  Future<bool> getShops({String? categoryId}) async {
    try {
      setViewBusy();
      await Future.delayed(const Duration(seconds: 2));
      final response = await _shopServices.getShops(categoryId: categoryId);
      _shops = response.shops;

      return true;
    }
    catch (e,s) {
      _errorManager.analyticsLog(name: 'getShops', e: e, s: s);
    } finally {
      setViewIdeal();
    }
    return false;
  }

  Future<bool> getShopDetails(String shopId) async {
    try {
      setViewBusy();
      await Future.delayed(const Duration(seconds: 2));
      final response = await _shopServices.getShopsDetails(shopId: shopId);
      _shopDetails = response.shop;

      return true;
    }
    catch (e,s) {
      _errorManager.analyticsLog(name: 'getShops', e: e, s: s);
    } finally {
      setViewIdeal();
    }
    return false;
  }

  Future<bool> getCategory() async {
    try {
      setViewBusy();
      final response = await _shopServices.getCategory();
      log(response.categories.toString(), name: 'Categories');
      _categories = response.categories;
      return true;
    } catch (e, s) {
      _errorManager.analyticsLog(name: 'getCategory', e: e, s: s);
    } finally {
      setViewIdeal();
    }
    return false;
  }

  Future<bool> getFavouriteStore() async {
    try {
      setViewBusy();
      final response = await _shopServices.getFavouriteStore();
      _shops = response.shops;

      return true;
    } catch (e,s) {
      _errorManager.analyticsLog(name: 'getFavouriteStore', e: e, s: s);
    } finally {
      setViewIdeal();
    }
    return false;
  }

  Future<bool>addRemoveFavouriteStores(String shopId) async {
    try {
      _isFavoriteLoading = true;
      setViewBusy();
      await _shopServices.updateFavoriteStore(shopId: shopId);
      await getShopDetails(shopId);
      return true;
    } catch (e, s) {
      _errorManager.analyticsLog(name: 'addRemoveFavouriteStores', e: e, s: s);
    } finally {
      _isFavoriteLoading = false;
      setViewIdeal();
    }
    return false;
  }
}
