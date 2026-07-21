// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsSearchBarThemeAdapter implements DacsAdapter<SearchBarThemeData> {
  const DacsSearchBarThemeAdapter();

  @override
  SearchBarThemeData build(DacsStyleSheet sheet, DacsResolveContext context) {
    final s = sheet.resolveWith(context);
    final st = materialStateFor(sheet, context);
    return SearchBarThemeData(
      backgroundColor: dacsStateProp<Color?>(
        st,
        (s) => s.backgroundColor,
        hoverExtra: (s) => s.backgroundColor,
        focusExtra: (s) => s.backgroundColor,
        disabledExtra: (s) => s.backgroundColor?.withAlpha(97),
      ),
      elevation: dacsStateProp<double?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.boxShadow?.firstOrNull?.blurRadius,
        focusExtra: (s) => s.boxShadow?.firstOrNull?.blurRadius,
      ),
      shadowColor: dacsStateProp<Color?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.boxShadow?.firstOrNull?.color,
        focusExtra: (s) => s.boxShadow?.firstOrNull?.color,
      ),
      surfaceTintColor: dacsStateProp<Color?>(st, (s) => s.backgroundColor),
      overlayColor: dacsStateProp<Color?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.backgroundColor?.withAlpha(26),
        focusExtra: (s) => s.backgroundColor?.withAlpha(26),
      ),
      side: dacsStateProp<BorderSide?>(st, dacsSide),
      shape: dacsStateProp<OutlinedBorder?>(st, dacsShape),
      padding: dacsStateProp<EdgeInsetsGeometry?>(st, (s) => s.padding),
      textStyle: dacsStateProp<TextStyle?>(st, (s) => s.toTextStyle()),
      hintStyle: dacsStateProp<TextStyle?>(st, (s) => s.toTextStyle()),
      constraints: s.toConstraints(),
    );
  }
}
