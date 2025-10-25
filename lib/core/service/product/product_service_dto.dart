import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_city/core/model/banner/banner_model.dart';

import '../../model/product/product_model.dart';

part 'product_service_dto.g.dart';
part 'product_service_dto.freezed.dart';


@freezed
class GetProductDTO with _$GetProductDTO {

const factory GetProductDTO({
  @JsonKey(name: 'products') required List<ProductModel> product,
  @JsonKey(name: 'banner') required List<BannerModel> banners,
}) = _GetProductDTO;

factory GetProductDTO.fromJson(Map<String, dynamic> json) => _$GetProductDTOFromJson(json);
}