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
      fillColor: dacsStateProp<Color?>(
        st,
        (s) => s.backgroundColor,
        hoverExtra: (s) => s.backgroundColor?.withAlpha(26),
        focusExtra: (s) => s.backgroundColor?.withAlpha(26),
        activeExtra: (s) => s.backgroundColor?.withAlpha(52),
      ),
      checkColor: dacsStateProp<Color?>(st, (s) => s.color),
      overlayColor: dacsStateProp<Color?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.color?.withAlpha(26),
      ),
      side: dacsSide(st.base),
      shape: dacsShape(st.base),
    );
  }
}

class DacsRadioThemeAdapter implements DacsAdapter<RadioThemeData> {
  const DacsRadioThemeAdapter();

  @override
  RadioThemeData build(DacsStyleSheet sheet, DacsResolveContext context) {
    final st = materialStateFor(sheet, context);
    return RadioThemeData(
      fillColor: dacsStateProp<Color?>(
        st,
        (s) => s.backgroundColor,
        activeExtra: (s) => s.color,
      ),
      overlayColor: dacsStateProp<Color?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.color?.withAlpha(26),
      ),
    );
  }
}
