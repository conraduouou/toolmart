import 'package:flutter/widgets.dart';

// TEXT STYLES

/// Style to apply for extra large text.
const kHeadlineStyle = TextStyle(
  fontFamily: "Sora",
  fontWeight: FontWeight.bold,
  fontSize: 32,
);

/// Style to apply for header text.
const kTitleStyle = TextStyle(
  fontFamily: "Sora",
  fontWeight: FontWeight.normal,
  fontSize: 20,
);

/// Style to apply for body text.
const kBodyStyle = TextStyle(
  fontFamily: "Sora",
  fontWeight: FontWeight.normal,
  fontSize: 16,
);

/// Style to apply for labels.
const kLabelStyle = TextStyle(
  fontFamily: "Sora",
  fontWeight: FontWeight.bold,
  fontSize: 12,
);

DateTime? parseDate(String date) {
  final mdy = date.split('T')[0].split('-');
  final month = int.tryParse(mdy[1]);
  final year = int.tryParse(mdy[0]);
  final day = int.tryParse(mdy[2]);

  if (month == null || year == null || day == null) return null;

  return DateTime(year, month, day);
}
