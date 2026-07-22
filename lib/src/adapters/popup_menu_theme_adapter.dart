// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsPopupMenuThemeAdapter implements DacsAdapter<PopupMenuThemeData> {
  const DacsPopupMenuThemeAdapter();

  @override
  PopupMenuThemeData build(DacsStyleSheet sheet, DacsResolveContext context) {
    final s = sheet.resolveWith(context);
    final st = materialStateFor(sheet, context);
    return PopupMenuThemeData(
      color: s.backgroundColor,
      shape: dacsShape(s),
      menuPadding: s.padding,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shadowColor: s.boxShadow?.firstOrNull?.color,
      surfaceTintColor: s.indicatorColor,
      textStyle: s.toTextStyle(),
      labelTextStyle: dacsStateProp<TextStyle?>(st, (s) => s.toTextStyle()),
      enableFeedback: s.enableFeedback,
      mouseCursor:
          dacsStateOverrideOrBaseProp<MouseCursor>(st, (s) => s.mouseCursor),
      position: s.popupMenuPosition,
      iconColor: s.color,
      iconSize: s.fontSize ?? s.width,
    );
  }
}
