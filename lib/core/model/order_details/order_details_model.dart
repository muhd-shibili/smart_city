import 'package:freezed_annotation/freezed_annotation.dart';

import '../product/product_model.dart';
import '../shop/shop_model.dart';

part 'order_details_model.g.dart';
part 'order_details_model.freezed.dart';

@freezed
class OrderDetailsModel with _$OrderDetailsModel {

const factory OrderDetailsModel({
  @JsonKey(name: 'orderId') required String id,
  @JsonKey(name: 'orderDate') required String orderdate,
  @JsonKey(name: 'shopDetails') required ShopModel shopDetails,
  @JsonKey(name: 'tax') @Default(0) double tax,
  @JsonKey(name: 'grandTotalWithTax') @Default(0) double grandTotalWithTax,
  @JsonKey(name: 'discount') @Default(0) double discount,
  @JsonKey(name: 'grandTotal') @Default(0) double grandTotal,
  @JsonKey(name: 'subtotal') @Default(0) double subtotal,
  @JsonKey(name: 'products') @Default([]) List<ProductModel> cartItems,
}) = _OrderDetailsModel;

factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => _$OrderDetailsModelFromJson(json);
}