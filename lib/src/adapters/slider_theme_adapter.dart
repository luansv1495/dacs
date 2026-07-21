// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsSliderThemeAdapter implements DacsAdapter<SliderThemeData> {
  const DacsSliderThemeAdapter();

  @override
  SliderThemeData build(DacsStyleSheet sheet, DacsResolveContext context) {
    final s = sheet.resolveWith(context);
    final disabled = _stateStyle(sheet, context, 'disabled');
    final active = _stateStyle(sheet, context, 'active') ??
        _stateStyle(sheet, context, 'pressed');
    final hover = _stateStyle(sheet, context, 'hover');
    final overlayColor =
        active?.backgroundColor ?? hover?.backgroundColor ?? s.backgroundColor;

    return SliderThemeData(
      activeTrackColor: s.backgroundColor,
      inactiveTrackColor: s.borderColor ?? s.backgroundColor?.withAlpha(77),
      secondaryActiveTrackColor: s.color,
      disabledActiveTrackColor:
          disabled?.backgroundColor ?? s.backgroundColor?.withAlpha(97),
      disabledInactiveTrackColor:
          disabled?.borderColor ?? s.borderColor?.withAlpha(97),
      thumbColor: s.color ?? s.backgroundColor,
      disabledThumbColor: disabled?.color ?? s.color?.withAlpha(97),
      overlayColor: overlayColor?.withAlpha(31),
      valueIndicatorColor: s.backgroundColor,
      activeTickMarkColor: s.color,
      inactiveTickMarkColor: s.borderColor,
      disabledActiveTickMarkColor: disabled?.color,
      disabledInactiveTickMarkColor: disabled?.borderColor,
      trackHeight: s.height ?? s.borderWidth,
    );
  }

  dynamic _stateStyle(
    DacsStyleSheet sheet,
    DacsResolveContext context,
    String key,
  ) {
    final st = materialStateFor(sheet, context);
    return st.variants[key];
  }
}
