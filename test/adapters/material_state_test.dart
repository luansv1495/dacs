import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';
import 'package:dacs/src/adapters/material_state.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
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

    testWidgets('materialStateFor resolves theme color variant overrides', (
      t,
    ) async {
      final state = await t.run(
        (ctx) => materialStateFor(
          'decoration-red-500 from-red-500 via-red-500 to-red-500 '
                  'hover:decoration-primary hover:from-secondaryContainer '
                  'hover:via-tertiary hover:to-inversePrimary'
              .dStyle,
          DacsResolveContext.fromBuildContext(ctx),
        ),
      );

      final hover = state.variants['hover']!;
      expect(hover.textDecorationColor, const Color(0xFF6200EE));
      expect(hover.gradientFromColor, const Color(0xFFCE93D8));
      expect(hover.gradientViaColor, const Color(0xFFE91E63));
      expect(hover.gradientToColor, const Color(0xFFBB86FC));
    });

    test('widgetStateForName falls back to hovered for unknown names', () {
      expect(widgetStateForName('unknown'), WidgetState.hovered);
    });

    test('dacsSide, dacsShape, and dacsOutline handle fallbacks', () {
      expect(dacsSide(DacsStyle()), isNull);
      expect(dacsShape(DacsStyle()), isNull);
      expect(dacsOutline(DacsStyle()), isNull);

      final side = dacsSide(DacsStyle()..borderWidth = 3);
      expect(side?.color, const Color(0xFF000000));
      expect(side?.width, 3);

      final outline = dacsOutline(
        DacsStyle()
          ..borderWidth = 2
          ..borderRadius = BorderRadiusDirectional.circular(8),
      );
      expect(outline, isA<OutlineInputBorder>());
      expect(outline!.borderRadius, BorderRadius.zero);
    });

    test('dacsStateProp resolves selected/error/dragged/scrolledUnder states',
        () {
      final state = DacsMaterialState(
        DacsStyle(),
        {
          'selected': DacsStyle()..fontSize = 1,
          'error': DacsStyle()..fontSize = 2,
          'dragged': DacsStyle()..fontSize = 3,
          'scrolledUnder': DacsStyle()..fontSize = 4,
        },
        const {},
        const [],
        const [],
      );
      final prop = dacsStateProp<double?>(
        state,
        (s) => s.fontSize,
      );

      expect(prop.resolve({WidgetState.selected}), 1);
      expect(prop.resolve({WidgetState.error}), 2);
      expect(prop.resolve({WidgetState.dragged}), 3);
      expect(prop.resolve({WidgetState.scrolledUnder}), 4);
    });

    test('dacsStateOverrideProp uses only explicit override styles', () {
      final state = DacsMaterialState(
        DacsStyle()..fontSize = 3,
        {
          'hover': DacsStyle()
            ..fontSize = 3
            ..backgroundColor = Colors.red,
        },
        {
          'hover': DacsStyle()..backgroundColor = Colors.red,
        },
        [
          DacsStateRule(
            {WidgetState.hovered, WidgetState.focused},
            DacsStyle()
              ..fontSize = 3
              ..backgroundColor = Colors.blue,
          ),
        ],
        [
          DacsStateRule(
            {WidgetState.hovered, WidgetState.focused},
            DacsStyle()..backgroundColor = Colors.blue,
          ),
        ],
      );
      final overrideColor = dacsStateOverrideProp<Color>(
        state,
        (s) => s.backgroundColor,
      );
      final overrideFontSize = dacsStateOverrideProp<double>(
        state,
        (s) => s.fontSize,
      );

      expect(
        overrideColor.resolve({WidgetState.hovered, WidgetState.focused}),
        Colors.blue,
      );
      expect(overrideColor.resolve({WidgetState.hovered}), Colors.red);
      expect(overrideFontSize.resolve({WidgetState.hovered}), isNull);
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
            // ignore: deprecated_member_use
            surfaceVariant: Color(0xFF49454F),
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
      expect(s.variants, isNull);
    });
  });
}
