import 'package:flutter/painting.dart';

/// Font size values mapped from Tailwind text-* classes.
const Map<String, double> dacsFontSizes = {
  'xs': 12,
  'sm': 14,
  'base': 16,
  'lg': 18,
  'xl': 20,
  '2xl': 24,
  '3xl': 30,
  '4xl': 36,
  '5xl': 48,
  '6xl': 60,
  '7xl': 72,
  '8xl': 96,
  '9xl': 128,
};

/// Absolute line height values mapped from leading-* classes.
const Map<String, double> dacsLineHeights = {
  '3': 12,
  '4': 16,
  '5': 20,
  '6': 24,
  '7': 28,
  '8': 32,
  '9': 36,
  '10': 40,
};

/// Relative line height multipliers mapped from leading-* classes.
const Map<String, double> dacsLineHeightRelative = {
  'none': 1.0,
  'tight': 1.25,
  'snug': 1.375,
  'normal': 1.5,
  'relaxed': 1.625,
  'loose': 2.0,
};

/// Letter spacing values mapped from tracking-* classes.
const Map<String, double> dacsLetterSpacing = {
  'tighter': -0.05,
  'tight': -0.025,
  'normal': 0.0,
  'wide': 0.025,
  'wider': 0.05,
  'widest': 0.1,
};

/// Font weight values mapped from font-* classes (thin … black).
const Map<String, FontWeight> dacsFontWeights = {
  'thin': FontWeight.w100,
  'extralight': FontWeight.w200,
  'light': FontWeight.w300,
  'normal': FontWeight.w400,
  'medium': FontWeight.w500,
  'semibold': FontWeight.w600,
  'bold': FontWeight.w700,
  'extrabold': FontWeight.w800,
  'black': FontWeight.w900,
};
