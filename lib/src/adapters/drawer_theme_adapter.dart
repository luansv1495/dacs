// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsDrawerThemeAdapter implements DacsAdapter<DrawerThemeData> {
  const DacsDrawerThemeAdapter();

  @override
  DrawerThemeData build(DacsStyleSheet sheet, DacsResolveContext context) {
    final s = sheet.resolveWith(context);
    return DrawerThemeData(
      backgroundColor: s.backgroundColor,
      scrimColor: s.barrierColor,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shadowColor: s.boxShadow?.firstOrNull?.color,
      surfaceTintColor: s.indicatorColor,
      shape: dacsShape(s),
      endShape: dacsShape(s),
      width: s.width,
      clipBehavior: s.overflow,
    );
  }
}
