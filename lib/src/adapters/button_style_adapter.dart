// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsButtonStyleAdapter implements DacsAdapter<ButtonStyle> {
  const DacsButtonStyleAdapter();

  @override
  ButtonStyle build(DacsStyleSheet sheet, DacsResolveContext context) {
    final st = materialStateFor(sheet, context);
    return ButtonStyle(
      textStyle: dacsStateProp<TextStyle?>(st, (s) => s.toTextStyle()),
      backgroundColor: dacsStateProp<Color?>(st, (s) => s.backgroundColor),
      foregroundColor: dacsStateProp<Color?>(st, (s) => s.color),
      overlayColor: dacsStateProp<Color?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.backgroundColor?.withAlpha(26),
        focusExtra: (s) => s.backgroundColor?.withAlpha(26),
        activeExtra: (s) => s.backgroundColor?.withAlpha(52),
      ),
      shadowColor: dacsStateProp<Color?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.boxShadow?.firstOrNull?.color,
      ),
      surfaceTintColor: dacsStateProp<Color?>(st, (s) => s.backgroundColor),
      iconColor: dacsStateProp<Color?>(st, (s) => s.color),
      iconSize: dacsStateProp<double?>(st, (s) => s.fontSize),
      padding: dacsStateProp<EdgeInsets?>(st, (s) => s.padding),
      minimumSize: dacsStateProp<Size?>(st, _size),
      fixedSize: dacsStateProp<Size?>(st, _size),
      maximumSize: dacsStateProp<Size?>(
        st,
        (s) => s.width != null || s.height != null
            ? Size(s.width ?? double.infinity, s.height ?? double.infinity)
            : null,
      ),
      side: dacsStateProp<BorderSide?>(st, dacsSide),
      shape: dacsStateProp<OutlinedBorder?>(st, dacsShape),
      elevation: dacsStateProp<double?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.boxShadow?.firstOrNull?.blurRadius,
      ),
      mouseCursor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return SystemMouseCursors.forbidden;
        }
        return SystemMouseCursors.click;
      }),
    );
  }

  Size? _size(dynamic s) {
    return s.width != null || s.height != null
        ? Size(s.width ?? 0, s.height ?? 0)
        : null;
  }
}
