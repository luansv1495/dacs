// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsDataTableAdapter implements DacsAdapter<DataTableThemeData> {
  const DacsDataTableAdapter();

  @override
  DataTableThemeData build(DacsStyleSheet sheet, DacsResolveContext context) {
    final s = sheet.resolveWith(context);
    final st = materialStateFor(sheet, context);
    return DataTableThemeData(
      headingRowColor:
          dacsStateOverrideProp<Color>(st, (s) => s.backgroundColor),
      dataRowColor: dacsStateOverrideProp<Color>(st, (s) => s.backgroundColor),
      headingTextStyle: s.toTextStyle(),
      dataTextStyle: s.toTextStyle(),
      dividerThickness: s.borderWidth,
      decoration: s.toBoxDecoration(),
      horizontalMargin: s.padding?.left,
      columnSpacing: s.padding?.right,
      headingRowHeight: s.height,
      dataRowMinHeight: s.minHeight,
      dataRowMaxHeight: s.maxHeight,
      checkboxHorizontalMargin: s.margin?.left,
      headingRowAlignment: s.justifyContent,
    );
  }
}
