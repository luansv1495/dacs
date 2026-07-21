import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildDacsTestApp(Widget body) {
  return MaterialApp(
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF6200EE),
        onPrimary: Color(0xFFFFFFFF),
        primaryContainer: Color(0xFFBB86FC),
        onPrimaryContainer: Color(0xFF3700B3),
        secondary: Color(0xFF03DAC6),
        onSecondary: Color(0xFF000000),
        secondaryContainer: Color(0xFFCE93D8),
        onSecondaryContainer: Color(0xFF311B92),
        tertiary: Color(0xFFE91E63),
        onTertiary: Color(0xFFFFFFFF),
        tertiaryContainer: Color(0xFFF48FB1),
        onTertiaryContainer: Color(0xFF880E4F),
        error: Color(0xFFB00020),
        onError: Color(0xFFFFFFFF),
        errorContainer: Color(0xFFFCD8DF),
        onErrorContainer: Color(0xFF3700B3),
        surface: Color(0xFFFFFBFE),
        onSurface: Color(0xFF1C1B1F),
        // ignore: deprecated_member_use
        surfaceVariant: Color(0xFFE6E1E5),
        onSurfaceVariant: Color(0xFF49454F),
        outline: Color(0xFF79747E),
        outlineVariant: Color(0xFFC4C4C4),
        inverseSurface: Color(0xFF313033),
        onInverseSurface: Color(0xFFF4EFF4),
        inversePrimary: Color(0xFFBB86FC),
        shadow: Color(0xFF000000),
        scrim: Color(0xFF000000),
      ),
    ),
    home: Scaffold(body: Builder(builder: (_) => body)),
  );
}

extension DacsWidgetTesterX on WidgetTester {
  Future<T> run<T>(T Function(BuildContext) fn) async {
    late T result;
    await pumpWidget(
      buildDacsTestApp(
        Builder(
          builder: (ctx) {
            result = fn(ctx);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    return result;
  }
}
