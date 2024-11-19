import 'package:flutter/services.dart';

class ESystemUiOverlayStyle {
  ///dark = true 状态栏字体颜色显示黑色
  SystemUiOverlayStyle statusBarStyle({bool dark = true}) {
    // 如果dark为true，表示字体显示黑色
    if (dark) {
      // 返回一个SystemUiOverlayStyle对象，设置状态栏图标和文字亮度为Brightness.dark
      return const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      );
    } else {
      // 否则表示字体显示白色
      // 返回一个SystemUiOverlayStyle对象，设置状态栏图标和文字亮度为Brightness.light
      return const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      );
    }
  }
}
