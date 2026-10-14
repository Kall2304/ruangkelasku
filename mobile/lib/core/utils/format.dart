import 'package:intl/intl.dart';

import '../copy/strings.dart';

/// Semua waktu dari API adalah UTC; konversi ke WIB (UTC+7) hanya di sini.
abstract final class Wib {
  static const Duration _offset = Duration(hours: 7);

  static DateTime of(DateTime utc) => utc.toUtc().add(_offset);

  static DateTime get now => of(DateTime.now().toUtc());
}

/// Format tanggal/jam WIB, mis. `formatWib(dt, 'd MMM, HH.mm')` → "20 Okt, 23.59".
String formatWib(DateTime utc, [String pattern = 'd MMM yyyy, HH.mm']) =>
    DateFormat(pattern, 'id_ID').format(Wib.of(utc));

/// "Tenggat 20 Okt, 23.59" atau tanpa tahun bila tahun ini.
String formatDue(DateTime utc) {
  final sameYear = Wib.of(utc).year == Wib.now.year;
  return S.dueAt(formatWib(utc, sameYear ? 'd MMM, HH.mm' : 'd MMM yyyy, HH.mm'));
}

/// Waktu relatif singkat untuk kartu posting dan komentar.
String formatRelative(DateTime utc) {
  final diff = DateTime.now().toUtc().difference(utc.toUtc());
  if (diff.inMinutes < 1) return S.justNow;
  if (diff.inHours < 1) return S.minutesAgo(diff.inMinutes);
  if (diff.inDays < 1) return S.hoursAgo(diff.inHours);
  if (diff.inDays == 1) return S.yesterday;
  final sameYear = Wib.of(utc).year == Wib.now.year;
  return formatWib(utc, sameYear ? 'd MMM' : 'd MMM yyyy');
}

/// 248113 → "242 KB".
String formatFileSize(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).round()} KB';
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1).replaceAll('.', ',')} MB';
}

/// 85.0 → "85", 87.5 → "87,5".
String formatGrade(num value) =>
    value == value.roundToDouble() ? value.toInt().toString() : value.toString().replaceAll('.', ',');
