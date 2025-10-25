import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/banner/banner_model.dart';
import '../../model/shop/shop_model.dart';
import '../../model/category/category_model.dart';

part 'home_service_dto.g.dart';
part 'home_service_dto.freezed.dart';


@freezed
class GetHomeDTO with _$GetHomeDTO {

const factory GetHomeDTO({
  @JsonKey(name: 'categories') @Default([]) List<CategoryModel> categories,
  @JsonKey(name: 'banners') @Default([]) List<BannerModel> banners,
  @JsonKey(name: 'shops') @Default([]) List<ShopModel> shops,
}) = _GetHomeDTO;

factory GetHomeDTO.fromJson(Map<String, dynamic> json) => _$GetHomeDTOFromJson(json);
}