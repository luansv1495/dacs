// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsBadgeThemeAdapter implements DacsAdapter<BadgeThemeData> {
  const DacsBadgeThemeAdapter();

  @override
  BadgeThemeData build(DacsStyleSheet sheet, DacsResolveContext context) {
    final s = sheet.resolveWith(context);
    final st = materialStateFor(sheet, context);
    final small = st.variantOverrides['small'];
    final large = st.variantOverrides['large'];
    return BadgeThemeData(
      backgroundColor: s.backgroundColor,
      textColor: s.color,
      smallSize: _size(small) ?? s.minHeight ?? s.minWidth,
      largeSize: _size(large) ?? s.height ?? s.width,
      textStyle: s.toTextStyle(),
      padding: s.padding,
      alignment: s.alignment,
      offset: _offset(s.toMutableStyle()),
    );
  }

  double? _size(DacsStyle? style) => style?.height ?? style?.width;

  Offset? _offset(DacsStyle s) {
    if (s.insetLeft == null &&
        s.insetRight == null &&
        s.insetTop == null &&
        s.insetBottom == null) {
      return null;
    }
    return Offset(
      s.insetLeft ?? -(s.insetRight ?? 0),
      s.insetTop ?? -(s.insetBottom ?? 0),
    );
  }
}
