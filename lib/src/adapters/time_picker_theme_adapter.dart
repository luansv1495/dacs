// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'button_style_adapter.dart';
import 'input_decoration_adapter.dart';
import 'material_state.dart';

class DacsTimePickerThemeAdapter implements DacsAdapter<TimePickerThemeData> {
  const DacsTimePickerThemeAdapter();

  @override
  TimePickerThemeData build(DacsStyleSheet sheet, DacsResolveContext context) {
    final s = sheet.resolveWith(context);
    final st = materialStateFor(sheet, context);
    final buttonStyle = const DacsButtonStyleAdapter().build(sheet, context);
    final inputDecoration =
        const DacsInputDecorationAdapter().build(sheet, context);
    return TimePickerThemeData(
      backgroundColor: s.backgroundColor,
      cancelButtonStyle: buttonStyle,
      confirmButtonStyle: buttonStyle,
      dayPeriodBorderSide: _side(st.base),
      dayPeriodColor: _stateColor(st, 'timeDayPeriodBackground'),
      dayPeriodShape: dacsShape(s),
      dayPeriodTextColor: _stateColor(st, 'timeDayPeriodForeground'),
      dayPeriodTextStyle: s.toTextStyle(),
      dialBackgroundColor: s.componentColor('timeDialBackground'),
      dialHandColor: s.componentColor('timeDialHand'),
      dialTextColor: _stateColor(st, 'timeDialForeground'),
      dialTextStyle: s.toTextStyle(),
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      entryModeIconColor: s.componentColor('timeEntryModeIcon') ?? s.color,
      helpTextStyle: s.toTextStyle(),
      hourMinuteColor: _stateColor(st, 'timeHourMinuteBackground'),
      hourMinuteShape: s.toShapeBorder(),
      hourMinuteTextColor: _stateColor(st, 'timeHourMinuteForeground'),
      hourMinuteTextStyle: s.toTextStyle(),
      inputDecorationTheme: _inputTheme(inputDecoration),
      padding: s.padding,
      shape: s.toShapeBorder(),
      timeSelectorSeparatorColor: _colorProp(st, 'timeSeparatorForeground'),
      timeSelectorSeparatorTextStyle: dacsStateProp<TextStyle?>(
        st,
        (s) => s
            .toTextStyle()
            .copyWith(color: s.componentColor('timeSeparatorForeground')),
      ),
    );
  }

  BorderSide? _side(DacsStyle s) {
    final color = s.componentColor('timeDayPeriodBorder');
    if (color == null) return dacsSide(s);
    return BorderSide(color: color, width: s.borderWidth ?? 1);
  }

  Color? _stateColor(DacsMaterialState st, String channel) {
    final base = st.base.componentColor(channel);
    if (base == null) return null;
    final prop = _colorProp(st, channel);
    if (prop == null) return null;
    return WidgetStateColor.resolveWith(
      (states) => prop.resolve(states) ?? base,
    );
  }

  WidgetStateProperty<Color?>? _colorProp(
    DacsMaterialState st,
    String channel,
  ) {
    return dacsStateOverrideOrBaseProp<Color>(
      st,
      (s) => s.componentColor(channel),
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
