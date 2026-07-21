// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolved_style.dart';

extension DacsBorderAdapter on DacsResolvedStyle {
  BoxBorder? toBorder() {
    if (borderColor == null && borderWidth == null) return null;
    return Border.all(
      color: borderColor ?? const Color(0xFF000000),
      width: borderWidth ?? 1.0,
    );
  }

  BorderSide? toBorderSide() {
    if (borderColor == null && borderWidth == null) return null;
    return BorderSide(
      color: borderColor ?? const Color(0xFF000000),
      width: borderWidth ?? 1.0,
    );
  }
}
