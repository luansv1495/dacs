import 'package:flutter/painting.dart';

/// Tailwind-style shadow presets mapped to Flutter [BoxShadow] lists.
const Map<String, List<BoxShadow>> dacsShadows = {
  'sm': [
    BoxShadow(offset: Offset(0, 1), blurRadius: 2, color: Color(0x0D000000)),
  ],
  'DEFAULT': [
    BoxShadow(offset: Offset(0, 1), blurRadius: 3, color: Color(0x1A000000)),
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: -1,
      color: Color(0x1A000000),
    ),
  ],
  'md': [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
      color: Color(0x1A000000),
    ),
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -2,
      color: Color(0x1A000000),
    ),
  ],
  'lg': [
    BoxShadow(
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
      color: Color(0x1A000000),
    ),
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -4,
      color: Color(0x1A000000),
    ),
  ],
  'xl': [
    BoxShadow(
      offset: Offset(0, 20),
      blurRadius: 25,
      spreadRadius: -5,
      color: Color(0x1A000000),
    ),
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 10,
      spreadRadius: -6,
      color: Color(0x1A000000),
    ),
  ],
  '2xl': [
    BoxShadow(
      offset: Offset(0, 25),
      blurRadius: 50,
      spreadRadius: -12,
      color: Color(0x40000000),
    ),
  ],
  'inner': [
    BoxShadow(offset: Offset(0, 2), blurRadius: 4, color: Color(0x0D000000)),
  ],
};
