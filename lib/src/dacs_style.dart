import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vmath;
import 'dacs_layout_style.dart';
import 'parsers/class_parser.dart';

/// Direction for a linear gradient.
///
/// Maps to [Alignment] begin/end pairs for use with [LinearGradient].
enum DacsGradientDirection {
  /// Left to right.
  toR,

  /// Right to left.
  toL,

  /// Bottom to top.
  toT,

  /// Top to bottom.
  toB,

  /// Bottom-left to top-right.
  toTR,

  /// Bottom-right to top-left.
  toTL,

  /// Top-left to bottom-right.
  toBR,

  /// Top-right to bottom-left.
  toBL;

  /// The start [Alignment] for this gradient direction.
  Alignment get begin => switch (this) {
        toR => Alignment.centerLeft,
        toL => Alignment.centerRight,
        toT => Alignment.bottomCenter,
        toB => Alignment.topCenter,
        toTR => Alignment.bottomLeft,
        toTL => Alignment.bottomRight,
        toBR => Alignment.topLeft,
        toBL => Alignment.topRight,
      };

  /// The end [Alignment] for this gradient direction.
  Alignment get end => switch (this) {
        toR => Alignment.centerRight,
        toL => Alignment.centerLeft,
        toT => Alignment.topCenter,
        toB => Alignment.bottomCenter,
        toTR => Alignment.topRight,
        toTL => Alignment.topLeft,
        toBR => Alignment.bottomRight,
        toBL => Alignment.bottomLeft,
      };
}

/// Holds parsed utility class values from DACS string expressions.
///
/// Each field corresponds to a Flutter style property and is set by one or
/// more [DacsParser] implementations during parsing. Use [resolve] or
/// [resolveFor] to merge variants, and conversion methods like [toTextStyle]
/// or [toBoxDecoration] to produce Flutter objects.
class DacsStyle {
  /// Font size in logical pixels (e.g. `text-base` → 16.0).
  double? fontSize;

  /// Font weight (e.g. `font-bold` → w700).
  FontWeight? fontWeight;

  /// Text color (e.g. `text-red-500`).
  Color? color;

  /// Background color (e.g. `bg-blue-200`).
  Color? backgroundColor;

  /// Border color (e.g. `border-gray-300`).
  Color? borderColor;

  /// Border width in logical pixels (e.g. `border-2` → 2.0).
  double? borderWidth;

  /// Padding (e.g. `p-4` → all 16, `px-2` → horizontal 8).
  EdgeInsets? padding;

  /// Margin (e.g. `m-4` → all 16, `mt-2` → top 8).
  EdgeInsets? margin;

  /// Border radius (e.g. `rounded-lg`).
  BorderRadiusGeometry? borderRadius;

  /// Width constraint in logical pixels (e.g. `w-64` → 256.0, `w-full` → inf).
  double? width;

  /// Height constraint in logical pixels (e.g. `h-32` → 128.0).
  double? height;

  /// Opacity value 0.0–1.0 (e.g. `opacity-50` → 0.5).
  double? opacity;

  /// Font style (e.g. `italic` → italic).
  FontStyle? fontStyle;

  /// Text decoration (e.g. `underline`, `line-through`).
  TextDecoration? textDecoration;

  /// Text decoration color.
  Color? textDecorationColor;

  /// Text decoration style (e.g. `wavy`, `dotted`).
  TextDecorationStyle? textDecorationStyle;

  /// Text decoration thickness multiplier.
  double? textDecorationThickness;

  /// Letter spacing in logical pixels.
  double? letterSpacing;

  /// Line height as a multiplier of font size.
  double? lineHeight;

  /// List of box shadows (e.g. `shadow-lg`).
  List<BoxShadow>? boxShadow;

  /// Inset top value for [Positioned] widgets.
  double? insetTop;

  /// Inset right value for [Positioned] widgets.
  double? insetRight;

  /// Inset bottom value for [Positioned] widgets.
  double? insetBottom;

  /// Inset left value for [Positioned] widgets.
  double? insetLeft;

  /// Horizontal scale factor (e.g. `scale-125` → 1.25).
  double? scaleX;

  /// Vertical scale factor.
  double? scaleY;

  /// Rotation in degrees (e.g. `rotate-45` → 45).
  double? rotateDegrees;

  /// Horizontal translation in logical pixels.
  double? translateX;

  /// Vertical translation in logical pixels.
  double? translateY;

  /// Horizontal skew in degrees.
  double? skewX;

  /// Vertical skew in degrees.
  double? skewY;

  /// Gradient direction (e.g. `bg-gradient-to-r`).
  DacsGradientDirection? gradientDirection;

  /// Gradient start color (e.g. `from-red-500`).
  Color? gradientFromColor;

  /// Gradient midpoint color (e.g. `via-blue-500`).
  Color? gradientViaColor;

  /// Gradient end color (e.g. `to-green-500`).
  Color? gradientToColor;

  /// Variant conditions mapped to their [DacsStyle] overrides.
  /// Keys are variant names (e.g. `"dark"`, `"md"`, `"hover"`, `"dark:hover"`).
  Map<String, DacsStyle>? variants;

  /// Theme color key for text color (e.g. `"primary"`).
  String? textThemeColor;

  /// Theme color key for background color (e.g. `"surface"`).
  String? bgThemeColor;

  /// Theme color key for border color.
  String? borderThemeColor;

  /// Theme color key for text decoration color.
  String? decorationThemeColor;

  /// Theme color key for gradient start color.
  String? gradientFromThemeColor;

  /// Theme color key for gradient midpoint color.
  String? gradientViaThemeColor;

  /// Theme color key for gradient end color.
  String? gradientToThemeColor;

  /// Gap/spacing between flex/grid children (e.g. `gap-4` → 16.0).
  double? gap;

  /// Flex factor (e.g. `flex-1` → 1, `flex` → `true`).
  /// `null` means not set; `0.0` means `flex: 0` (default).
  int? flex;

  /// Flex direction (e.g. `flex-col` → [Axis.vertical]).
  Axis? flexDirection;

  /// Whether to allow wrapping (e.g. `flex-wrap` → `true`).
  bool? flexWrap;

  /// Align items (e.g. `items-center` → [CrossAxisAlignment.center]).
  CrossAxisAlignment? alignItems;

  /// Justify content (e.g. `justify-between` → [MainAxisAlignment.spaceBetween]).
  MainAxisAlignment? justifyContent;

  /// Minimum width constraint (e.g. `min-w-0` … `min-w-96`, `min-w-full`).
  double? minWidth;

  /// Maximum width constraint (e.g. `max-w-0` … `max-w-96`, `max-w-full`).
  double? maxWidth;

  /// Minimum height constraint (e.g. `min-h-0` … `min-h-96`, `min-h-full`).
  double? minHeight;

  /// Maximum height constraint (e.g. `max-h-0` … `max-h-96`, `max-h-full`).
  double? maxHeight;

  /// Aspect ratio (e.g. `aspect-square` → 1.0, `aspect-video` → 16/9).
  double? aspectRatio;

  /// Box fit for images (e.g. `object-cover` → [BoxFit.cover]).
  BoxFit? boxFit;

  /// Alignment (e.g. `align-center`, `align-topLeft`).
  AlignmentGeometry? alignment;

  /// Overflow behavior (e.g. `overflow-hidden` → [Clip.hardEdge]).
  Clip? overflow;

  /// Label text for [InputDecoration].
  String? inputLabelText;

  /// Hint text for [InputDecoration].
  String? inputHintText;

  /// Helper text for [InputDecoration].
  String? inputHelperText;

  /// Error text for [InputDecoration].
  String? inputErrorText;

  /// Prefix text for [InputDecoration].
  String? inputPrefixText;

  /// Suffix text for [InputDecoration].
  String? inputSuffixText;

  /// Whether [InputDecoration.filled] should be enabled.
  bool? inputFilled;

  /// Whether [InputDecoration.isDense] should be enabled.
  bool? inputDense;

  /// When `true`, variant overrides are ignored for this style group
  /// (triggered by `!important` suffix).
  bool isImportant = false;

  /// Creates a [DacsStyle] with no values set.
  DacsStyle();

  /// Parses [classes] into a [DacsStyle], providing a convenient way to
  /// define reusable style groups.
  ///
  /// Returns only the base style (variant conditions are stripped). Use
  /// [DacsStyleSheet.resolve] if variant resolution is needed.
  ///
  /// ```dart
  /// final cardStyle = DacsStyle.apply('bg-white rounded-lg shadow-md p-4');
  /// ```
  factory DacsStyle.apply(String classes) => ClassParser().parse(classes).base;

  /// Converts transform properties (scale, rotate, translate, skew)
  /// into a single [Matrix4] for use with [Transform.transform].
  vmath.Matrix4 toMatrix4() {
    final m = vmath.Matrix4.identity();
    if (translateX != null || translateY != null) {
      m.translateByVector3(vmath.Vector3(translateX ?? 0, translateY ?? 0, 0));
    }
    if (rotateDegrees != null) {
      m.rotateZ(rotateDegrees! * (math.pi / 180));
    }
    if (scaleX != null || scaleY != null) {
      m.scaleByVector3(vmath.Vector3(scaleX ?? 1, scaleY ?? 1, 1));
    }
    if (skewX != null) {
      m.setEntry(0, 1, math.tan(skewX! * math.pi / 180));
    }
    if (skewY != null) {
      m.setEntry(1, 0, math.tan(skewY! * math.pi / 180));
    }
    return m;
  }

  /// Converts applicable fields into a [TextStyle] for use with
  /// [Text], [RichText], or any widget that accepts a [TextStyle].
  TextStyle toTextStyle() {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontStyle: fontStyle,
      decoration: textDecoration,
      decorationColor: textDecorationColor,
      decorationStyle: textDecorationStyle,
      decorationThickness: textDecorationThickness,
      letterSpacing: letterSpacing,
      height: lineHeight,
    );
  }

  /// Returns padding as [EdgeInsets], or [EdgeInsets.zero] if unset.
  EdgeInsets toPadding() => padding ?? EdgeInsets.zero;

  /// Returns margin as [EdgeInsets], or [EdgeInsets.zero] if unset.
  EdgeInsets toMargin() => margin ?? EdgeInsets.zero;

  /// Builds a [LinearGradient] from [gradientDirection] / [gradientFromColor] /
  /// [gradientViaColor] / [gradientToColor].
  ///
  /// Returns `null` when direction or end color are missing.
  LinearGradient? toGradient() {
    if (gradientDirection == null || gradientToColor == null) return null;
    final colors = <Color>[
      gradientFromColor ?? const Color(0x00000000),
      // ignore: use_null_aware_elements
      if (gradientViaColor != null) gradientViaColor!,
      gradientToColor!,
    ];
    final stops = gradientViaColor != null ? [0.0, 0.5, 1.0] : [0.0, 1.0];
    return LinearGradient(
      begin: gradientDirection!.begin,
      end: gradientDirection!.end,
      colors: colors,
      stops: stops,
    );
  }

  /// Converts applicable fields into a [BoxDecoration] for use with
  /// [Container], [DecoratedBox], etc.
  ///
  /// Automatically includes border, gradient, border radius, and box shadow
  /// when their respective fields are set.
  BoxDecoration toBoxDecoration() {
    BoxBorder? border;
    if (borderColor != null || borderWidth != null) {
      border = Border.all(
        color: borderColor ?? const Color(0xFF000000),
        width: borderWidth ?? 1.0,
      );
    }
    return BoxDecoration(
      color: backgroundColor,
      gradient: toGradient(),
      borderRadius: borderRadius,
      border: border,
      boxShadow: boxShadow,
    );
  }

  /// Converts border fields into a [BoxBorder], or `null` if neither
  /// [borderColor] nor [borderWidth] is set.
  BoxBorder? toBorder() {
    if (borderColor == null && borderWidth == null) return null;
    return Border.all(
      color: borderColor ?? const Color(0xFF000000),
      width: borderWidth ?? 1.0,
    );
  }

  /// Converts border fields into a [BorderSide], or `null` if neither
  /// [borderColor] nor [borderWidth] is set.
  BorderSide? toBorderSide() {
    if (borderColor == null && borderWidth == null) return null;
    return BorderSide(
      color: borderColor ?? const Color(0xFF000000),
      width: borderWidth ?? 1.0,
    );
  }

  /// Returns [borderRadius] directly, or `null`.
  BorderRadiusGeometry? toRadius() => borderRadius;

  /// Builds [BoxConstraints] from width, height, and min/max fields.
  ///
  /// Returns `null` when none of the constraint fields are set.
  BoxConstraints? toConstraints() {
    if (width == null &&
        height == null &&
        minWidth == null &&
        maxWidth == null &&
        minHeight == null &&
        maxHeight == null) {
      return null;
    }
    return BoxConstraints(
      minWidth: minWidth ?? (width != null ? width! : 0.0),
      maxWidth: maxWidth ?? (width != null ? width! : double.infinity),
      minHeight: minHeight ?? (height != null ? height! : 0.0),
      maxHeight: maxHeight ?? (height != null ? height! : double.infinity),
    );
  }

  /// Builds a fixed [Size] from [width] and [height], or `null` if both are unset.
  Size? toFixedSize() {
    if (width == null && height == null) return null;
    return Size(width ?? 0, height ?? 0);
  }

  /// Groups layout-only fields into a [DacsLayoutStyle].
  DacsLayoutStyle toLayoutStyle() {
    return DacsLayoutStyle(
      width: width,
      height: height,
      constraints: toConstraints(),
      aspectRatio: aspectRatio,
      boxFit: boxFit,
      overflow: overflow,
      alignment: alignment,
    );
  }

  /// Returns [alignment] directly, or `null`.
  AlignmentGeometry? toAlignment() => alignment;

  /// Builds a [ShapeBorder] from [borderRadius], or `null`.
  ShapeBorder? toShapeBorder() {
    if (borderRadius == null) return null;
    return RoundedRectangleBorder(borderRadius: borderRadius!);
  }

  /// Resolves all `*ThemeColor` string keys to concrete [Color] values
  /// from [Theme.of(context).colorScheme].
  ///
  /// Does nothing for keys that are already resolved or `null`.
  void resolveThemeColors(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    color ??= _themeColor(scheme, textThemeColor);
    backgroundColor ??= _themeColor(scheme, bgThemeColor);
    borderColor ??= _themeColor(scheme, borderThemeColor);
    textDecorationColor ??= _themeColor(scheme, decorationThemeColor);
    gradientFromColor ??= _themeColor(scheme, gradientFromThemeColor);
    gradientViaColor ??= _themeColor(scheme, gradientViaThemeColor);
    gradientToColor ??= _themeColor(scheme, gradientToThemeColor);
  }

  Color? _themeColor(ColorScheme s, String? key) {
    if (key == null) return null;
    return switch (key) {
      'primary' => s.primary,
      'onPrimary' => s.onPrimary,
      'primaryContainer' => s.primaryContainer,
      'onPrimaryContainer' => s.onPrimaryContainer,
      'secondary' => s.secondary,
      'onSecondary' => s.onSecondary,
      'secondaryContainer' => s.secondaryContainer,
      'onSecondaryContainer' => s.onSecondaryContainer,
      'tertiary' => s.tertiary,
      'onTertiary' => s.onTertiary,
      'tertiaryContainer' => s.tertiaryContainer,
      'onTertiaryContainer' => s.onTertiaryContainer,
      'error' => s.error,
      'onError' => s.onError,
      'errorContainer' => s.errorContainer,
      'onErrorContainer' => s.onErrorContainer,
      'surface' => s.surface,
      'onSurface' => s.onSurface,
      // ignore: deprecated_member_use
      'surfaceVariant' => s.surfaceVariant,
      'onSurfaceVariant' => s.onSurfaceVariant,
      'outline' => s.outline,
      'outlineVariant' => s.outlineVariant,
      'inverseSurface' => s.inverseSurface,
      'onInverseSurface' => s.onInverseSurface,
      'inversePrimary' => s.inversePrimary,
      'shadow' => s.shadow,
      'scrim' => s.scrim,
      _ => null,
    };
  }

  /// Returns a deep copy of this [DacsStyle] including all fields and variants.
  DacsStyle clone() {
    final target = DacsStyle();
    target.mergeFrom(this);
    return target;
  }

  /// Merges all non-null fields from [source] into this instance.
  ///
  /// Uses `??=` semantics — existing values are preserved unless the
  /// source provides a new non-null value. Variant maps are merged with
  /// `addAll` and may overwrite existing entries with the same key.
  void mergeFrom(DacsStyle source) {
    fontSize = source.fontSize ?? fontSize;
    fontWeight = source.fontWeight ?? fontWeight;
    color = source.color ?? color;
    backgroundColor = source.backgroundColor ?? backgroundColor;
    borderColor = source.borderColor ?? borderColor;
    borderWidth = source.borderWidth ?? borderWidth;
    padding = source.padding ?? padding;
    margin = source.margin ?? margin;
    borderRadius = source.borderRadius ?? borderRadius;
    width = source.width ?? width;
    height = source.height ?? height;
    opacity = source.opacity ?? opacity;
    fontStyle = source.fontStyle ?? fontStyle;
    textDecoration = source.textDecoration ?? textDecoration;
    textDecorationColor = source.textDecorationColor ?? textDecorationColor;
    textDecorationStyle = source.textDecorationStyle ?? textDecorationStyle;
    textDecorationThickness =
        source.textDecorationThickness ?? textDecorationThickness;
    letterSpacing = source.letterSpacing ?? letterSpacing;
    lineHeight = source.lineHeight ?? lineHeight;
    boxShadow = source.boxShadow ?? boxShadow;
    insetTop = source.insetTop ?? insetTop;
    insetRight = source.insetRight ?? insetRight;
    insetBottom = source.insetBottom ?? insetBottom;
    insetLeft = source.insetLeft ?? insetLeft;
    scaleX = source.scaleX ?? scaleX;
    scaleY = source.scaleY ?? scaleY;
    rotateDegrees = source.rotateDegrees ?? rotateDegrees;
    translateX = source.translateX ?? translateX;
    translateY = source.translateY ?? translateY;
    skewX = source.skewX ?? skewX;
    skewY = source.skewY ?? skewY;
    gradientDirection = source.gradientDirection ?? gradientDirection;
    gradientFromColor = source.gradientFromColor ?? gradientFromColor;
    gradientViaColor = source.gradientViaColor ?? gradientViaColor;
    gradientToColor = source.gradientToColor ?? gradientToColor;
    textThemeColor = source.textThemeColor ?? textThemeColor;
    bgThemeColor = source.bgThemeColor ?? bgThemeColor;
    borderThemeColor = source.borderThemeColor ?? borderThemeColor;
    decorationThemeColor = source.decorationThemeColor ?? decorationThemeColor;
    gradientFromThemeColor =
        source.gradientFromThemeColor ?? gradientFromThemeColor;
    gradientViaThemeColor =
        source.gradientViaThemeColor ?? gradientViaThemeColor;
    gradientToThemeColor = source.gradientToThemeColor ?? gradientToThemeColor;
    gap = source.gap ?? gap;
    flex = source.flex ?? flex;
    flexDirection = source.flexDirection ?? flexDirection;
    flexWrap = source.flexWrap ?? flexWrap;
    alignItems = source.alignItems ?? alignItems;
    justifyContent = source.justifyContent ?? justifyContent;
    minWidth = source.minWidth ?? minWidth;
    maxWidth = source.maxWidth ?? maxWidth;
    minHeight = source.minHeight ?? minHeight;
    maxHeight = source.maxHeight ?? maxHeight;
    aspectRatio = source.aspectRatio ?? aspectRatio;
    boxFit = source.boxFit ?? boxFit;
    alignment = source.alignment ?? alignment;
    overflow = source.overflow ?? overflow;
    inputLabelText = source.inputLabelText ?? inputLabelText;
    inputHintText = source.inputHintText ?? inputHintText;
    inputHelperText = source.inputHelperText ?? inputHelperText;
    inputErrorText = source.inputErrorText ?? inputErrorText;
    inputPrefixText = source.inputPrefixText ?? inputPrefixText;
    inputSuffixText = source.inputSuffixText ?? inputSuffixText;
    inputFilled = source.inputFilled ?? inputFilled;
    inputDense = source.inputDense ?? inputDense;
    if (source.isImportant) isImportant = true;
    if (source.variants != null) {
      variants ??= {};
      variants!.addAll(source.variants!);
    }
  }

  /// Creates a new [DacsStyle] with the same field values as this instance,
  /// optionally overriding with the given [style].
  DacsStyle copyWith(DacsStyle? style) {
    if (style == null) return this;
    final result = clone();
    result.mergeFrom(style);
    return result;
  }
}
