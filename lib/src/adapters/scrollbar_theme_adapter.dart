// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsScrollbarThemeAdapter implements DacsAdapter<ScrollbarThemeData> {
  const DacsScrollbarThemeAdapter();

  @override
  ScrollbarThemeData build(DacsStyleSheet sheet, DacsResolveContext context) {
    final s = sheet.resolveWith(context);
    final st = materialStateFor(sheet, context);
    final visible = s.opacity == null ? null : s.opacity! > 0;
    return ScrollbarThemeData(
      thumbVisibility:
          visible == null ? null : WidgetStatePropertyAll<bool?>(visible),
      thumbColor: dacsStateProp<Color?>(
        st,
        (s) => s.backgroundColor,
      ),
      trackColor: dacsStateOverrideProp<Color>(st, (s) => s.borderColor),
      trackVisibility:
          visible == null ? null : WidgetStatePropertyAll<bool?>(visible),
      trackBorderColor: dacsStateProp<Color?>(st, (s) => s.borderColor),
      radius: s.borderRadius is BorderRadius
          ? Radius.circular((s.borderRadius as BorderRadius).topLeft.x)
          : null,
      thickness:
          s.borderWidth != null ? WidgetStatePropertyAll(s.borderWidth) : null,
      minThumbLength: s.minHeight,
      crossAxisMargin: s.margin?.left,
      mainAxisMargin: s.margin?.top,
      interactive: visible == false ? false : null,
    );
  }
}
