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
      shadowColor: dacsStateProp<Color?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.boxShadow?.firstOrNull?.color,
      ),
      surfaceTintColor: dacsStateProp<Color?>(st, (st) => st.backgroundColor),
      shape: dacsStateProp<OutlinedBorder?>(st, dacsShape),
      side: dacsStateProp<BorderSide?>(st, dacsSide),
      elevation: dacsStateProp<double?>(
        st,
        (_) => null,
        hoverExtra: (s2) => s2.boxShadow?.firstOrNull?.blurRadius,
      ),
      padding: dacsStateProp<EdgeInsets?>(st, (st) => st.padding),
    );
  }
}
