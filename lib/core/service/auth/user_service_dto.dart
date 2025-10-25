import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/user/user_model.dart';

part 'user_service_dto.freezed.dart';
part 'user_service_dto.g.dart';

@freezed
class LoginResponseDto with _$LoginResponseDto {
  const factory LoginResponseDto({
    @JsonKey(name: 'userData') required UserModel user,
    @JsonKey(name: 'accessToken') required String token,
}) = _LoginResponseDto;

  factory LoginResponseDto.fromJson(Map<String,dynamic> json) => _$LoginResponseDtoFromJson(json);
}

@freezed
class EditProfileResponseDto with _$EditProfileResponseDto {
  const factory EditProfileResponseDto({
    @JsonKey(name: 'user') required UserModel user,
  }) = _EditProfileResponseDto;

  factory EditProfileResponseDto.fromJson(Map<String,dynamic> json) => _$EditProfileResponseDtoFromJson(json);
}

