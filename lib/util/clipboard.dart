import 'package:flutter/services.dart';

class EClipboardUtils {
  static Future<String?> getClipboardContent() async {
    try {
      final data = await Clipboard.getData(Clipboard.kTextPlain);
      return data?.text;
    } catch (e) {
      print('无法获取剪贴板内容: $e');
      return null;
    }
  }

  static void copyToClipboard(String content) {
    Clipboard.setData(ClipboardData(text: content)).then((value) {
      print('已复制到剪贴板: $content');
    });
  }
}
