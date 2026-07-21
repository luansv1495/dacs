// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsMenuStyleAdapter implements DacsAdapter<MenuStyle> {
  const DacsMenuStyleAdapter();

  @override
  MenuStyle build(DacsStyleSheet sheet, DacsResolveContext context) {
    final st = materialStateFor(sheet, context);
    return MenuStyle(
      backgroundColor: dacsStateProp<Color?>(st, (st) => st.backgroundColor),
      shadowColor:
          dacsStateProp<Color?>(st, (s) => s.boxShadow?.firstOrNull?.color),
      surfaceTintColor: dacsStateProp<Color?>(st, (st) => st.backgroundColor),
      shape: dacsStateProp<OutlinedBorder?>(st, dacsShape),
      side: dacsStateProp<BorderSide?>(st, dacsSide),
      elevation: dacsStateProp<double?>(
          st, (s) => s.boxShadow?.firstOrNull?.blurRadius),
      padding: dacsStateProp<EdgeInsets?>(st, (st) => st.padding),
      minimumSize: dacsStateProp<Size?>(st, _minimumSize),
      fixedSize: dacsStateProp<Size?>(st, (s) => s.toFixedSize()),
      maximumSize: dacsStateProp<Size?>(st, _maximumSize),
      alignment: st.base.alignment,
      visualDensity: st.base.visualDensity,
    );
  }

  Size? _minimumSize(dynamic s) {
    return s.minWidth != null || s.minHeight != null
        ? Size(s.minWidth ?? 0, s.minHeight ?? 0)
        : null;
  }

  Size? _maximumSize(dynamic s) {
    return s.maxWidth != null || s.maxHeight != null
        ? Size(s.maxWidth ?? double.infinity, s.maxHeight ?? double.infinity)
        : null;
  }
}
