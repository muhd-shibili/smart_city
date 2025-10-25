import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_city/core/model/product/product_model.dart';

part 'cart_model.g.dart';
part 'cart_model.freezed.dart';


@freezed
class CartModel with _$CartModel {

const factory CartModel({
  @JsonKey(name: 'storeId') @Default('') String storeId,
  @JsonKey(name: 'tax') @Default(0) double tax,
  @JsonKey(name: 'grandTotalWithTax') @Default(0) double grandTotalWithTax,
  @JsonKey(name: 'discount') @Default(0) double discount,
  @JsonKey(name: 'grandTotal') @Default(0) double grandTotal,
  @JsonKey(name: 'subtotal') @Default(0) double subtotal,
  @JsonKey(name: 'cartItems') @Default([]) List<ProductModel> cartItems,
}) = _CartModel;

factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);
}
/*
  "carts": {
      "cartItems": [
        {
          "quantity": 10,
          "_id": "6794baaaa3b318ff89b96c01",
          "mrp": "67",
          "description": "kashmir",
          "price": "7787",
          "productName": "carrot",
          "image": "uploads\\products\\1737800362177-th.jpg"
        },
      ],
      "subtotal": 1340,
      "grandTotal": 155740,
      "discount": -154400,
      "grandTotalWithTax": 155770,
      "tax": 30
    }
 */