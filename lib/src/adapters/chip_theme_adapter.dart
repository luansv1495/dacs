// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsChipThemeAdapter implements DacsAdapter<ChipThemeData> {
  const DacsChipThemeAdapter();

  @override
  ChipThemeData build(DacsStyleSheet sheet, DacsResolveContext context) {
    final st = materialStateFor(sheet, context);
    return ChipThemeData(
      color: dacsStateProp<WidgetStateColor?>(
        st,
        (s) => s.backgroundColor != null
            ? WidgetStateColor.resolveWith((_) => s.backgroundColor!)
            : null,
      ),
      shape: dacsShape(st.base),
      side: dacsSide(st.base),
      padding: st.base.padding,
    );
  }
}
