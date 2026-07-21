// ignore_for_file: public_member_api_docs

import 'package:flutter/widgets.dart';
import '../dacs_layout_style.dart';
import '../dacs_resolve_context.dart';
import '../dacs_resolved_style.dart';
import '../dacs_style.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';

class DacsLayoutAdapter implements DacsAdapter<DacsLayoutStyle> {
  const DacsLayoutAdapter();

  @override
  DacsLayoutStyle build(DacsStyleSheet sheet, DacsResolveContext context) {
    return sheet.resolveWith(context).toLayoutStyle();
  }
}

extension DacsLayoutAdapterExtension on DacsResolvedStyle {
  Size? toFixedSize() {
    if (width == null && height == null) return null;
    return Size(width ?? 0, height ?? 0);
  }

  DacsLayoutStyle toLayoutStyle() {
    return DacsLayoutStyle(
      width: width,
      height: height,
      constraints: _constraints(this),
      aspectRatio: aspectRatio,
      boxFit: boxFit,
      overflow: overflow,
      alignment: alignment,
    );
  }

  BoxConstraints? _constraints(DacsStyle s) {
    if (s.width == null &&
        s.height == null &&
        s.minWidth == null &&
        s.maxWidth == null &&
        s.minHeight == null &&
        s.maxHeight == null) {
      return null;
    }
    return BoxConstraints(
      minWidth: s.minWidth ?? (s.width != null ? s.width! : 0.0),
      maxWidth: s.maxWidth ?? (s.width != null ? s.width! : double.infinity),
      minHeight: s.minHeight ?? (s.height != null ? s.height! : 0.0),
      maxHeight:
          s.maxHeight ?? (s.height != null ? s.height! : double.infinity),
    );
  }
}
