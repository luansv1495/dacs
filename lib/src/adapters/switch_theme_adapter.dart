// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsSwitchThemeAdapter implements DacsAdapter<SwitchThemeData> {
  const DacsSwitchThemeAdapter();

  @override
  SwitchThemeData build(DacsStyleSheet sheet, DacsResolveContext context) {
    final st = materialStateFor(sheet, context);
    return SwitchThemeData(
      thumbColor: dacsStateProp<Color?>(st, (s) => s.color),
      trackColor: dacsStateProp<Color?>(st, (s) => s.backgroundColor),
      trackOutlineColor: dacsStateProp<Color?>(st, (s) => s.borderColor),
      trackOutlineWidth: dacsStateProp<double?>(st, (s) => s.borderWidth),
      thumbIcon: dacsStateOverrideOrBaseProp<Icon>(
        st,
        (s) => s.switchThumbIcon == null
            ? null
            : Icon(
                s.switchThumbIcon,
                color: s.color,
                size: s.fontSize ?? s.width,
                fill: s.iconFill,
                weight: s.iconWeight,
                grade: s.iconGrade,
                opticalSize: s.iconOpticalSize,
              ),
      ),
      overlayColor:
          dacsStateOverrideOrBaseProp<Color>(st, (s) => s.overlayColor),
      mouseCursor:
          dacsStateOverrideOrBaseProp<MouseCursor>(st, (s) => s.mouseCursor),
      splashRadius: st.base.splashRadius,
      materialTapTargetSize: st.base.materialTapTargetSize,
      padding: st.base.padding,
    );
  }
}
