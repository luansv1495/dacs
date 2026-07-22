// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'input_decoration_adapter.dart';
import 'material_state.dart';
import 'menu_style_adapter.dart';

class DacsDropdownMenuThemeAdapter
    implements DacsAdapter<DropdownMenuThemeData> {
  const DacsDropdownMenuThemeAdapter();

  @override
  DropdownMenuThemeData build(
    DacsStyleSheet sheet,
    DacsResolveContext context,
  ) {
    final s = sheet.resolveWith(context);
    final st = materialStateFor(sheet, context);
    final decoration = const DacsInputDecorationAdapter().build(sheet, context);
    return DropdownMenuThemeData(
      textStyle: s.toTextStyle(),
      inputDecorationTheme: _inputTheme(decoration),
      menuStyle: const DacsMenuStyleAdapter().build(sheet, context),
      disabledColor: st.variantOverrides['disabled']?.color,
    );
  }

  InputDecorationThemeData _inputTheme(InputDecoration d) {
    return InputDecorationThemeData(
      labelStyle: d.labelStyle,
      floatingLabelStyle: d.floatingLabelStyle,
      helperStyle: d.helperStyle,
      hintStyle: d.hintStyle,
      errorStyle: d.errorStyle,
      floatingLabelBehavior:
          d.floatingLabelBehavior ?? FloatingLabelBehavior.auto,
      isDense: d.isDense ?? false,
      contentPadding: d.contentPadding,
      iconColor: d.iconColor,
      prefixStyle: d.prefixStyle,
      prefixIconColor: d.prefixIconColor,
      suffixStyle: d.suffixStyle,
      suffixIconColor: d.suffixIconColor,
      filled: d.filled ?? false,
      fillColor: d.fillColor,
      focusColor: d.focusColor,
      hoverColor: d.hoverColor,
      errorBorder: d.errorBorder,
      focusedBorder: d.focusedBorder,
      focusedErrorBorder: d.focusedErrorBorder,
      disabledBorder: d.disabledBorder,
      enabledBorder: d.enabledBorder,
      border: d.border,
      alignLabelWithHint: d.alignLabelWithHint ?? false,
      constraints: d.constraints,
    );
  }
}
