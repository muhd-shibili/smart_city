import 'package:injectable/injectable.dart';
import 'package:smart_city/core/model/order/order_model.dart';

import '../model/order_details/order_details_model.dart';
import 'base/base_provider.dart';
import '../../../utils/helper/error_manager.dart';
import '../service/order/order_service.dart';

@injectable
class OrderProvider extends BaseProvider {
  final ErrorManager _errorManager;
  final OrderService _orderService;

  OrderProvider(this._errorManager, this._orderService);

  OrderDetailsModel? _orderDetail;
  List<OrderModel> _orders = [];

  OrderDetailsModel? get orderDetail => _orderDetail;
  List<OrderModel> get orders => _orders;

  Future<bool> getOrderDetails({required String orderId}) async {
    try {
      setViewBusy();
      final response = await _orderService.getOrderDetails(orderId: orderId);
      _orderDetail = response.orderDetails;
      return true;
    }
    catch (e, s) {
      _errorManager.analyticsLog(name: 'getOrder', e: e, s: s);
    } finally {
      setViewIdeal();
    }
    return false;
  }

  Future<bool> getAllOrders() async {
    try {
      setViewBusy();
      final response = await _orderService.getOrder();
      _orders = response.orders;
      return true;
    }
    catch (e, s) {
      _errorManager.analyticsLog(name: 'getOrder', e: e, s: s);
    } finally {
      setViewIdeal();
    }
    return false;
  }
}