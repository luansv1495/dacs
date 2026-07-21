// ignore_for_file: public_member_api_docs

import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vmath;
import '../dacs_resolved_style.dart';

extension DacsTransformAdapter on DacsResolvedStyle {
  vmath.Matrix4 toMatrix4() {
    final m = vmath.Matrix4.identity();
    if (translateX != null || translateY != null) {
      m.translateByVector3(vmath.Vector3(translateX ?? 0, translateY ?? 0, 0));
    }
    if (rotateDegrees != null) {
      m.rotateZ(rotateDegrees! * (math.pi / 180));
    }
    if (scaleX != null || scaleY != null) {
      m.scaleByVector3(vmath.Vector3(scaleX ?? 1, scaleY ?? 1, 1));
    }
    if (skewX != null) {
      m.setEntry(0, 1, math.tan(skewX! * math.pi / 180));
    }
    if (skewY != null) {
      m.setEntry(1, 0, math.tan(skewY! * math.pi / 180));
    }
    return m;
  }
}
