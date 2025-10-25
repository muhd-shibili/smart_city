import 'package:flutter/material.dart';

extension SafePaddingExtension on BuildContext {
  double get safeBottom => safeBottomStrict + 70;

  double get safeBottomStrict => MediaQuery.paddingOf(this).bottom;

  double get safeTopStrict => MediaQuery.paddingOf(this).top;

  double get screenPadding =>
      (MediaQuery.sizeOf(this).width * 0.05).clamp(16, 24);

  double get bottomInsets => MediaQuery.viewInsetsOf(this).bottom;

  double reactiveWidth({
    /// ratio must be greater than 0 and less than 1
    required double ratio,
    required double lowerLimit,
    required double upperLimit,
  }) {
    return (MediaQuery.sizeOf(this).width * ratio).clamp(lowerLimit, upperLimit);
  }

  double reactiveHeight({
    /// ratio must be greater than 0 and less than 1
    required double ratio,
    required double lowerLimit,
    required double upperLimit,
  }) =>
      (height * ratio).clamp(lowerLimit, upperLimit);

  double get height => MediaQuery.sizeOf(this).height;
}
