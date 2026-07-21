import 'package:flutter/widgets.dart';

/// Layout-related values parsed from a DACS class string.
///
/// This groups values that do not map cleanly to one Flutter style object,
/// such as constraints, aspect ratio, object fit, clipping, and alignment.
class DacsLayoutStyle {
  /// Explicit width parsed from `w-*`.
  final double? width;

  /// Explicit height parsed from `h-*`.
  final double? height;

  /// Constraints built from width, height, min, and max tokens.
  final BoxConstraints? constraints;

  /// Aspect ratio parsed from `aspect-*`.
  final double? aspectRatio;

  /// Image/object fit parsed from `object-*`.
  final BoxFit? boxFit;

  /// Clip behavior parsed from `overflow-*`.
  final Clip? overflow;

  /// Alignment parsed from `align-*`.
  final AlignmentGeometry? alignment;

  /// Creates a layout style from parsed layout values.
  const DacsLayoutStyle({
    this.width,
    this.height,
    this.constraints,
    this.aspectRatio,
    this.boxFit,
    this.overflow,
    this.alignment,
  });

  /// Returns a [Size] when either [width] or [height] is set.
  Size? get fixedSize {
    if (width == null && height == null) return null;
    return Size(width ?? 0, height ?? 0);
  }

  /// Whether this object contains any layout value.
  bool get hasLayout =>
      width != null ||
      height != null ||
      constraints != null ||
      aspectRatio != null ||
      boxFit != null ||
      overflow != null ||
      alignment != null;
}
