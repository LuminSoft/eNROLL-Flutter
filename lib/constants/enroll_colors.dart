import 'dart:ui';

import 'colors/dynamic_color.dart';

class EnrollColors {
  DynamicColor? primary;
  DynamicColor? secondary;
  DynamicColor? appBackgroundColor;
  DynamicColor? textColor;
  DynamicColor? errorColor;
  DynamicColor? successColor;
  DynamicColor? warningColor;
  DynamicColor? appWhite;
  DynamicColor? appBlack;

  EnrollColors({
    Color? primary,
    Color? secondary,
    Color? appBackgroundColor,
    Color? textColor,
    Color? errorColor,
    Color? successColor,
    Color? warningColor,
    Color? appWhite,
    Color? appBlack,
  }) {
    this.primary = DynamicColor(
        r: primary?.red,
        g: primary?.green,
        b: primary?.blue,
        opacity: primary?.opacity);
    this.secondary = DynamicColor(
        r: secondary?.red,
        g: secondary?.green,
        b: secondary?.blue,
        opacity: secondary?.opacity);
    this.appBackgroundColor = DynamicColor(
        r: appBackgroundColor?.red,
        g: appBackgroundColor?.green,
        b: appBackgroundColor?.blue,
        opacity: appBackgroundColor?.opacity);
    this.textColor = DynamicColor(
        r: textColor?.red,
        g: textColor?.green,
        b: textColor?.blue,
        opacity: textColor?.opacity);
    this.errorColor = DynamicColor(
        r: errorColor?.red,
        g: errorColor?.green,
        b: errorColor?.blue,
        opacity: errorColor?.opacity);
    this.successColor = DynamicColor(
        r: successColor?.red,
        g: successColor?.green,
        b: successColor?.blue,
        opacity: successColor?.opacity);
    this.warningColor = DynamicColor(
        r: warningColor?.red,
        g: warningColor?.green,
        b: warningColor?.blue,
        opacity: warningColor?.opacity);
    this.appWhite = DynamicColor(
        r: appWhite?.red,
        g: appWhite?.green,
        b: appWhite?.blue,
        opacity: appWhite?.opacity);
    this.appBlack = DynamicColor(
        r: appBlack?.red,
        g: appBlack?.green,
        b: appBlack?.blue,
        opacity: appBlack?.opacity);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (primary != null) {
      data['primary'] = primary!.toJson();
    }
    if (secondary != null) {
      data['secondary'] = secondary!.toJson();
    }
    if (appBackgroundColor != null) {
      data['appBackgroundColor'] = appBackgroundColor!.toJson();
    }
    if (textColor != null) {
      data['textColor'] = textColor!.toJson();
    }
    if (errorColor != null) {
      data['errorColor'] = errorColor!.toJson();
    }
    if (successColor != null) {
      data['successColor'] = successColor!.toJson();
    }
    if (warningColor != null) {
      data['warningColor'] = warningColor!.toJson();
    }
    if (appWhite != null) {
      data['appWhite'] = appWhite!.toJson();
    }
    if (appBlack != null) {
      data['appBlack'] = appBlack!.toJson();
    }
    return data;
  }

}
