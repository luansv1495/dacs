// ignore_for_file: public_member_api_docs

import 'package:flutter/widgets.dart';
import '../dacs_resolved_style.dart';

extension DacsConstraintAdapter on DacsResolvedStyle {
  BoxConstraints? toConstraints() {
    if (width == null &&
        height == null &&
        minWidth == null &&
        maxWidth == null &&
        minHeight == null &&
        maxHeight == null) {
      return null;
    }
    return BoxConstraints(
      minWidth: minWidth ?? (width != null ? width! : 0.0),
      maxWidth: maxWidth ?? (width != null ? width! : double.infinity),
      minHeight: minHeight ?? (height != null ? height! : 0.0),
      maxHeight: maxHeight ?? (height != null ? height! : double.infinity),
    );
  }

  AlignmentGeometry? toAlignment() => alignment;

  BorderRadiusGeometry? toRadius() => borderRadius;

  ShapeBorder? toShapeBorder() {
    if (borderRadius == null) return null;
    return RoundedRectangleBorder(borderRadius: borderRadius!);
  }
}
