import 'package:injectable/injectable.dart';

import '../../utils/helper/error_manager.dart';
import '../model/cart/cart_model.dart';
import '../service/cart/cart_service.dart';
import 'base/base_provider.dart';

@lazySingleton
class CartProvider extends BaseProvider {
  final ErrorManager _errorManager;
  final CartService _cartService;

  CartProvider(this._errorManager, this._cartService);

  CartModel? _cart;

  CartModel? get cart => _cart;

  bool _placeOrderLoading = false;
  bool _removeFromCartLoading = false;

  bool get placeOrderLoading => _placeOrderLoading;
  bool get removeFromCartLoading => _removeFromCartLoading;

  Future<String?> placeOrder() async {
    try {
      setViewBusy();
      _placeOrderLoading = true;
      final response = await _cartService.placeOrder();
      return response.orderId;
    } catch (e, s) {
      _errorManager.analyticsLog(name: 'placeOrder', e: e, s: s);
    } finally {
      _placeOrderLoading = false;
      setViewIdeal();
    }
    return null;
  }

  Future<bool> getCart() async {
    try {
      setViewBusy();
      final response = await _cartService.getCart();
      _cart = response.cart;
      return true;
    } catch (e, s) {
      _errorManager.analyticsLog(name: 'getCart', e: e, s: s);
    } finally {
      setViewIdeal();
    }
    return false;
  }

  Future<bool> clearCart() async {
    try {
      setViewBusy();
      final response = await _cartService.clearCart();
      _cart = response.cart;
      return true;
    } catch (e, s) {
      _errorManager.analyticsLog(name: 'clearCart', e: e, s: s);
    } finally {
      setViewIdeal();
    }
    return false;
  }

  Future<bool> removeFromCart({required String productId}) async {
    try {
      setViewBusy();
      _removeFromCartLoading = true;
       await _cartService.removeFromCart(productId: productId);
      getCart();
      return true;
    } catch (e, s) {
      _errorManager.analyticsLog(name: 'removeFromCart', e: e, s: s);
    } finally {
      _removeFromCartLoading = false;
      setViewIdeal();
    }
    return false;
  }

  Future<bool> updateProductCount(
      {required String productId,
      required String shopId,
      required String quantity}) async {
    try {
      setViewBusy();
      final response = await _cartService.updateProductCount(
          productId: productId, shopId: shopId, quantity: quantity);
      _cart = response.cart;
      return true;
    } catch (e, s) {
      _errorManager.analyticsLog(name: 'updateProductCount', e: e, s: s);
    } finally {
      setViewIdeal();
    }
    return false;
  }
}
