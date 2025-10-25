import 'package:injectable/injectable.dart';


import '../model/banner/banner_model.dart';
import '../model/shop/shop_model.dart';
import '../model/category/category_model.dart';
import '../service/home/home_service.dart';
import '../../utils/helper/error_manager.dart';

import 'base/base_provider.dart';

@injectable
class HomeProvider extends BaseProvider {
  final HomeService _homeService;
  final ErrorManager _errorManager;

  HomeProvider(this._homeService, this._errorManager);

  List<CategoryModel> _categories = [];
  List<BannerModel> _banners = [];
  List<ShopModel> _shops = [];

  List<CategoryModel> get categories => _categories;
  List<BannerModel> get banners => _banners;
  List<ShopModel> get shops => _shops;

  Future<bool> getHome() async {
    try {
      setViewBusy();
      final response = await _homeService.getHome();
      _categories = response.categories;
      _banners = response.banners;
      _shops = response.shops;

      return true;
    }
    catch (e,s) {
      _errorManager.analyticsLog(name: 'getHome', e: e, s: s);
    } finally {
      setViewIdeal();
    }
    return false;
  }
}