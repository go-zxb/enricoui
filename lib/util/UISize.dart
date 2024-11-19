import 'dart:math';

import 'package:flutter/material.dart';

class ESize {
  ESize(BuildContext context) {
    init(context);
  }
  Size uiSize = const Size(750, 1334);

  MediaQueryData? mediaQueryData;
  double? screenWidth;
  double? screenHeight;
  double _scaleWidth = 0;
  double _scaleHeight = 0;
  double top = 0;
  double bottom = 0;
  double? blockSizeHorizontal;
  double? blockSizeVertical;

  double? safeAreaHorizontal;
  double? safeAreaVertical;
  double? safeBlockHorizontal;
  double? safeBlockVertical;
  late BuildContext ctx;

  void init(BuildContext context) {
    ctx = context;
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData?.size.width;
    screenHeight = mediaQueryData?.size.height;
    blockSizeHorizontal = screenWidth! / 100.0;
    blockSizeVertical = screenHeight! / 100.0;
    top = mediaQueryData!.padding.top;
    bottom = mediaQueryData!.padding.bottom;

    safeAreaHorizontal =
        mediaQueryData!.padding.left + mediaQueryData!.padding.right;
    safeAreaVertical =
        mediaQueryData!.padding.top + mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (screenWidth! - safeAreaHorizontal!) / 100.0;
    safeBlockVertical = (screenHeight! - safeAreaVertical!) / 100.0;

    _scaleWidth = (screenWidth! / uiSize.width); //获取ui宽度比例
    _scaleHeight = (screenHeight! / uiSize.height);
  }

  //获取屏幕当前尺寸 处理竖屏横屏
  double getTextSize(double size) {
    return screenWidth! < screenHeight! ? size : size / 1.5;
  }

  double getWidgetSize(double size, {int? width, int? height}) {
    if (width != null) {
      return screenWidth! < screenHeight! ? size : size / 2;
    } else {
      return screenWidth! < screenHeight! ? size : size * 2;
    }
  }

  double widthSize(double size) {
    return size * _scaleWidth;
  }

  double heightSize(double size) {
    return size * _scaleHeight;
  }

  Future<double> heightSizeAsync(Future<double> size) async {
    var s = await size;
    return s * _scaleHeight;
  }

  double spSize(double size) {
    return size * min(_scaleWidth, _scaleHeight);
  }
}
