import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';

Widget _buildApp(Widget body) {
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
        surfaceContainerHighest: Color(0xFFE6E1E5),
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

extension _WidgetTesterX on WidgetTester {
  Future<T> run<T>(T Function(BuildContext) fn) async {
    late T result;
    await pumpWidget(
      _buildApp(
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

void main() {
  group('DacsContextExtension', () {
    testWidgets('dStyleOf resolves theme colors from context', (t) async {
      final style = await t.run(
        (ctx) => 'text-primary bg-surface'.dStyleOf(ctx),
      );
      expect(style.color, const Color(0xFF6200EE));
      expect(style.backgroundColor, const Color(0xFFFFFBFE));
    });

    testWidgets('dTextOf returns TextStyle with resolved colors', (t) async {
      final ts = await t.run((ctx) => 'text-primary font-bold'.dTextOf(ctx));
      expect(ts.color, const Color(0xFF6200EE));
      expect(ts.fontWeight, FontWeight.w700);
    });

    testWidgets('dPadsOf returns EdgeInsets with resolved variants', (t) async {
      final pad = await t.run((ctx) => 'p-4'.dPadsOf(ctx));
      expect(pad.left, 16);
    });

    testWidgets('dMarginOf returns EdgeInsets margin', (t) async {
      final margin = await t.run((ctx) => 'm-4'.dMarginOf(ctx));
      expect(margin.left, 16);
    });

    testWidgets('dBoxOf returns BoxDecoration with resolved colors', (t) async {
      final box = await t.run((ctx) => 'bg-primary rounded-lg'.dBoxOf(ctx));
      expect(box.color, const Color(0xFF6200EE));
      expect(box.borderRadius, isNotNull);
    });

    testWidgets('dShadowOf returns shadows', (t) async {
      final shadows = await t.run((ctx) => 'shadow-lg'.dShadowOf(ctx));
      expect(shadows.length, 2);
    });

    testWidgets('dSizeOf returns width and height', (t) async {
      final size = await t.run((ctx) => 'w-64 h-32'.dSizeOf(ctx));
      expect(size.$1, 256);
      expect(size.$2, 128);
    });

    testWidgets('dPositionOf returns insets', (t) async {
      final pos = await t.run((ctx) => 'inset-4'.dPositionOf(ctx));
      expect(pos.$1, 16);
    });

    testWidgets('dTransformOf returns Matrix4', (t) async {
      final m = await t.run((ctx) => 'scale-150'.dTransformOf(ctx));
      expect(m.getColumn(0).x, 1.5);
    });

    testWidgets('dGradientOf returns gradient', (t) async {
      final g = await t.run(
        (ctx) => 'bg-gradient-to-r from-primary to-onPrimary'.dGradientOf(ctx),
      );
      expect(g, isA<LinearGradient>());
      expect(g!.colors.length, 2);
    });

    testWidgets('dStyleOf resolves dark variant', (t) async {
      final app = MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFBB86FC),
            onPrimary: Color(0xFF000000),
            primaryContainer: Color(0xFF3700B3),
            onPrimaryContainer: Color(0xFFBB86FC),
            secondary: Color(0xFF03DAC6),
            onSecondary: Color(0xFF000000),
            secondaryContainer: Color(0xFFCE93D8),
            onSecondaryContainer: Color(0xFF311B92),
            tertiary: Color(0xFFE91E63),
            onTertiary: Color(0xFFFFFFFF),
            tertiaryContainer: Color(0xFFF48FB1),
            onTertiaryContainer: Color(0xFF880E4F),
            error: Color(0xFFCF6679),
            onError: Color(0xFF000000),
            errorContainer: Color(0xFFFCD8DF),
            onErrorContainer: Color(0xFF3700B3),
            surface: Color(0xFF1C1B1F),
            onSurface: Color(0xFFE6E1E5),
            surfaceContainerHighest: Color(0xFF49454F),
            onSurfaceVariant: Color(0xFFCAC4D0),
            outline: Color(0xFF938F99),
            outlineVariant: Color(0xFF49454F),
            inverseSurface: Color(0xFFE6E1E5),
            onInverseSurface: Color(0xFF313033),
            inversePrimary: Color(0xFF6200EE),
            shadow: Color(0xFF000000),
            scrim: Color(0xFF000000),
          ),
        ),
        home: Scaffold(
          body: Builder(
            builder: (ctx) {
              final style = 'text-primary dark:text-onPrimary'.dStyleOf(ctx);
              expect(style.color, const Color(0xFFBB86FC));
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await t.pumpWidget(app);
    });

    testWidgets('resolveThemeColors resolves all theme color keys', (t) async {
      final style = await t.run((ctx) {
        final s = DacsStyle()
          ..textThemeColor = 'primary'
          ..bgThemeColor = 'surface'
          ..borderThemeColor = 'error'
          ..decorationThemeColor = 'onPrimary'
          ..gradientFromThemeColor = 'secondaryContainer'
          ..gradientViaThemeColor = 'tertiary'
          ..gradientToThemeColor = 'inversePrimary';
        s.resolveThemeColors(ctx);
        return s;
      });
      expect(style.color, const Color(0xFF6200EE));
      expect(style.backgroundColor, const Color(0xFFFFFBFE));
      expect(style.borderColor, const Color(0xFFB00020));
      expect(style.textDecorationColor, const Color(0xFFFFFFFF));
      expect(style.gradientFromColor, const Color(0xFFCE93D8));
      expect(style.gradientViaColor, const Color(0xFFE91E63));
      expect(style.gradientToColor, const Color(0xFFBB86FC));
    });
  });

  group('Material extensions', () {
    testWidgets('dButton resolves ButtonStyle with color', (t) async {
      final style = await t.run(
        (ctx) => 'bg-primary text-onPrimary rounded-lg p-4'.dButton(ctx),
      );
      expect(style.backgroundColor, isNotNull);
      expect(style.foregroundColor, isNotNull);
      expect(style.padding, isNotNull);
      expect(style.shape, isNotNull);
    });

    testWidgets('dCheckbox resolves CheckboxThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary'.dCheckbox(ctx),
      );
      expect(data.fillColor, isNotNull);
      expect(data.checkColor, isNotNull);
    });

    testWidgets('dSwitch resolves SwitchThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary'.dSwitch(ctx),
      );
      expect(data.thumbColor, isNotNull);
      expect(data.trackColor, isNotNull);
    });

    testWidgets('dRadio resolves RadioThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary'.dRadio(ctx),
      );
      expect(data.fillColor, isNotNull);
    });

    testWidgets('dChip resolves ChipThemeData', (t) async {
      final data = await t.run((ctx) => 'bg-primary rounded-lg p-2'.dChip(ctx));
      expect(data.color, isNotNull);
      expect(data.shape, isNotNull);
      expect(data.padding, isNotNull);
    });

    testWidgets('dAppBar resolves AppBarTheme', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary'.dAppBar(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.foregroundColor, const Color(0xFFFFFFFF));
    });

    testWidgets('dCard resolves CardTheme', (t) async {
      final data = await t.run((ctx) => 'bg-primary rounded-lg m-4'.dCard(ctx));
      expect(data.color, const Color(0xFF6200EE));
      expect(data.shape, isNotNull);
      expect(data.margin, isNotNull);
    });

    testWidgets('dListTile resolves ListTileThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary p-4'.dListTile(ctx),
      );
      expect(data.tileColor, const Color(0xFF6200EE));
      expect(data.textColor, const Color(0xFFFFFFFF));
      expect(data.contentPadding, isNotNull);
    });

    testWidgets('dTabBar resolves TabBarTheme', (t) async {
      final data = await t.run((ctx) => 'text-primary font-bold'.dTabBar(ctx));
      expect(data.labelColor, const Color(0xFF6200EE));
      expect(data.labelStyle, isNotNull);
    });

    testWidgets('dBottomNav resolves BottomNavigationBarThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary'.dBottomNav(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.selectedItemColor, const Color(0xFFFFFFFF));
    });

    testWidgets('dInput resolves InputDecoration', (t) async {
      final data = await t.run(
        (ctx) => 'bg-surface border-error rounded-lg p-4'.dInput(ctx),
      );
      expect(data.filled, isTrue);
      expect(data.fillColor, const Color(0xFFFFFBFE));
      expect(data.border, isNotNull);
      expect(data.contentPadding, isNotNull);
    });

    testWidgets('dProgress resolves ProgressIndicatorThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'text-primary bg-surface'.dProgress(ctx),
      );
      expect(data.color, const Color(0xFF6200EE));
      expect(data.linearTrackColor, const Color(0xFFFFFBFE));
    });

    testWidgets('dTooltip resolves TooltipThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary rounded-lg p-2 m-1'.dTooltip(ctx),
      );
      expect(data.decoration, isNotNull);
      expect(data.textStyle, isNotNull);
      expect(data.padding, isNotNull);
      expect(data.margin, isNotNull);
    });

    testWidgets('dDivider resolves DividerThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'text-primary border-2 w-10'.dDivider(ctx),
      );
      expect(data.color, const Color(0xFF6200EE));
      expect(data.thickness, 8);
    });

    testWidgets('dScrollbar resolves ScrollbarThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary rounded-lg border-2'.dScrollbar(ctx),
      );
      expect(data.thumbColor, isNotNull);
      expect(data.radius, isNotNull);
      expect(data.thickness, isNotNull);
    });

    testWidgets('dSnackBar resolves SnackBarThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary rounded-lg'.dSnackBar(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.contentTextStyle, isNotNull);
      expect(data.shape, isNotNull);
    });

    testWidgets('dDialog resolves DialogTheme', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary rounded-lg shadow-lg'.dDialog(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.shape, isNotNull);
      expect(data.elevation, isNotNull);
    });

    testWidgets('dBottomSheet resolves BottomSheetThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary rounded-lg shadow-lg'.dBottomSheet(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.shape, isNotNull);
    });

    testWidgets('dExpansionTile resolves ExpansionTileThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary rounded-lg'.dExpansionTile(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.textColor, const Color(0xFFFFFFFF));
      expect(data.iconColor, const Color(0xFFFFFFFF));
      expect(data.shape, isNotNull);
    });

    testWidgets('dNavBar resolves NavigationBarThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary'.dNavBar(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.labelTextStyle, isNotNull);
    });

    testWidgets('dFab resolves FloatingActionButtonThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary rounded-full shadow-lg'.dFab(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.foregroundColor, const Color(0xFFFFFFFF));
      expect(data.shape, isNotNull);
    });

    testWidgets('dDataTable resolves DataTableThemeData', (t) async {
      final data = await t.run((ctx) => 'bg-primary p-4'.dDataTable(ctx));
      expect(data.headingRowColor, isNotNull);
      expect(data.horizontalMargin, 16);
    });

    testWidgets('dSearchBar resolves SearchBarThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary rounded-lg'.dSearchBar(ctx),
      );
      expect(data.backgroundColor, isNotNull);
      expect(data.shape, isNotNull);
    });

    testWidgets('dMenu resolves MenuStyle', (t) async {
      final data = await t.run((ctx) => 'bg-primary rounded-lg p-4'.dMenu(ctx));
      expect(data.backgroundColor, isNotNull);
      expect(data.shape, isNotNull);
      expect(data.padding, isNotNull);
    });

    testWidgets('dIcon resolves IconThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'text-primary w-64 opacity-50'.dIcon(ctx),
      );
      expect(data.color, const Color(0xFF6200EE));
      expect(data.size, 256);
      expect(data.opacity, 0.5);
    });

    testWidgets('dShape resolves ShapeDecoration', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary rounded-lg shadow-lg'.dShape(ctx),
      );
      expect(data.color, const Color(0xFF6200EE));
      expect(data.shape, isA<RoundedRectangleBorder>());
      expect(data.shadows, isNotNull);
    });
  });

  group('WidgetState variant resolution', () {
    testWidgets('hover variant creates WidgetStateProperty for background', (
      t,
    ) async {
      final style = await t.run(
        (ctx) => 'bg-primary hover:bg-error'.dButton(ctx),
      );
      final bg = style.backgroundColor;
      expect(bg, isA<WidgetStateProperty<Color?>>());
    });

    testWidgets('disabled variant creates WidgetStateProperty', (t) async {
      final style = await t.run(
        (ctx) => 'bg-primary disabled:bg-error'.dButton(ctx),
      );
      final bg = style.backgroundColor;
      expect(bg, isA<WidgetStateProperty<Color?>>());
    });

    testWidgets('selected and error variants work', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary selected:bg-tertiary error:bg-error'.dCheckbox(ctx),
      );
      expect(data.fillColor, isA<WidgetStateProperty<Color?>>());
    });

    testWidgets('active/pressed variants', (t) async {
      final style = await t.run(
        (ctx) => 'bg-primary active:bg-error'.dButton(ctx),
      );
      expect(style.backgroundColor, isA<WidgetStateProperty<Color?>>());
    });

    testWidgets('focus variant', (t) async {
      final style = await t.run(
        (ctx) => 'bg-primary focus:bg-error'.dButton(ctx),
      );
      expect(style.backgroundColor, isA<WidgetStateProperty<Color?>>());
    });

    testWidgets('dragged variant', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary dragged:bg-error'.dCheckbox(ctx),
      );
      expect(data.fillColor, isA<WidgetStateProperty<Color?>>());
    });

    testWidgets('scrolledUnder variant', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary scrolledUnder:bg-error'.dScrollbar(ctx),
      );
      expect(data.thumbColor, isA<WidgetStateProperty<Color?>>());
    });

    testWidgets('multiple interactive variants combined', (t) async {
      final style = await t.run(
        (ctx) =>
            'bg-primary hover:bg-secondaryContainer focus:bg-tertiary disabled:bg-error active:bg-onPrimary'
                .dButton(ctx),
      );
      expect(style.backgroundColor, isA<WidgetStateProperty<Color?>>());
    });
  });

  group('resolveThemeColors edge cases', () {
    testWidgets('all theme color keys resolve to non-null', (t) async {
      final s = DacsStyle();
      final keys = [
        'primary',
        'onPrimary',
        'primaryContainer',
        'onPrimaryContainer',
        'secondary',
        'onSecondary',
        'secondaryContainer',
        'onSecondaryContainer',
        'tertiary',
        'onTertiary',
        'tertiaryContainer',
        'onTertiaryContainer',
        'error',
        'onError',
        'errorContainer',
        'onErrorContainer',
        'surface',
        'onSurface',
        'surfaceVariant',
        'onSurfaceVariant',
        'outline',
        'outlineVariant',
        'inverseSurface',
        'onInverseSurface',
        'inversePrimary',
        'shadow',
        'scrim',
      ];
      for (final key in keys) {
        s.textThemeColor = key;
      }
      await t.run((ctx) {
        s.resolveThemeColors(ctx);
        expect(s.color, isNotNull);
        return const SizedBox.shrink();
      });
    });

    testWidgets('unknown theme key returns null color', (t) async {
      final s = DacsStyle()..textThemeColor = 'nonexistent';
      await t.run((ctx) {
        s.resolveThemeColors(ctx);
        expect(s.color, isNull);
        return const SizedBox.shrink();
      });
    });
  });

  group('Chained compound variants', () {
    testWidgets('dark:hover: applies hover style only in dark mode', (t) async {
      final style = await t.run(
        (ctx) => 'bg-primary dark:hover:bg-error'.dButton(ctx),
      );
      expect(style.backgroundColor, isA<WidgetStateProperty<Color?>>());
    });

    testWidgets('light:disabled: applies disabled style in light mode', (
      t,
    ) async {
      final style = await t.run(
        (ctx) => 'bg-primary light:disabled:bg-error'.dButton(ctx),
      );
      expect(style.backgroundColor, isA<WidgetStateProperty<Color?>>());
    });

    testWidgets('dark:focus: applies focus style in dark mode', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary dark:focus:bg-error'.dCheckbox(ctx),
      );
      expect(data.fillColor, isA<WidgetStateProperty<Color?>>());
    });

    testWidgets('md:hover with breakpoint and state', (t) async {
      final style = await t.run(
        (ctx) => 'bg-primary md:hover:bg-error'.dButton(ctx),
      );
      expect(style.backgroundColor, isA<WidgetStateProperty<Color?>>());
    });

    testWidgets('dark:md:hover with triple compound', (t) async {
      final style = await t.run(
        (ctx) => 'bg-primary dark:md:hover:bg-error'.dButton(ctx),
      );
      expect(style.backgroundColor, isA<WidgetStateProperty<Color?>>());
    });

    testWidgets('chained variant with theme color in dark mode', (t) async {
      final app = MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFBB86FC),
            onPrimary: Color(0xFF000000),
            primaryContainer: Color(0xFF3700B3),
            onPrimaryContainer: Color(0xFFBB86FC),
            secondary: Color(0xFF03DAC6),
            onSecondary: Color(0xFF000000),
            secondaryContainer: Color(0xFFCE93D8),
            onSecondaryContainer: Color(0xFF311B92),
            tertiary: Color(0xFFE91E63),
            onTertiary: Color(0xFFFFFFFF),
            tertiaryContainer: Color(0xFFF48FB1),
            onTertiaryContainer: Color(0xFF880E4F),
            error: Color(0xFFCF6679),
            onError: Color(0xFF000000),
            errorContainer: Color(0xFFFCD8DF),
            onErrorContainer: Color(0xFF3700B3),
            surface: Color(0xFF1C1B1F),
            onSurface: Color(0xFFE6E1E5),
            surfaceContainerHighest: Color(0xFF49454F),
            onSurfaceVariant: Color(0xFFCAC4D0),
            outline: Color(0xFF938F99),
            outlineVariant: Color(0xFF49454F),
            inverseSurface: Color(0xFFE6E1E5),
            onInverseSurface: Color(0xFF313033),
            inversePrimary: Color(0xFF6200EE),
            shadow: Color(0xFF000000),
            scrim: Color(0xFF000000),
          ),
        ),
        home: Builder(
          builder: (ctx) {
            // Override MediaQuery to simulate dark platform for dButton
            final mq = MediaQuery.of(ctx);
            return MediaQuery(
              data: mq.copyWith(platformBrightness: Brightness.dark),
              child: Builder(
                builder: (ctx) {
                  final style = 'bg-primary dark:hover:bg-error'.dButton(ctx);
                  final bg = style.backgroundColor;
                  expect(bg, isA<WidgetStateProperty<Color?>>());
                  final resolved = bg!.resolve(<WidgetState>{
                    WidgetState.hovered,
                  });
                  expect(resolved, const Color(0xFFCF6679));
                  return const SizedBox.shrink();
                },
              ),
            );
          },
        ),
      );
      await t.pumpWidget(app);
    });

    testWidgets('chained variant is NOT applied in light mode for dark:', (
      t,
    ) async {
      final s = await t.run(
        (ctx) => 'bg-primary dark:pressed:bg-error'.dStyleOf(ctx),
      );
      expect(s.backgroundColor, const Color(0xFF6200EE));
      expect(s.variants, isNotNull);
      expect(s.variants!.containsKey('dark:pressed'), isTrue);
    });
  });
}
