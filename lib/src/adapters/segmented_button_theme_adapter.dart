// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'button_style_adapter.dart';

class DacsSegmentedButtonThemeAdapter
    implements DacsAdapter<SegmentedButtonThemeData> {
  const DacsSegmentedButtonThemeAdapter();

  @override
  SegmentedButtonThemeData build(
    DacsStyleSheet sheet,
    DacsResolveContext context,
  ) {
    final s = sheet.resolveWith(context);
    return SegmentedButtonThemeData(
      style: const DacsButtonStyleAdapter().build(sheet, context),
      selectedIcon: s.selectedIconData == null
          ? null
          : Icon(
              s.selectedIconData,
              color: s.color,
              size: s.fontSize ?? s.width,
              fill: s.iconFill,
              weight: s.iconWeight,
              grade: s.iconGrade,
              opticalSize: s.iconOpticalSize,
            ),
    );
  }
}
