import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('navigation bar adapter', () {
    testWidgets('dBottomNav resolves BottomNavigationBarThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary'.dBottomNav(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.selectedItemColor, const Color(0xFFFFFFFF));
    });

    testWidgets('dNavBar resolves NavigationBarThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary'.dNavBar(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.labelTextStyle, isNotNull);
    });
  });
}
