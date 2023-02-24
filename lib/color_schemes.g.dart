import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ToolMartColor extends Color {
  const ToolMartColor(int primary, Map<int, Color> swatch)
      : _primary = primary,
        _swatch = swatch,
        super(primary);

  final int _primary;
  final Map<int, Color> _swatch;

  int get primary => _primary;
  Map<int, Color> get swatch => _swatch;

  /// Returns an element of the swatch table.
  Color? operator [](int index) => _swatch[index];

  Color get shade0 => swatch[0]!;
  Color get shade10 => swatch[10]!;
  Color get shade20 => swatch[20]!;
  Color get shade30 => swatch[30]!;
  Color get shade40 => swatch[40]!;
  Color get shade50 => swatch[50]!;
  Color get shade60 => swatch[60]!;
  Color get shade70 => swatch[70]!;
  Color get shade80 => swatch[80]!;
  Color get shade90 => swatch[90]!;
  Color get shade95 => swatch[95]!;
  Color get shade99 => swatch[99]!;
  Color get shade100 => swatch[100]!;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other == ToolMartColor &&
        _primary == (other as ToolMartColor).primary &&
        mapEquals(swatch, other.swatch);
  }

  @override
  int get hashCode => Object.hash(runtimeType, _primary, _swatch);
}

const kPrimaryColor = ToolMartColor(
  0xFFE47000,
  {
    0: Color(0xFF000000),
    10: Color(0xFF311300),
    20: Color(0xFF512400),
    30: Color(0xFF733600),
    40: Color(0xFF974800),
    50: Color(0xFFBD5C00),
    60: Color(0xFFE47000),
    70: Color(0xFFFF8E38),
    80: Color(0xFFFFB688),
    90: Color(0xFFFFDBC7),
    95: Color(0xFFFFEDE4),
    99: Color(0xFFFFFBFF),
    100: Color(0xFFFFFFFF),
  },
);

const kSecondaryColor = ToolMartColor(
  0xFF4B6700,
  {
    0: Color(0xFF000000),
    10: Color(0xFF141F00),
    20: Color(0xFF253500),
    30: Color(0xFF384E00),
    40: Color(0xFF4B6700),
    50: Color(0xFF608204),
    60: Color(0xFF789D26),
    70: Color(0xFF92B840),
    80: Color(0xFFADD458),
    90: Color(0xFFC8F171),
    95: Color(0xFFD7FF83),
    99: Color(0xFFFAFFE5),
    100: Color(0xFFFFFFFF),
  },
);

const kTertiaryColor = ToolMartColor(
  0xFFC6A930,
  {
    0: Color(0xFF000000),
    10: Color(0xFF221b00),
    20: Color(0xFF3B3000),
    30: Color(0xFF554600),
    40: Color(0xFF705D00),
    50: Color(0xFF8D7500),
    60: Color(0xFFAA8F12),
    70: Color(0xFFC6A930),
    80: Color(0xFFE4C54A),
    90: Color(0xFFFFE171),
    95: Color(0xFFFFF0C4),
    99: Color(0xFFFFFBFF),
    100: Color(0xFFFFFFFF),
  },
);

const kErrorColor = ToolMartColor(
  0xFFE9210F,
  {
    0: Color(0xFF000000),
    10: Color(0xFF400100),
    20: Color(0xFF680300),
    30: Color(0xFF920600),
    40: Color(0xFFBF0B00),
    50: Color(0xFFE9210F),
    60: Color(0xFFFF553E),
    70: Color(0xFFFF8A77),
    80: Color(0xFFFFB4A7),
    90: Color(0xFFFFDAD4),
    95: Color(0xFFFFEDEA),
    99: Color(0xFFFFFBFF),
    100: Color(0xFFFFFFFF),
  },
);

const kNeturalColor = ToolMartColor(
  0xFF7E7571,
  {
    0: Color(0xFF000000),
    10: Color(0xFF201A17),
    20: Color(0xFF362F2B),
    30: Color(0xFF4D4541),
    40: Color(0xFF655D58),
    50: Color(0xFF7E7571),
    60: Color(0xFF998F8A),
    70: Color(0xFFB4A9A4),
    80: Color(0xFFD0C4BF),
    90: Color(0xFFECE0DA),
    95: Color(0xFFFBEEEB),
    99: Color(0xFFFFFBFF),
    100: Color(0xFFFFFFFF),
  },
);

const kNeutralVariant = ToolMartColor(
  0xFF84746A,
  {
    0: Color(0xFF000000),
    10: Color(0xFF241913),
    20: Color(0xFF3A2E26),
    30: Color(0xFF52443C),
    40: Color(0xFF6B5B53),
    50: Color(0xFF84746A),
    60: Color(0xFF9F8D83),
    70: Color(0xFFBBA79D),
    80: Color(0xFFD7C3B8),
    90: Color(0xFFF4DED3),
    95: Color(0xFFFFEDE4),
    99: Color(0xFFFFFBFF),
    100: Color(0xFFFFFFFF),
  },
);
