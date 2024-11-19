import 'package:date_format/date_format.dart';

class EDateTime {
  static String EformatDate(int? millisecondsSinceEpoch) {
    if (millisecondsSinceEpoch == 0 || millisecondsSinceEpoch == null) {
      return "未知";
    }
    String string = formatDate(
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch),
        [yyyy, '年', m, '月', d, '日 ', H, ':', nn]);
    return string;
  }

  static String EformatDate2(int? millisecondsSinceEpoch) {
    if (millisecondsSinceEpoch == 0 || millisecondsSinceEpoch == null) {
      return "未知";
    }
    String string = formatDate(
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch),
        [yyyy, '-', m, '-', d, ' ', H, ':', nn]);
    return string;
  }

  static String EformatDate3(int millisecondsSinceEpoch) {
    String string = formatDate(
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch),
        [yyyy, '-', m, '-', d]);
    return string;
  }

  static String EformatDateMD(int? time) {
    String string = formatDate(
        DateTime.fromMillisecondsSinceEpoch(time!), [m, '月', d, '日']);
    return string;
  }

  static String DateMDHS(int? time) {
    String string = formatDate(DateTime.fromMillisecondsSinceEpoch(time!),
        [m, '月', d, '日', HH, ':', nn]);
    return string;
  }

  static String DateHHSS(int time) {
    String string = formatDate(
        DateTime.fromMillisecondsSinceEpoch(time), [HH, ':', nn, ':', ss]);
    return string;
  }

  static int timestamp() {
    var now = DateTime.now();
    return now.millisecondsSinceEpoch;
  }

  static int microsecondsSinceEpoch() {
    var now = DateTime.now();
    return now.microsecondsSinceEpoch;
  }

  static String intToTime(dynamic seconds) {
    int day = seconds ~/ 3600 ~/ 24;
    int hour = seconds ~/ 3600 % 24;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    if (day != 0) {
      return formatTime(day) +
          '天' +
          formatTime(hour) +
          "小时" +
          formatTime(minute) +
          "分" +
          formatTime(second) +
          '秒';
    } else if (hour != 0) {
      return formatTime(hour) +
          "小时" +
          formatTime(minute) +
          "分" +
          formatTime(second) +
          '秒';
    } else if (minute != 0) {
      return minute.toString() + "分" + formatTime(second) + '秒';
    } else if (second != 0) {
      return formatTime(second) + '秒';
    } else {
      return '';
    }
  }

  //数字格式化，将 0~9 的时间转换为 00~09
  static String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  static taskTime(dynamic time) {
    var str = (time / 60).toStringAsFixed(2);
    if (time < 60) {
      return "${time}分钟";
    }
    var tmp = str.split(".");
    if (str.contains(".")) {
      if ((time / 60) > 24) {
        var tmp = ((time / 60) / 24).toStringAsFixed(2).split(".");
        if (tmp.length == 2) {
          if (int.parse(tmp[1]) < 0.1) {
            return "${((time / 60) / 24).toStringAsFixed(0)}天";
          } else {
            return "${((time / 60) / 24).toStringAsFixed(2)}天";
          }
        } else {
          return "${((time / 60) / 24).toStringAsFixed(0)}天";
        }
      } else if (int.parse(tmp[1]) < 0.1) {
        return "${tmp[0]}小时";
      } else {
        if ((time / 60) > 24) {
          return "${((time / 60) / 24).toStringAsFixed(2)}天";
        } else {
          var s = int.parse(str.substring(str.length - 1, str.length));
          if (s >= 1) {
            return "${(time / 60).toStringAsFixed(2)}小时";
          } else {
            return "${(time / 60).toStringAsFixed(1)}小时";
          }
        }
      }
    }
  }
}
