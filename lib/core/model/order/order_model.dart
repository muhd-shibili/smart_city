import 'package:freezed_annotation/freezed_annotation.dart';
import '../shop/shop_model.dart';

part 'order_model.g.dart';
part 'order_model.freezed.dart';


@freezed
class OrderModel with _$OrderModel {

const factory OrderModel({
  @JsonKey(name: 'orderId') required String id,
  @JsonKey(name: 'orderdate') required String orderdate,
  @JsonKey(name: 'shopDetails') required ShopModel shopDetails,
  @JsonKey(name: 'amount') required double amount,

}) = _OrderModel;

factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
}

