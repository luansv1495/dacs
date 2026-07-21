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
      headingRowColor: dacsStateProp<Color?>(
        st,
        (_) => null,
        hoverExtra: (s2) => s2.backgroundColor?.withAlpha(26),
      ),
      dataRowColor: dacsStateProp<Color?>(
        st,
        (_) => null,
        hoverExtra: (s2) => s2.backgroundColor?.withAlpha(13),
      ),
      headingTextStyle: s.toTextStyle(),
      dataTextStyle: s.toTextStyle(),
      dividerThickness: s.borderWidth,
      decoration: s.toBoxDecoration(),
      horizontalMargin: s.padding?.left,
      columnSpacing: s.padding?.right,
    );
  }
}
