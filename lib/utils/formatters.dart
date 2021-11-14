import 'package:intl/intl.dart';

class Formatters {
  static String dateFormat(String? date) {
    if (date != null && date.isNotEmpty) {
      final now = DateTime.now();
      final timeAgo = DateTime.parse(date);
      final difference = now.difference(timeAgo);

      if (difference.inDays < 3) {
        if (now.day == timeAgo.day) {
          return "Hoje," + DateFormat("", "pt_BR").add_Hm().format(DateTime.parse(date)).trim();
        } else {
          return "Ontem," + DateFormat("", "pt_BR").add_Hm().format(DateTime.parse(date)).trim();
        }
      } else {
        return DateFormat("", "pt_BR").add_yMEd().format(DateTime.parse(date)).trim();
      }
    }
    return "";
  }
}
