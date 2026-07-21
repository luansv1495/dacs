import 'package:flutter/material.dart';
import 'dacs_layout_style.dart';
import 'dacs_style.dart';

/// Immutable result of resolving a DACS stylesheet.
///
/// Parsers write into mutable [DacsStyle] instances. Resolution freezes the
/// computed values behind this read-only wrapper so adapters and application
/// code can consume the result without accidentally mutating parser output.
class DacsResolvedStyle {
  final DacsStyle _style;

  /// Creates a resolved style from [style].
  ///
  /// The input style is cloned so later mutations to it do not change this
  /// resolved value.
  DacsResolvedStyle(DacsStyle style) : _style = style.clone();

  /// Creates a mutable copy of this resolved style.
  DacsStyle toMutableStyle() => _style.clone();

  /// Font size in logical pixels.
  double? get fontSize => _style.fontSize;

  /// Font weight.
  FontWeight? get fontWeight => _style.fontWeight;

  /// Text or foreground color.
  Color? get color => _style.color;

  /// Background color.
  Color? get backgroundColor => _style.backgroundColor;

  /// Border color.
  Color? get borderColor => _style.borderColor;

  /// Border width in logical pixels.
  double? get borderWidth => _style.borderWidth;

  /// Padding value.
  EdgeInsets? get padding => _style.padding;

  /// Margin value.
  EdgeInsets? get margin => _style.margin;

  /// Border radius value.
  BorderRadiusGeometry? get borderRadius => _style.borderRadius;

  /// Explicit width.
  double? get width => _style.width;

  /// Explicit height.
  double? get height => _style.height;

  /// Opacity from 0.0 to 1.0.
  double? get opacity => _style.opacity;

  /// Font style.
  FontStyle? get fontStyle => _style.fontStyle;

  /// Text decoration.
  TextDecoration? get textDecoration => _style.textDecoration;

  /// Text decoration color.
  Color? get textDecorationColor => _style.textDecorationColor;

  /// Text decoration style.
  TextDecorationStyle? get textDecorationStyle => _style.textDecorationStyle;

  /// Text decoration thickness.
  double? get textDecorationThickness => _style.textDecorationThickness;

  /// Letter spacing.
  double? get letterSpacing => _style.letterSpacing;

  /// Line height multiplier.
  double? get lineHeight => _style.lineHeight;

  /// Box shadows.
  List<BoxShadow>? get boxShadow => _style.boxShadow == null
      ? null
      : List<BoxShadow>.unmodifiable(_style.boxShadow!);

  /// Top inset.
  double? get insetTop => _style.insetTop;

  /// Right inset.
  double? get insetRight => _style.insetRight;

  /// Bottom inset.
  double? get insetBottom => _style.insetBottom;

  /// Left inset.
  double? get insetLeft => _style.insetLeft;

  /// Horizontal scale.
  double? get scaleX => _style.scaleX;

  /// Vertical scale.
  double? get scaleY => _style.scaleY;

  /// Rotation in degrees.
  double? get rotateDegrees => _style.rotateDegrees;

  /// Horizontal translation.
  double? get translateX => _style.translateX;

  /// Vertical translation.
  double? get translateY => _style.translateY;

  /// Horizontal skew.
  double? get skewX => _style.skewX;

  /// Vertical skew.
  double? get skewY => _style.skewY;

  /// Gradient direction.
  DacsGradientDirection? get gradientDirection => _style.gradientDirection;

  /// Gradient start color.
  Color? get gradientFromColor => _style.gradientFromColor;

  /// Gradient midpoint color.
  Color? get gradientViaColor => _style.gradientViaColor;

  /// Gradient end color.
  Color? get gradientToColor => _style.gradientToColor;

  /// Theme color key for text color.
  String? get textThemeColor => _style.textThemeColor;

  /// Theme color key for background color.
  String? get bgThemeColor => _style.bgThemeColor;

  /// Theme color key for border color.
  String? get borderThemeColor => _style.borderThemeColor;

  /// Theme color key for decoration color.
  String? get decorationThemeColor => _style.decorationThemeColor;

  /// Theme color key for gradient start color.
  String? get gradientFromThemeColor => _style.gradientFromThemeColor;

  /// Theme color key for gradient midpoint color.
  String? get gradientViaThemeColor => _style.gradientViaThemeColor;

  /// Theme color key for gradient end color.
  String? get gradientToThemeColor => _style.gradientToThemeColor;

  /// Explicit overlay color.
  Color? get overlayColor => _style.overlayColor;

  /// Theme color key for overlay color.
  String? get overlayThemeColor => _style.overlayThemeColor;

  /// Explicit indicator color.
  Color? get indicatorColor => _style.indicatorColor;

  /// Theme color key for indicator color.
  String? get indicatorThemeColor => _style.indicatorThemeColor;

  /// Explicit modal barrier color.
  Color? get barrierColor => _style.barrierColor;

  /// Theme color key for barrier color.
  String? get barrierThemeColor => _style.barrierThemeColor;

  /// Explicit unselected item or label color.
  Color? get unselectedColor => _style.unselectedColor;

  /// Theme color key for unselected color.
  String? get unselectedThemeColor => _style.unselectedThemeColor;

  /// Explicit disabled action color.
  Color? get disabledActionColor => _style.disabledActionColor;

  /// Theme color key for disabled action color.
  String? get disabledActionThemeColor => _style.disabledActionThemeColor;

  /// Mouse cursor for interactive Material components.
  MouseCursor? get mouseCursor => _style.mouseCursor;

  /// Splash radius for controls that expose a splash radius.
  double? get splashRadius => _style.splashRadius;

  /// Visual density for Material components.
  VisualDensity? get visualDensity => _style.visualDensity;

  /// Material tap target size.
  MaterialTapTargetSize? get materialTapTargetSize =>
      _style.materialTapTargetSize;

  /// Whether Material feedback should be enabled.
  bool? get enableFeedback => _style.enableFeedback;

  /// Animation duration for components that expose one.
  Duration? get animationDuration => _style.animationDuration;

  /// Ink splash factory for Material interaction effects.
  InteractiveInkFeatureFactory? get splashFactory => _style.splashFactory;

  /// Whether button styles should build a DACS background layer.
  bool? get buttonBackgroundLayer => _style.buttonBackgroundLayer;

  /// Whether button styles should build a DACS foreground layer.
  bool? get buttonForegroundLayer => _style.buttonForegroundLayer;

  /// Icon alignment for button styles.
  IconAlignment? get iconAlignment => _style.iconAlignment;

  /// Gap value.
  double? get gap => _style.gap;

  /// Flex factor.
  int? get flex => _style.flex;

  /// Flex direction.
  Axis? get flexDirection => _style.flexDirection;

  /// Flex wrapping behavior.
  bool? get flexWrap => _style.flexWrap;

  /// Cross-axis alignment.
  CrossAxisAlignment? get alignItems => _style.alignItems;

  /// Main-axis alignment.
  MainAxisAlignment? get justifyContent => _style.justifyContent;

  /// Minimum width.
  double? get minWidth => _style.minWidth;

  /// Maximum width.
  double? get maxWidth => _style.maxWidth;

  /// Minimum height.
  double? get minHeight => _style.minHeight;

  /// Maximum height.
  double? get maxHeight => _style.maxHeight;

  /// Aspect ratio.
  double? get aspectRatio => _style.aspectRatio;

  /// Image/object fit.
  BoxFit? get boxFit => _style.boxFit;

  /// Alignment.
  AlignmentGeometry? get alignment => _style.alignment;

  /// Overflow clipping behavior.
  Clip? get overflow => _style.overflow;

  /// Input label text.
  String? get inputLabelText => _style.inputLabelText;

  /// Input hint text.
  String? get inputHintText => _style.inputHintText;

  /// Input helper text.
  String? get inputHelperText => _style.inputHelperText;

  /// Input error text.
  String? get inputErrorText => _style.inputErrorText;

  /// Input prefix text.
  String? get inputPrefixText => _style.inputPrefixText;

  /// Input suffix text.
  String? get inputSuffixText => _style.inputSuffixText;

  /// Whether input decoration should be filled.
  bool? get inputFilled => _style.inputFilled;

  /// Whether input decoration should be dense.
  bool? get inputDense => _style.inputDense;

  /// Whether input labels align with hints.
  bool? get inputAlignLabelWithHint => _style.inputAlignLabelWithHint;

  /// Floating label behavior for input decoration.
  FloatingLabelBehavior? get inputFloatingLabelBehavior =>
      _style.inputFloatingLabelBehavior;

  /// Brightness hint for chip themes.
  Brightness? get chipBrightness => _style.chipBrightness;

  /// Whether chip themes should show the checkmark.
  bool? get chipShowCheckmark => _style.chipShowCheckmark;

  /// Indicator size for tab bars.
  TabBarIndicatorSize? get tabIndicatorSize => _style.tabIndicatorSize;

  /// Whether bottom navigation bars should show selected labels.
  bool? get bottomNavShowSelectedLabels => _style.bottomNavShowSelectedLabels;

  /// Whether bottom navigation bars should show unselected labels.
  bool? get bottomNavShowUnselectedLabels =>
      _style.bottomNavShowUnselectedLabels;

  /// Bottom navigation bar type.
  BottomNavigationBarType? get bottomNavType => _style.bottomNavType;

  /// Bottom navigation bar landscape layout.
  BottomNavigationBarLandscapeLayout? get bottomNavLandscapeLayout =>
      _style.bottomNavLandscapeLayout;

  /// Text capitalization for search bars.
  TextCapitalization? get textCapitalization => _style.textCapitalization;

  /// Label behavior for navigation bars.
  NavigationDestinationLabelBehavior? get navigationLabelBehavior =>
      _style.navigationLabelBehavior;

  /// Whether tooltips prefer rendering below their child.
  bool? get tooltipPreferBelow => _style.tooltipPreferBelow;

  /// Whether snack bars should show a close icon.
  bool? get snackShowCloseIcon => _style.snackShowCloseIcon;

  /// Whether bottom sheets should show the drag handle.
  bool? get bottomSheetShowDragHandle => _style.bottomSheetShowDragHandle;

  /// Value indicator visibility mode for slider themes.
  ShowValueIndicator? get sliderShowValueIndicator =>
      _style.sliderShowValueIndicator;

  /// Thumb icon data for switch themes.
  IconData? get switchThumbIcon => _style.switchThumbIcon;

  /// Track shape preset for slider themes.
  SliderTrackShape? get sliderTrackShape => _style.sliderTrackShape;

  /// Thumb shape preset for slider themes.
  SliderComponentShape? get sliderThumbShape => _style.sliderThumbShape;

  /// Overlay shape preset for slider themes.
  SliderComponentShape? get sliderOverlayShape => _style.sliderOverlayShape;

  /// Value indicator shape preset for slider themes.
  SliderComponentShape? get sliderValueIndicatorShape =>
      _style.sliderValueIndicatorShape;

  /// Material Symbols fill axis value for icon themes.
  double? get iconFill => _style.iconFill;

  /// Material Symbols weight axis value for icon themes.
  double? get iconWeight => _style.iconWeight;

  /// Material Symbols grade axis value for icon themes.
  double? get iconGrade => _style.iconGrade;

  /// Material Symbols optical size axis value for icon themes.
  double? get iconOpticalSize => _style.iconOpticalSize;

  /// Decoration image for shape-based decorations.
  DecorationImage? get decorationImage => _style.decorationImage;

  /// Wait duration for tooltip themes.
  Duration? get tooltipWaitDuration => _style.tooltipWaitDuration;

  /// Show duration for tooltip themes.
  Duration? get tooltipShowDuration => _style.tooltipShowDuration;

  /// Exit duration for tooltip themes.
  Duration? get tooltipExitDuration => _style.tooltipExitDuration;

  /// Snack bar positioning behavior.
  SnackBarBehavior? get snackBehavior => _style.snackBehavior;

  /// Whether this style blocks conditional overrides.
  bool get isImportant => _style.isImportant;

  /// Widget-state variants that still need adapter-time resolution.
  Map<String, DacsStyle>? get variants {
    final variants = _style.variants;
    if (variants == null) return null;
    return Map.unmodifiable(
      variants.map((key, value) => MapEntry(key, value.clone())),
    );
  }

  /// Converts transform properties into a [Matrix4].
  Matrix4 toMatrix4() => _style.toMatrix4();

  /// Converts applicable fields into a [TextStyle].
  TextStyle toTextStyle() => _style.toTextStyle();

  /// Returns padding or [EdgeInsets.zero].
  EdgeInsets toPadding() => _style.toPadding();

  /// Returns margin or [EdgeInsets.zero].
  EdgeInsets toMargin() => _style.toMargin();

  /// Builds a [LinearGradient], when configured.
  LinearGradient? toGradient() => _style.toGradient();

  /// Converts applicable fields into a [BoxDecoration].
  BoxDecoration toBoxDecoration() => _style.toBoxDecoration();

  /// Converts border fields into a [BoxBorder].
  BoxBorder? toBorder() => _style.toBorder();

  /// Converts border fields into a [BorderSide].
  BorderSide? toBorderSide() => _style.toBorderSide();

  /// Returns the parsed radius.
  BorderRadiusGeometry? toRadius() => _style.toRadius();

  /// Builds constraints from sizing fields.
  BoxConstraints? toConstraints() => _style.toConstraints();

  /// Returns the parsed alignment.
  AlignmentGeometry? toAlignment() => _style.toAlignment();

  /// Builds a shape from radius fields.
  ShapeBorder? toShapeBorder() => _style.toShapeBorder();

  /// Builds a fixed size from width and height.
  Size? toFixedSize() => _style.toFixedSize();

  /// Groups layout-only fields into a [DacsLayoutStyle].
  DacsLayoutStyle toLayoutStyle() => _style.toLayoutStyle();
}
