// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'button_style_adapter.dart';

class DacsIconButtonThemeAdapter implements DacsAdapter<IconButtonThemeData> {
  const DacsIconButtonThemeAdapter();

  @override
  IconButtonThemeData build(DacsStyleSheet sheet, DacsResolveContext context) {
    return IconButtonThemeData(
      style: const DacsButtonStyleAdapter().build(sheet, context),
    );
  }
}
