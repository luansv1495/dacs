// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsNavigationRailAdapter
    implements DacsAdapter<NavigationRailThemeData> {
  const DacsNavigationRailAdapter();

  @override
  NavigationRailThemeData build(
    DacsStyleSheet sheet,
    DacsResolveContext context,
  ) {
    final s = sheet.resolveWith(context);
    final st = materialStateFor(sheet, context);
    final selected = st.variantOverrides['selected'];
    final extended = st.variantOverrides['extended'];
    return NavigationRailThemeData(
      backgroundColor: s.backgroundColor,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      unselectedLabelTextStyle: _unselectedTextStyle(st.base),
      selectedLabelTextStyle: (selected ?? st.base).toTextStyle(),
      unselectedIconTheme: _iconTheme(st.base, st.base.unselectedColor),
      selectedIconTheme: _iconTheme(selected ?? st.base, null),
      groupAlignment: s.navigationRailGroupAlignment,
      labelType: s.navigationRailLabelType,
      useIndicator: s.navigationRailUseIndicator,
      indicatorColor: s.indicatorColor,
      indicatorShape: dacsShape(s),
      minWidth: s.minWidth ?? s.width,
      minExtendedWidth: extended?.minWidth ?? extended?.width ?? s.maxWidth,
    );
  }

  TextStyle _unselectedTextStyle(DacsStyle s) {
    return s.toTextStyle().copyWith(color: s.unselectedColor ?? s.color);
  }

  IconThemeData? _iconTheme(DacsStyle s, Color? color) {
    final iconColor = color ?? s.color;
    final size = s.width ?? s.fontSize;
    if (iconColor == null && size == null) return null;
    return IconThemeData(
      color: iconColor,
      size: size,
      fill: s.iconFill,
      weight: s.iconWeight,
      grade: s.iconGrade,
      opticalSize: s.iconOpticalSize,
    );
  }
}
