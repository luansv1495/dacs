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
    final st = materialStateFor(sheet, context);
    final disabled = st.variantOverrides['disabled'];

    return SliderThemeData(
      activeTrackColor: s.backgroundColor,
      inactiveTrackColor: s.borderColor,
      secondaryActiveTrackColor: s.color,
      disabledActiveTrackColor: disabled?.backgroundColor,
      disabledInactiveTrackColor: disabled?.borderColor,
      thumbColor: s.color ?? s.backgroundColor,
      disabledThumbColor: disabled?.color,
      overlayColor: s.overlayColor,
      valueIndicatorColor: s.backgroundColor,
      activeTickMarkColor: s.color,
      inactiveTickMarkColor: s.borderColor,
      disabledActiveTickMarkColor: disabled?.color,
      disabledInactiveTickMarkColor: disabled?.borderColor,
      trackHeight: s.height ?? s.borderWidth,
      valueIndicatorTextStyle: s.toTextStyle(),
      mouseCursor:
          dacsStateOverrideOrBaseProp<MouseCursor>(st, (s) => s.mouseCursor),
      padding: s.padding,
      thumbSize: s.toFixedSize() == null
          ? null
          : WidgetStatePropertyAll<Size?>(s.toFixedSize()),
      trackGap: s.gap,
      trackShape: s.sliderTrackShape,
      thumbShape: s.sliderThumbShape,
      overlayShape: s.sliderOverlayShape,
      valueIndicatorShape: s.sliderValueIndicatorShape,
      showValueIndicator: s.sliderShowValueIndicator,
    );
  }
}
