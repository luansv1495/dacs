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
    return ScrollbarThemeData(
      thumbColor: dacsStateProp<Color?>(
        st,
        (s) => s.backgroundColor,
        hoverExtra: (s) => s.backgroundColor,
        activeExtra: (s) => s.color,
        disabledExtra: (s) => s.backgroundColor?.withAlpha(97),
      ),
      trackColor: dacsStateProp<Color?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.backgroundColor?.withAlpha(51),
        activeExtra: (s) => s.backgroundColor?.withAlpha(77),
      ),
      trackBorderColor: dacsStateProp<Color?>(st, (s) => s.borderColor),
      radius: s.borderRadius is BorderRadius
          ? Radius.circular((s.borderRadius as BorderRadius).topLeft.x)
          : null,
      thickness:
          s.borderWidth != null ? WidgetStatePropertyAll(s.borderWidth) : null,
      minThumbLength: s.minHeight,
      crossAxisMargin: s.margin?.left,
      mainAxisMargin: s.margin?.top,
    );
  }
}
