import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/cart/cart_model.dart';

part 'cart_service_dto.freezed.dart';
part 'cart_service_dto.g.dart';

@freezed
class GetCartDTO with _$GetCartDTO {
  const factory GetCartDTO({
    @JsonKey(name: 'carts') CartModel? cart,
  }) = _GetCartDTO;

  factory GetCartDTO.fromJson(Map<String, dynamic> json) =>
      _$GetCartDTOFromJson(json);
}

@freezed
class PlaceOrderResponseDTO with _$PlaceOrderResponseDTO {
  const factory PlaceOrderResponseDTO({
    @JsonKey(name: 'orderId' ) required String orderId,
  }) = _PlaceOrderResponseDTO;

  factory PlaceOrderResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderResponseDTOFromJson(json);
}
