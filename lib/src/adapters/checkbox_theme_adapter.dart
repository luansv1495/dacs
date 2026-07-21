// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsCheckboxThemeAdapter implements DacsAdapter<CheckboxThemeData> {
  const DacsCheckboxThemeAdapter();

  @override
  CheckboxThemeData build(DacsStyleSheet sheet, DacsResolveContext context) {
    final st = materialStateFor(sheet, context);
    return CheckboxThemeData(
      fillColor: dacsStateProp<Color?>(st, (s) => s.backgroundColor),
      checkColor: dacsStateProp<Color?>(st, (s) => s.color),
      overlayColor:
          dacsStateOverrideOrBaseProp<Color>(st, (s) => s.overlayColor),
      mouseCursor:
          dacsStateOverrideOrBaseProp<MouseCursor>(st, (s) => s.mouseCursor),
      side: dacsSide(st.base),
      shape: dacsShape(st.base),
      splashRadius: st.base.splashRadius,
      visualDensity: st.base.visualDensity,
      materialTapTargetSize: st.base.materialTapTargetSize,
    );
  }
}

class DacsRadioThemeAdapter implements DacsAdapter<RadioThemeData> {
  const DacsRadioThemeAdapter();

  @override
  RadioThemeData build(DacsStyleSheet sheet, DacsResolveContext context) {
    final st = materialStateFor(sheet, context);
    return RadioThemeData(
      fillColor: dacsStateProp<Color?>(st, (s) => s.backgroundColor),
      overlayColor:
          dacsStateOverrideOrBaseProp<Color>(st, (s) => s.overlayColor),
      mouseCursor:
          dacsStateOverrideOrBaseProp<MouseCursor>(st, (s) => s.mouseCursor),
      backgroundColor: dacsStateProp<Color?>(st, (s) => s.backgroundColor),
      side: dacsSide(st.base),
      splashRadius: st.base.splashRadius,
      visualDensity: st.base.visualDensity,
      materialTapTargetSize: st.base.materialTapTargetSize,
      innerRadius: dacsStateProp<double?>(st, (s) => s.width ?? s.height),
    );
  }
}
