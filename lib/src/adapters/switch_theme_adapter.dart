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
      thumbColor: dacsStateProp<Color?>(
        st,
        (s) => s.backgroundColor,
        activeExtra: (s) => s.color,
      ),
      trackColor: dacsStateProp<Color?>(
        st,
        (s) => s.backgroundColor?.withAlpha(128),
      ),
      trackOutlineColor: dacsStateProp<Color?>(st, (s) => s.borderColor),
      overlayColor: dacsStateProp<Color?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.backgroundColor?.withAlpha(26),
      ),
    );
  }
}
