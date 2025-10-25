import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_city/core/model/category/category_model.dart';

import '../../model/shop/shop_model.dart';
part 'shop_service_dto.freezed.dart';
part 'shop_service_dto.g.dart';

@freezed
class ShopServiceDto with _$ShopServiceDto {
  const factory ShopServiceDto({
    @JsonKey(name: 'shops') @Default([]) List<ShopModel> shops,
  }) = _ShopServiceDto;

  factory ShopServiceDto.fromJson(Map<String, dynamic> json) =>
      _$ShopServiceDtoFromJson(json);
}

@freezed
class GetShopDetailsDTO with _$GetShopDetailsDTO {
  const factory GetShopDetailsDTO({
    @JsonKey(name: 'shops') required ShopModel shop,
  }) = _GetShopDetailsDTO;

  factory GetShopDetailsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetShopDetailsDTOFromJson(json);
}

@freezed
class GetCategoriesDto with _$GetCategoriesDto {

const factory GetCategoriesDto({
  @JsonKey(name: 'categories') @Default([]) List<CategoryModel> categories,

}) = _GetCategoriesDto;

factory GetCategoriesDto.fromJson(Map<String, dynamic> json) => _$GetCategoriesDtoFromJson(json);
}