import 'package:flutter/material.dart';

abstract class AppTypography {

  // FontFamily
  static const String defaultFamily = 'poppins';

  // Body Weight
  static const FontWeight weightBold = FontWeight.w700;
  static const FontWeight weightSemiBold = FontWeight.w600;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightLight = FontWeight.w300;

  // Headline
  static const double sHeadlineLarge = 32;
  static const double sHeadlineMedium = 28;
  static const double sHeadlineSmall = 24;

  // Title
  static const double sTitleLarge = 22;
  static const double sTitleMedium = 20;
  static const double sTitleSmall = 18;

  // Label
  static const double sLabelLarge = 14;
  static const double sLabelMedium = 12;
  static const double sLabelSmall = 11;
  static const double sLabelExtraSmall = 11;

  // Body
  static const double sBodyLarge = 16;
  static const double sBodyMedium = 14;
  static const double sBodySmall = 12;
  static const double sBodyExtraSmall = 12;

  // Letter Spacing
  static const double letterSpacingTight = -0.5;
  static const double letterSpacingNormal = 0;
  static const double letterSpacingWide = 0.5;

  // Line Heights
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightLoose = 1.8;


  // Headline Styles
  static const TextStyle headlineLarge = TextStyle(
    fontSize: sHeadlineLarge,
    fontWeight: weightBold,
    fontFamily: defaultFamily,
    letterSpacing: letterSpacingTight,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: sHeadlineMedium,
    fontWeight: weightSemiBold,
    fontFamily: defaultFamily,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: sHeadlineSmall,
    fontWeight: weightMedium,
    fontFamily: defaultFamily,
    letterSpacing: letterSpacingNormal,
  );

  // Title Styles
  static const TextStyle titleLarge = TextStyle(
    fontSize: sTitleLarge,
    fontWeight: weightBold,
    fontFamily: defaultFamily,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: sTitleMedium,
    fontWeight: weightSemiBold,
    fontFamily: defaultFamily,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: sTitleSmall,
    fontWeight: weightMedium,
    fontFamily: defaultFamily,
  );

  // Label Styles
  static const TextStyle labelLarge = TextStyle(
    fontSize: sLabelLarge,
    fontWeight: weightBold,
    fontFamily: defaultFamily,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: sLabelMedium,
    fontWeight: weightSemiBold,
    fontFamily: defaultFamily,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: sLabelSmall,
    fontWeight: weightMedium,
    fontFamily: defaultFamily,
  );

  static const TextStyle labelExtraSmall = TextStyle(
    fontSize: sLabelExtraSmall,
    fontWeight: weightRegular,
    fontFamily: defaultFamily,
  );

  // Body Styles
  static const TextStyle bodyLarge = TextStyle(
    fontSize: sBodyLarge,
    fontWeight: weightRegular,
    fontFamily: defaultFamily,
    height: lineHeightNormal,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: sBodyMedium,
    fontWeight: weightRegular,
    fontFamily: defaultFamily,
    height: lineHeightNormal,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: sBodySmall,
    fontWeight: weightRegular,
    fontFamily: defaultFamily,
    height: lineHeightNormal,
  );

  static const TextStyle bodyExtraSmall = TextStyle(
    fontSize: sBodyExtraSmall,
    fontWeight: weightLight,
    fontFamily: defaultFamily,
    height: lineHeightLoose,
  );


  static const TextStyle errorMedium = TextStyle(
    // color: AppColors.textError,
    fontSize: sBodyMedium,
    fontWeight: weightRegular,
    fontFamily: defaultFamily,
    height: lineHeightNormal,
  );

  // Button Text
  static const TextStyle buttonStyleMedium = TextStyle(
    // color: AppColors.buttonTextPrimary,
    fontSize: sTitleMedium,
    fontWeight: weightSemiBold,
    fontFamily: defaultFamily,
  );

  static const TextStyle buttonStyleSmall = TextStyle(
    // color: AppColors.buttonTextPrimary,
    fontSize: sTitleSmall,
    fontWeight: weightMedium,
    fontFamily: defaultFamily,
  );

}