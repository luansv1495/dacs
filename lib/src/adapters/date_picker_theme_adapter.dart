// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'button_style_adapter.dart';
import 'input_decoration_adapter.dart';
import 'material_state.dart';

class DacsDatePickerThemeAdapter implements DacsAdapter<DatePickerThemeData> {
  const DacsDatePickerThemeAdapter();

  @override
  DatePickerThemeData build(DacsStyleSheet sheet, DacsResolveContext context) {
    final s = sheet.resolveWith(context);
    final st = materialStateFor(sheet, context);
    final buttonStyle = const DacsButtonStyleAdapter().build(sheet, context);
    final inputDecoration =
        const DacsInputDecorationAdapter().build(sheet, context);
    return DatePickerThemeData(
      backgroundColor: s.backgroundColor,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shadowColor: s.boxShadow?.firstOrNull?.color,
      surfaceTintColor: s.indicatorColor,
      shape: s.toShapeBorder(),
      headerBackgroundColor: s.componentColor('dateHeaderBackground'),
      headerForegroundColor: s.componentColor('dateHeaderForeground'),
      headerHeadlineStyle: s.toTextStyle(),
      headerHelpStyle: s.toTextStyle(),
      weekdayStyle: s.toTextStyle(),
      dayStyle: s.toTextStyle(),
      dayForegroundColor:
          _colorProp(st, 'dateDayForeground', fallback: (s) => s.color),
      dayBackgroundColor: _colorProp(st, 'dateDayBackground'),
      dayOverlayColor: _colorProp(st, 'dateDayOverlay'),
      dayShape: dacsStateProp<OutlinedBorder?>(st, dacsShape),
      todayForegroundColor: _colorProp(st, 'dateTodayForeground'),
      todayBackgroundColor: _colorProp(st, 'dateTodayBackground'),
      todayBorder: dacsSide(s),
      yearStyle: s.toTextStyle(),
      yearForegroundColor: _colorProp(st, 'dateYearForeground'),
      yearBackgroundColor: _colorProp(st, 'dateYearBackground'),
      yearOverlayColor: _colorProp(st, 'dateYearOverlay'),
      yearShape: dacsStateProp<OutlinedBorder?>(st, dacsShape),
      rangePickerBackgroundColor:
          s.componentColor('dateRangeBackground') ?? s.backgroundColor,
      rangePickerElevation: s.boxShadow?.firstOrNull?.blurRadius,
      rangePickerShadowColor: s.boxShadow?.firstOrNull?.color,
      rangePickerSurfaceTintColor: s.indicatorColor,
      rangePickerShape: s.toShapeBorder(),
      rangePickerHeaderBackgroundColor:
          s.componentColor('dateRangeHeaderBackground'),
      rangePickerHeaderForegroundColor:
          s.componentColor('dateRangeHeaderForeground'),
      rangePickerHeaderHeadlineStyle: s.toTextStyle(),
      rangePickerHeaderHelpStyle: s.toTextStyle(),
      rangeSelectionBackgroundColor:
          s.componentColor('dateRangeSelectionBackground'),
      rangeSelectionOverlayColor: _colorProp(st, 'dateRangeSelectionOverlay'),
      dividerColor: s.componentColor('dateDivider') ?? s.borderColor,
      inputDecorationTheme: _inputTheme(inputDecoration),
      cancelButtonStyle: buttonStyle,
      confirmButtonStyle: buttonStyle,
      toggleButtonTextStyle: s.toTextStyle(),
      subHeaderForegroundColor: s.componentColor('dateSubHeaderForeground'),
    );
  }

  WidgetStateProperty<Color?>? _colorProp(
    DacsMaterialState st,
    String channel, {
    Color? Function(DacsStyle style)? fallback,
  }) {
    return dacsStateOverrideOrBaseProp<Color>(
      st,
      (s) => s.componentColor(channel) ?? fallback?.call(s),
    );
  }

  InputDecorationThemeData _inputTheme(InputDecoration d) {
    return InputDecorationThemeData(
      labelStyle: d.labelStyle,
      floatingLabelStyle: d.floatingLabelStyle,
      helperStyle: d.helperStyle,
      hintStyle: d.hintStyle,
      errorStyle: d.errorStyle,
      floatingLabelBehavior:
          d.floatingLabelBehavior ?? FloatingLabelBehavior.auto,
      isDense: d.isDense ?? false,
      contentPadding: d.contentPadding,
      iconColor: d.iconColor,
      prefixStyle: d.prefixStyle,
      prefixIconColor: d.prefixIconColor,
      suffixStyle: d.suffixStyle,
      suffixIconColor: d.suffixIconColor,
      filled: d.filled ?? false,
      fillColor: d.fillColor,
      focusColor: d.focusColor,
      hoverColor: d.hoverColor,
      errorBorder: d.errorBorder,
      focusedBorder: d.focusedBorder,
      focusedErrorBorder: d.focusedErrorBorder,
      disabledBorder: d.disabledBorder,
      enabledBorder: d.enabledBorder,
      border: d.border,
      alignLabelWithHint: d.alignLabelWithHint ?? false,
      constraints: d.constraints,
    );
  }
}
