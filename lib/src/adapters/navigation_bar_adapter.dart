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
      height: s.height,
      backgroundColor: s.backgroundColor,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shadowColor: s.boxShadow?.firstOrNull?.color,
      surfaceTintColor: s.backgroundColor,
      indicatorColor: s.indicatorColor,
      indicatorShape: dacsShape(s),
      overlayColor:
          dacsStateOverrideOrBaseProp<Color>(st, (s) => s.overlayColor),
      iconTheme: dacsStateProp<IconThemeData?>(
        st,
        (s) => s.color != null || s.width != null
            ? IconThemeData(color: s.color, size: s.width)
            : null,
      ),
      labelTextStyle: dacsStateProp<TextStyle?>(st, (st) => st.toTextStyle()),
      labelPadding: s.padding,
      labelBehavior: s.navigationLabelBehavior,
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
      unselectedItemColor: s.unselectedColor,
      selectedLabelStyle: s.toTextStyle(),
      unselectedLabelStyle: s.toTextStyle(),
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      selectedIconTheme: s.color != null || s.width != null
          ? IconThemeData(color: s.color, size: s.width)
          : null,
      unselectedIconTheme: s.unselectedColor != null || s.width != null
          ? IconThemeData(color: s.unselectedColor, size: s.width)
          : null,
      showSelectedLabels: s.bottomNavShowSelectedLabels,
      showUnselectedLabels: s.bottomNavShowUnselectedLabels,
      type: s.bottomNavType,
      landscapeLayout: s.bottomNavLandscapeLayout,
    );
  }
}
