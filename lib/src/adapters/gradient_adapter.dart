// ignore_for_file: public_member_api_docs

import 'package:flutter/widgets.dart';
import '../dacs_resolved_style.dart';

extension DacsGradientAdapter on DacsResolvedStyle {
  LinearGradient? toGradient() {
    if (gradientDirection == null || gradientToColor == null) return null;
    final colors = <Color>[
      gradientFromColor ?? const Color(0x00000000),
      // ignore: use_null_aware_elements
      if (gradientViaColor != null) gradientViaColor!,
      gradientToColor!,
    ];
    final stops = gradientViaColor != null ? [0.0, 0.5, 1.0] : [0.0, 1.0];
    return LinearGradient(
      begin: gradientDirection!.begin,
      end: gradientDirection!.end,
      colors: colors,
      stops: stops,
    );
  }
}
