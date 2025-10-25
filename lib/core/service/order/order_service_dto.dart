import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_city/core/model/order/order_model.dart';

import '../../model/order_details/order_details_model.dart';

part 'order_service_dto.freezed.dart';
part 'order_service_dto.g.dart';

@freezed
class OrderServiceDto with _$OrderServiceDto {
  const factory OrderServiceDto({
    @JsonKey() @Default([]) List<OrderModel> orders,
  }) = _OrderServiceDto;

  factory OrderServiceDto.fromJson(Map<String, dynamic> json) =>
      _$OrderServiceDtoFromJson(json);
}

@freezed
class GetOrderDetailsDTO with _$GetOrderDetailsDTO {
  const factory GetOrderDetailsDTO({
    @JsonKey(name: 'orders') required OrderDetailsModel orderDetails,
  }) = _GetOrderDetailsDTO;

  factory GetOrderDetailsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetOrderDetailsDTOFromJson(json);
}
