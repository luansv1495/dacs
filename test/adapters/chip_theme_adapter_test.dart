import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('chip theme adapter', () {
    testWidgets('dChip resolves ChipThemeData', (t) async {
      final data = await t.run((ctx) => 'bg-primary rounded-lg p-2'.dChip(ctx));
      expect(data.color, isNotNull);
      expect(data.shape, isNotNull);
      expect(data.padding, isNotNull);
    });
  });
}
