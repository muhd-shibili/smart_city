import 'package:freezed_annotation/freezed_annotation.dart';

part 'locality_service_dto.g.dart';
part 'locality_service_dto.freezed.dart';


@freezed
class LocalityServiceDto with _$LocalityServiceDto {

  const factory LocalityServiceDto({required int id}) = _LocalityServiceDto;

  factory LocalityServiceDto.fromJson(Map<String, dynamic> json) => _$LocalityServiceDtoFromJson(json);
}