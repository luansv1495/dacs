// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsNavigationBarAdapter implements DacsAdapter<NavigationBarThemeData> {
  const DacsNavigationBarAdapter();

  @override
  NavigationBarThemeData build(
      DacsStyleSheet sheet, DacsResolveContext context) {
    final s = sheet.resolveWith(context);
    final st = materialStateFor(sheet, context);
    return NavigationBarThemeData(
      backgroundColor: s.backgroundColor,
      indicatorColor: s.backgroundColor?.withAlpha(26),
      indicatorShape: dacsShape(s),
      iconTheme: dacsStateProp<IconThemeData?>(
        st,
        (s) => s.color != null || s.width != null
            ? IconThemeData(color: s.color, size: s.width)
            : null,
      ),
      labelTextStyle: dacsStateProp<TextStyle?>(st, (st) => st.toTextStyle()),
      labelBehavior: null,
    );
  }
}

class DacsBottomNavigationBarAdapter
    implements DacsAdapter<BottomNavigationBarThemeData> {
  const DacsBottomNavigationBarAdapter();

  @override
  BottomNavigationBarThemeData build(
    DacsStyleSheet sheet,
    DacsResolveContext context,
  ) {
    final s = sheet.resolveWith(context);
    return BottomNavigationBarThemeData(
      backgroundColor: s.backgroundColor,
      selectedItemColor: s.color,
      unselectedItemColor: s.color?.withAlpha(128),
      selectedLabelStyle: s.toTextStyle(),
      unselectedLabelStyle: s.toTextStyle(),
    );
  }
}
