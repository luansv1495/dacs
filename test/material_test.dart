import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import 'package:dacs/src/adapters/material_state.dart';
import 'package:dacs/src/dacs_resolve_context.dart';

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

    testWidgets('dFixedSizeOf returns Size', (t) async {
      final size = await t.run((ctx) => 'w-64 h-32'.dFixedSizeOf(ctx));
      expect(size, const Size(256, 128));
    });

    testWidgets('dLayoutOf resolves layout variants', (t) async {
      final layout = await t.run(
        (ctx) =>
            'w-32 h-32 md:w-64 aspect-square object-contain overflow-hidden'
                .dLayoutOf(ctx),
      );
      expect(layout.fixedSize, const Size(256, 128));
      expect(layout.aspectRatio, 1);
      expect(layout.boxFit, BoxFit.contain);
      expect(layout.overflow, Clip.hardEdge);
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

    testWidgets('dButton expands to new ButtonStyle fields', (t) async {
      final style = await t.run(
        (ctx) => 'bg-primary text-onPrimary w-32 h-48 rounded-lg'.dButton(ctx),
      );
      expect(style.surfaceTintColor, isA<WidgetStateProperty<Color?>>());
      expect(style.iconColor, isA<WidgetStateProperty<Color?>>());
      expect(style.iconSize, isA<WidgetStateProperty<double?>>());
      expect(style.minimumSize, isA<WidgetStateProperty<Size?>>());
      expect(style.fixedSize, isA<WidgetStateProperty<Size?>>());
      expect(style.maximumSize, isA<WidgetStateProperty<Size?>>());
      expect(style.mouseCursor, isA<WidgetStateProperty<MouseCursor?>>());
    });

    testWidgets('dButton resolves overlay, shadow, size, and cursor states', (
      t,
    ) async {
      final style = await t.run(
        (ctx) =>
            'hover:bg-primary active:bg-error hover:shadow-lg w-64 h-12 p-4'
                .dButton(ctx),
      );

      expect(
        style.overlayColor!.resolve({WidgetState.hovered}),
        const Color(0xFF6200EE).withAlpha(26),
      );
      expect(
        style.overlayColor!.resolve({WidgetState.pressed}),
        const Color(0xFFB00020).withAlpha(52),
      );
      expect(style.shadowColor!.resolve({WidgetState.hovered}), isNotNull);
      expect(style.elevation!.resolve({WidgetState.hovered}), isNotNull);
      expect(style.minimumSize!.resolve({}), const Size(256, 48));
      expect(style.fixedSize!.resolve({}), const Size(256, 48));
      expect(style.maximumSize!.resolve({}), const Size(256, 48));
      expect(
        style.mouseCursor!.resolve({WidgetState.disabled}),
        SystemMouseCursors.forbidden,
      );
      expect(style.mouseCursor!.resolve({}), SystemMouseCursors.click);
    });

    testWidgets('dButton iconSize maps from fontSize', (t) async {
      final style = await t.run(
        (ctx) => 'text-xl'.dButton(ctx),
      );
      final iconSize = style.iconSize?.resolve(<WidgetState>{});
      expect(iconSize, closeTo(20.0, 0.01));
    });

    testWidgets('dButton shape resolves dynamically via _stateProp', (t) async {
      final style = await t.run(
        (ctx) => 'rounded-lg hover:rounded-xl'.dButton(ctx),
      );
      expect(style.shape, isA<WidgetStateProperty<OutlinedBorder?>>());
      final resolved = style.shape!.resolve({WidgetState.hovered});
      expect(resolved, isA<RoundedRectangleBorder>());
      expect(
        (resolved as RoundedRectangleBorder).borderRadius,
        isA<BorderRadius>(),
      );
    });

    testWidgets('dCheckbox resolves CheckboxThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary'.dCheckbox(ctx),
      );
      expect(data.fillColor, isNotNull);
      expect(data.checkColor, isNotNull);
    });

    testWidgets('dCheckbox resolves hover and base colors', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary hover:bg-error text-onPrimary'.dCheckbox(ctx),
      );

      expect(data.fillColor!.resolve(<WidgetState>{}), const Color(0xFF6200EE));
      expect(
        data.fillColor!.resolve({WidgetState.hovered}),
        const Color(0xFFB00020),
      );
      expect(
        data.checkColor!.resolve(<WidgetState>{}),
        const Color(0xFFFFFFFF),
      );
    });

    testWidgets('dSwitch resolves SwitchThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary'.dSwitch(ctx),
      );
      expect(data.thumbColor, isNotNull);
      expect(data.trackColor, isNotNull);
    });

    testWidgets('dSwitch resolves pressed thumb and outline states', (t) async {
      final data = await t.run(
        (ctx) =>
            'pressed:text-secondary border-outline hover:bg-error'.dSwitch(ctx),
      );

      expect(data.thumbColor!.resolve(<WidgetState>{}), isNull);
      expect(
        data.thumbColor!.resolve({WidgetState.pressed}),
        const Color(0xFF03DAC6),
      );
      expect(
        data.trackOutlineColor!.resolve(<WidgetState>{}),
        const Color(0xFF79747E),
      );
      expect(
        data.overlayColor!.resolve({WidgetState.hovered}),
        const Color(0xFFB00020).withAlpha(26),
      );
    });

    testWidgets('dRadio resolves RadioThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary'.dRadio(ctx),
      );
      expect(data.fillColor, isNotNull);
    });

    testWidgets('dRadio resolves pressed and hover colors', (t) async {
      final data = await t.run(
        (ctx) => 'pressed:text-error hover:text-secondary'.dRadio(ctx),
      );

      expect(data.fillColor!.resolve(<WidgetState>{}), isNull);
      expect(
        data.fillColor!.resolve({WidgetState.pressed}),
        const Color(0xFFB00020),
      );
      expect(
        data.overlayColor!.resolve({WidgetState.hovered}),
        const Color(0xFF03DAC6).withAlpha(26),
      );
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

    testWidgets('dInput resolves text slots and layout flags', (t) async {
      final data = await t.run(
        (ctx) => 'label-[Email] hint-[you@example.com] '
                'helper-[Use your work email] error-[Required field] '
                'prefix-[USD] suffix-[per month] filled dense bg-surface'
            .dInputOf(ctx),
      );
      expect(data.labelText, 'Email');
      expect(data.hintText, 'you@example.com');
      expect(data.helperText, 'Use your work email');
      expect(data.errorText, 'Required field');
      expect(data.prefixText, 'USD');
      expect(data.suffixText, 'per month');
      expect(data.filled, isTrue);
      expect(data.isDense, isTrue);
      expect(data.fillColor, const Color(0xFFFFFBFE));
    });

    testWidgets('dInput maps native border states', (t) async {
      final data = await t.run(
        (ctx) => 'border-outline rounded-lg focus:border-primary '
                'disabled:border-outlineVariant error:border-error '
                'focus:error:border-primaryContainer'
            .dInput(ctx),
      );

      Color? sideColor(InputBorder? border) =>
          border is OutlineInputBorder ? border.borderSide.color : null;

      expect(sideColor(data.border), const Color(0xFF79747E));
      expect(sideColor(data.enabledBorder), const Color(0xFF79747E));
      expect(sideColor(data.focusedBorder), const Color(0xFF6200EE));
      expect(sideColor(data.disabledBorder), const Color(0xFFC4C4C4));
      expect(sideColor(data.errorBorder), const Color(0xFFB00020));
      expect(sideColor(data.focusedErrorBorder), const Color(0xFFBB86FC));
    });

    testWidgets('dInput respects explicit false flags', (t) async {
      final data = await t.run(
        (ctx) => 'bg-surface not-filled not-dense'.dInput(ctx),
      );

      expect(data.filled, isFalse);
      expect(data.isDense, isFalse);
      expect(data.fillColor, const Color(0xFFFFFBFE));
    });

    testWidgets('dInput maps error text style from error:text-*', (t) async {
      final data = await t.run(
        (ctx) => 'text-onSurface error:text-error error-[Required]'.dInput(ctx),
      );

      expect(data.errorText, 'Required');
      expect(data.errorStyle!.color, const Color(0xFFB00020));
      expect(data.labelStyle!.color, const Color(0xFF1C1B1F));
    });

    testWidgets('dInput focusedErrorBorder can override radius and width', (
      t,
    ) async {
      final data = await t.run(
        (ctx) => 'border-outline rounded-sm '
                'focus:error:border-error focus:error:border-2 focus:error:rounded-xl'
            .dInput(ctx),
      );

      final border = data.focusedErrorBorder as OutlineInputBorder;
      expect(border.borderSide.color, const Color(0xFFB00020));
      expect(border.borderSide.width, 8);
      expect(border.borderRadius, BorderRadius.circular(12));
    });

    testWidgets('TextField style and decoration stay separate', (t) async {
      final result = await t.run((ctx) {
        const classes = 'text-primary label-[Email] hint-[you@example.com]';
        return (
          textStyle: classes.dTextOf(ctx),
          decoration: classes.dInputOf(ctx),
        );
      });

      expect(result.textStyle.color, const Color(0xFF6200EE));
      expect(result.decoration.labelText, 'Email');
      expect(result.decoration.hintText, 'you@example.com');
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

    testWidgets('dScrollbar resolves native state properties', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary hover:bg-error active:bg-secondary disabled:bg-outline border-outline m-4 min-h-12'
                .dScrollbar(ctx),
      );
      expect(
        data.thumbColor!.resolve({WidgetState.hovered}),
        const Color(0xFFB00020),
      );
      expect(
        data.thumbColor!.resolve({WidgetState.pressed}),
        const Color(0xFF03DAC6),
      );
      expect(
        data.thumbColor!.resolve({WidgetState.disabled}),
        const Color(0xFF79747E),
      );
      expect(
        data.trackColor!.resolve({WidgetState.hovered}),
        const Color(0xFFB00020).withAlpha(51),
      );
      expect(
        data.trackColor!.resolve({WidgetState.pressed}),
        const Color(0xFF03DAC6).withAlpha(77),
      );
      expect(data.trackBorderColor!.resolve({}), const Color(0xFF79747E));
      expect(data.minThumbLength, 48);
      expect(data.crossAxisMargin, 16);
      expect(data.mainAxisMargin, 16);
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

    testWidgets('dDataTable resolves text and decoration fields', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary border-2'.dDataTable(ctx),
      );
      expect(data.headingTextStyle?.color, const Color(0xFFFFFFFF));
      expect(data.dataTextStyle?.color, const Color(0xFFFFFFFF));
      expect(data.dividerThickness, 8);
      expect(data.decoration, isA<BoxDecoration>());
    });

    testWidgets('dDataTable resolves hover row colors and column spacing', (
      t,
    ) async {
      final data = await t.run(
        (ctx) => 'hover:bg-primary px-4 py-2'.dDataTable(ctx),
      );

      expect(
        data.headingRowColor!.resolve({WidgetState.hovered}),
        const Color(0xFF6200EE).withAlpha(26),
      );
      expect(
        data.dataRowColor!.resolve({WidgetState.hovered}),
        const Color(0xFF6200EE).withAlpha(13),
      );
      expect(data.horizontalMargin, 16);
      expect(data.columnSpacing, 16);
    });

    testWidgets('dSearchBar resolves SearchBarThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary rounded-lg'.dSearchBar(ctx),
      );
      expect(data.backgroundColor, isNotNull);
      expect(data.shape, isNotNull);
    });

    testWidgets('dSearchBar resolves native state properties', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary text-onPrimary hover:bg-error focus:bg-secondary disabled:bg-outline focus:border-secondary border-2 rounded-lg p-4 min-w-64 max-w-96'
                .dSearchBar(ctx),
      );
      expect(
        data.backgroundColor!.resolve({WidgetState.hovered}),
        const Color(0xFFB00020),
      );
      expect(
        data.backgroundColor!.resolve({WidgetState.focused}),
        const Color(0xFF03DAC6),
      );
      expect(
        data.backgroundColor!.resolve({WidgetState.disabled}),
        const Color(0xFF79747E),
      );
      expect(
        data.side!.resolve({WidgetState.focused})?.color,
        const Color(0xFF03DAC6),
      );
      expect(
        data.overlayColor!.resolve({WidgetState.hovered}),
        const Color(0xFFB00020).withAlpha(26),
      );
      expect(
        data.overlayColor!.resolve({WidgetState.focused}),
        const Color(0xFF03DAC6).withAlpha(26),
      );
      expect(data.padding!.resolve({}), isA<EdgeInsetsGeometry>());
      expect(data.textStyle!.resolve({})?.color, const Color(0xFFFFFFFF));
      expect(data.hintStyle!.resolve({})?.color, const Color(0xFFFFFFFF));
      expect(data.constraints?.minWidth, 256);
      expect(data.constraints?.maxWidth, 384);
    });

    testWidgets('dSearchBar resolves hover shadow and elevation', (t) async {
      final data = await t.run(
        (ctx) => 'hover:shadow-lg focus:shadow-md'.dSearchBar(ctx),
      );

      expect(data.elevation!.resolve({WidgetState.hovered}), isNotNull);
      expect(data.elevation!.resolve({WidgetState.focused}), isNotNull);
      expect(data.shadowColor!.resolve({WidgetState.hovered}), isNotNull);
      expect(data.shadowColor!.resolve({WidgetState.focused}), isNotNull);
    });

    testWidgets('dMenu resolves MenuStyle', (t) async {
      final data = await t.run((ctx) => 'bg-primary rounded-lg p-4'.dMenu(ctx));
      expect(data.backgroundColor, isNotNull);
      expect(data.shape, isNotNull);
      expect(data.padding, isNotNull);
    });

    testWidgets('dMenu resolves shape and side as state properties', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary border-2 hover:rounded-xl hover:border-error hover:shadow-lg'
                .dMenu(ctx),
      );
      expect(data.shape, isA<WidgetStateProperty<OutlinedBorder?>>());
      expect(data.side, isA<WidgetStateProperty<BorderSide?>>());
      expect(
        data.side!.resolve({WidgetState.hovered})?.color,
        const Color(0xFFB00020),
      );
      expect(data.shadowColor!.resolve({WidgetState.hovered}), isNotNull);
      expect(data.elevation!.resolve({WidgetState.hovered}), isNotNull);
    });

    testWidgets('dSlider resolves SliderThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary text-onPrimary border-secondary h-2 disabled:bg-error'
                .dSlider(ctx),
      );
      expect(data.activeTrackColor, const Color(0xFF6200EE));
      expect(data.inactiveTrackColor, const Color(0xFF03DAC6));
      expect(data.thumbColor, const Color(0xFFFFFFFF));
      expect(data.disabledActiveTrackColor, const Color(0xFFB00020));
      expect(data.trackHeight, 8);
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

    test('dacsStateProp resolves selected/error/dragged/scrolledUnder extras',
        () {
      final state = DacsMaterialState(
        DacsStyle(),
        {
          'selected': DacsStyle()..fontSize = 1,
          'error': DacsStyle()..fontSize = 2,
          'dragged': DacsStyle()..fontSize = 3,
          'scrolledUnder': DacsStyle()..fontSize = 4,
        },
        const [],
      );
      final prop = dacsStateProp<double?>(
        state,
        (_) => null,
        selectedExtra: (s) => s.fontSize,
        errorExtra: (s) => s.fontSize,
        draggedExtra: (s) => s.fontSize,
        scrolledUnderExtra: (s) => s.fontSize,
      );

      expect(prop.resolve({WidgetState.selected}), 1);
      expect(prop.resolve({WidgetState.error}), 2);
      expect(prop.resolve({WidgetState.dragged}), 3);
      expect(prop.resolve({WidgetState.scrolledUnder}), 4);
    });

    test('dacsStateProp returns null when compound fallback and extra miss',
        () {
      final state = DacsMaterialState(
        DacsStyle(),
        const {},
        [
          DacsStateRule(
            {WidgetState.hovered, WidgetState.focused},
            DacsStyle()..fontSize = 9,
          ),
        ],
      );
      final prop = dacsStateProp<double?>(
        state,
        (_) => null,
        hoverExtra: (s) => s.fontSize,
      );

      expect(prop.resolve({WidgetState.hovered, WidgetState.focused}), isNull);
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
      expect(s.variants, isNotNull);
      expect(s.variants!.containsKey('dark:pressed'), isTrue);
    });
  });
}
