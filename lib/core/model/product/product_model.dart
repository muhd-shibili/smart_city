import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.g.dart';
part 'product_model.freezed.dart';


@freezed
class ProductModel with _$ProductModel {

const factory ProductModel({
  @JsonKey(name: 'image') required String image,
  @JsonKey(name: 'productName') required String productName,
  @JsonKey(name: '_id') required String id,
  @JsonKey(name: 'storeId') @Default('') String storeId,
  @JsonKey(name: 'description') required String description,
  @JsonKey(name: 'mrp') @Default('') String mrp,
  @JsonKey(name: 'price') @Default('') String price,
  @JsonKey(name: 'quantity') @Default(0) int quantity,

}) = _ProductModel;

factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
}