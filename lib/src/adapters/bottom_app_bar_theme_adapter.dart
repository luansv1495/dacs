// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';

class DacsBottomAppBarThemeAdapter
    implements DacsAdapter<BottomAppBarThemeData> {
  const DacsBottomAppBarThemeAdapter();

  @override
  BottomAppBarThemeData build(
    DacsStyleSheet sheet,
    DacsResolveContext context,
  ) {
    final s = sheet.resolveWith(context);
    return BottomAppBarThemeData(
      color: s.backgroundColor,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shape: s.bottomAppBarShape,
      height: s.height,
      surfaceTintColor: s.indicatorColor,
      shadowColor: s.boxShadow?.firstOrNull?.color,
      padding: s.padding,
    );
  }
}
