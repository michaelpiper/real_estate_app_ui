import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class ColorGroup extends Color {
  final Color? _dark;
  final Color? _darker;
  final Color? _darkest;
  final Color? _light;
  final Color? _lighter;
  final Color? _lightest;
  HSLColor get hsl => HSLColor.fromColor(this);

  const ColorGroup(
    super.value, {
    Color? dark,
    Color? darker,
    Color? darkest,
    Color? light,
    Color? lighter,
    Color? lightest,
  })  : _dark = dark,
        _darker = darker,
        _darkest = darkest,
        _light = light,
        _lighter = light,
        _lightest = lightest;

  Color get dark =>
      _dark ??
      hsl.withLightness((hsl.lightness * 0.7).clamp(0.0, 1.0)).toColor();
  Color get darker =>
      _darker ??
      hsl.withLightness((hsl.lightness * 0.5).clamp(0.0, 1.0)).toColor();
  Color get darkest =>
      _darkest ??
      hsl.withLightness((hsl.lightness * 0.3).clamp(0.0, 1.0)).toColor();
  Color get light =>
      _light ??
      hsl.withLightness((hsl.lightness * 1.3).clamp(0.0, 1.0)).toColor();
  Color get lighter =>
      _lighter ??
      hsl.withLightness((hsl.lightness * 1.5).clamp(0.0, 1.0)).toColor();
  Color get lightest =>
      _lightest ??
      hsl.withLightness((hsl.lightness * 1.7).clamp(0.0, 1.0)).toColor();
  Color get color {
    return this as Color;
  }
}

class AppColors {
  final uiOverlayStyle = SystemUiOverlayStyle.dark;
  final none = const ColorGroup(0x00000000);
  final white = const ColorGroup(0xFFFFFFFF);
  final black = const ColorGroup(0xFF25282B);
  final main = const ColorGroup(0xFF54547D);
  final primary = const ColorGroup(0xFF121213);

  final link = const ColorGroup(0xFF3E74A5);
  final badge = const ColorGroup(0xB2F3E4E3);
  final errorForeground = const ColorGroup(0xFFF14119);
  final errorText = const ColorGroup(0xFFD34221);
  final errorBackground = const ColorGroup(0xFFF5A0A0);
  final error = const ColorGroup(0xFFFA2E00);

  final successForeground = const ColorGroup(0xFF00FA19);
  final successText = const ColorGroup(0xFF00FA21);
  final successBackground = const ColorGroup(0xFFABFBBC);
  final success = const Color(0xFF00FA36);
  final text = const ColorGroup(0xFF25282B);
  final text2 = const ColorGroup(0xFF1E3C57);
  ColorGroup get icon => primary;

  ColorGroup? foreground;
  final background = const ColorGroup(0xFFFFFFFF);
  ColorGroup? card;

  ColorGroup? btnBackground;
  ColorGroup? btnForeground;
  ColorGroup? btnLabel;

  ColorGroup? backBtnForeground;
  ColorGroup? backBtnBackground;
  ColorGroup? backBtnLabel;

  ColorGroup? border;
  ColorGroup? border2;
  ColorGroup? border3;

  SystemUiOverlayStyle get homeUiOverlayStyle => uiOverlayStyle;
  ColorGroup? homeBackground;
  ColorGroup? homeForeground;
  ColorGroup? homeCard;
  ColorGroup? homeIconBackground;
  ColorGroup? homeIconForeground;

  ColorGroup? homeNavActive;
  ColorGroup? homeNavInactive;
  ColorGroup? get homeNavBackground => homeBackground;
  ColorGroup? get homeNavForeground => homeForeground;

  SystemUiOverlayStyle get quickServicesUiOverlayStyle => uiOverlayStyle;
  ColorGroup? quickServicesBackground;
  ColorGroup? quickServicesForeground;

  ColorGroup? quickServicesLink;

  ColorGroup? quickServicesIconBackground;
  ColorGroup? quickServicesIconForeground;

  ColorGroup? quickServicesBtnBackground;
  ColorGroup? quickServicesBtnForeground;

  ColorGroup? quickServicesTextBtnBackground;
  ColorGroup? quickServicesTextBtnForeground;
  ColorGroup? quickServicesTextBtnBorder;
  ColorGroup? quickServicesPasscodeInputBox;
  ColorGroup? quickServicesPasscodeInputBackground;
  ColorGroup? quickServicesPasscodeInputText;
  ColorGroup? get quickServicesPasscodeInputCursor => white;
  ColorGroup? get quickServicesPasscodeInputPreFilled => white;
  ColorGroup? iconBackground;
  ColorGroup? iconForeground;
  ColorGroup? iconBorder;

  ColorGroup? get body => text;

  ColorGroup? loadingIndicator;

  ColorGroup? homeLoadingIndicator;
  ColorGroup? overlay;

  ColorGroup? splashBackground;

  ColorGroup? title;
  ColorGroup? subtitle;

  ColorGroup? title2;
  ColorGroup? subtitle2;
  ColorGroup? subtitle3;

  ColorGroup? primaryBtnBackground;
  ColorGroup? primaryBtnForeground;

  ColorGroup? transactionTileBackground;
  ColorGroup? transactionTileTitle;
  ColorGroup? transactionTileSubtitle;
  ColorGroup? transactionTileTail;

  //page headers
  ColorGroup? get pageHeaderIcon => icon;
  ColorGroup? get pageHeaderIconBackground => iconBackground;
  ColorGroup? get pageHeaderIconForeground => iconForeground;
  ColorGroup? get pageHeaderIconBorder => iconBorder;
  AppColors({
    this.foreground,
    this.homeBackground,
    this.homeForeground,
    this.btnBackground,
    this.btnForeground,
    this.btnLabel,
    this.splashBackground,
  });
}
