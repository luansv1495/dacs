// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsButtonStyleAdapter implements DacsAdapter<ButtonStyle> {
  const DacsButtonStyleAdapter();

  @override
  ButtonStyle build(DacsStyleSheet sheet, DacsResolveContext context) {
    final st = materialStateFor(sheet, context);
    return ButtonStyle(
      textStyle: dacsStateProp<TextStyle?>(st, (s) => s.toTextStyle()),
      backgroundColor: dacsStateProp<Color?>(st, (s) => s.backgroundColor),
      foregroundColor: dacsStateProp<Color?>(st, (s) => s.color),
      overlayColor:
          dacsStateOverrideOrBaseProp<Color>(st, (s) => s.overlayColor),
      shadowColor:
          dacsStateProp<Color?>(st, (s) => s.boxShadow?.firstOrNull?.color),
      surfaceTintColor: dacsStateProp<Color?>(st, (s) => s.backgroundColor),
      iconColor: dacsStateProp<Color?>(st, (s) => s.color),
      iconSize: dacsStateProp<double?>(st, (s) => s.fontSize),
      padding: dacsStateProp<EdgeInsets?>(st, (s) => s.padding),
      minimumSize: dacsStateProp<Size?>(st, _size),
      fixedSize: dacsStateProp<Size?>(st, _size),
      maximumSize: dacsStateProp<Size?>(
        st,
        (s) => s.width != null || s.height != null
            ? Size(s.width ?? double.infinity, s.height ?? double.infinity)
            : null,
      ),
      side: dacsStateProp<BorderSide?>(st, dacsSide),
      shape: dacsStateProp<OutlinedBorder?>(st, dacsShape),
      elevation: dacsStateProp<double?>(
          st, (s) => s.boxShadow?.firstOrNull?.blurRadius),
      alignment: st.base.alignment,
      iconAlignment: st.base.iconAlignment,
      visualDensity: st.base.visualDensity,
      tapTargetSize: st.base.materialTapTargetSize,
      mouseCursor:
          dacsStateOverrideOrBaseProp<MouseCursor>(st, (s) => s.mouseCursor),
      enableFeedback: st.base.enableFeedback,
      animationDuration: st.base.animationDuration,
      splashFactory: st.base.splashFactory,
      backgroundBuilder: st.base.buttonBackgroundLayer == true
          ? _backgroundLayerBuilder(st)
          : null,
      foregroundBuilder: st.base.buttonForegroundLayer == true
          ? _foregroundLayerBuilder(st)
          : null,
    );
  }

  Size? _size(dynamic s) {
    return s.width != null || s.height != null
        ? Size(s.width ?? 0, s.height ?? 0)
        : null;
  }

  ButtonLayerBuilder _backgroundLayerBuilder(DacsMaterialState st) {
    return (context, states, child) {
      final style = dacsStyleForStates(st, states);
      return DecoratedBox(
        decoration: style.toBoxDecoration(),
        child: child,
      );
    };
  }

  ButtonLayerBuilder _foregroundLayerBuilder(DacsMaterialState st) {
    return (context, states, child) {
      final source = dacsStyleForStates(st, states);
      final style = source.clone()
        ..backgroundColor = source.overlayColor
        ..bgThemeColor = null;
      return DecoratedBox(
        decoration: style.toBoxDecoration(),
        child: child,
      );
    };
  }
}
