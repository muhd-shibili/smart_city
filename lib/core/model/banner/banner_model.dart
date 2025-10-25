import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner_model.g.dart';
part 'banner_model.freezed.dart';


@freezed
class BannerModel with _$BannerModel {

const factory BannerModel({
  @JsonKey(name: '_id') required String id,
  @JsonKey(name: 'shop') required String shop,
  @JsonKey(name: 'image') required String image,
}) = _BannerModel;

factory BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);
}