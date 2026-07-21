// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolved_style.dart';

extension DacsBoxAdapter on DacsResolvedStyle {
  BoxDecoration toBoxDecoration() {
    BoxBorder? border;
    if (borderColor != null || borderWidth != null) {
      border = Border.all(
        color: borderColor ?? const Color(0xFF000000),
        width: borderWidth ?? 1.0,
      );
    }
    return BoxDecoration(
      color: backgroundColor,
      gradient: toGradient(),
      borderRadius: borderRadius,
      border: border,
      boxShadow: boxShadow,
    );
  }

  EdgeInsets toPadding() => padding ?? EdgeInsets.zero;

  EdgeInsets toMargin() => margin ?? EdgeInsets.zero;
}
