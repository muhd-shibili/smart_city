import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.g.dart';
part 'category_model.freezed.dart';


@freezed
class CategoryModel with _$CategoryModel {

const factory CategoryModel({
  @JsonKey(name: '_id') required String id,
  @JsonKey(name: 'categoryName') required String categoryName,
  @JsonKey(name: 'image') required String image,
}) = _CategoryModel;

factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
}
