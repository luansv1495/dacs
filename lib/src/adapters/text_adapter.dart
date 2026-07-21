// ignore_for_file: public_member_api_docs

import 'package:flutter/widgets.dart';
import '../dacs_resolved_style.dart';

extension DacsTextStyleAdapter on DacsResolvedStyle {
  TextStyle toTextStyle() {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontStyle: fontStyle,
      decoration: textDecoration,
      decorationColor: textDecorationColor,
      decorationStyle: textDecorationStyle,
      decorationThickness: textDecorationThickness,
      letterSpacing: letterSpacing,
      height: lineHeight,
    );
  }
}
