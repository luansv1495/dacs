import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

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

  group('Material extensions', () {
    testWidgets('dAppBar resolves AppBarTheme', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary text-onPrimary rounded-lg w-6 h-16 p-2 m-4 shadow-lg'
                .dAppBar(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.foregroundColor, const Color(0xFFFFFFFF));
      expect(data.shape, isNotNull);
      expect(data.iconTheme?.size, 24);
      expect(data.actionsIconTheme?.color, const Color(0xFFFFFFFF));
      expect(data.leadingWidth, 24);
      expect(data.toolbarHeight, 64);
      expect(data.actionsPadding, isNotNull);
    });

    testWidgets('dCard resolves CardTheme', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary rounded-lg m-4 overflow-hidden'.dCard(ctx),
      );
      expect(data.color, const Color(0xFF6200EE));
      expect(data.surfaceTintColor, const Color(0xFF6200EE));
      expect(data.shape, isNotNull);
      expect(data.margin, isNotNull);
      expect(data.clipBehavior, Clip.hardEdge);
    });

    testWidgets('dListTile resolves ListTileThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary selected:bg-secondary text-onPrimary p-4 min-w-10 min-h-12 gap-2 dense'
                .dListTile(ctx),
      );
      expect(data.tileColor, const Color(0xFF6200EE));
      expect(data.selectedTileColor, const Color(0xFF03DAC6));
      expect(data.textColor, const Color(0xFFFFFFFF));
      expect(data.contentPadding, isNotNull);
      expect(data.titleTextStyle?.color, const Color(0xFFFFFFFF));
      expect(data.dense, isTrue);
      expect(data.horizontalTitleGap, 8);
      expect(data.minLeadingWidth, 40);
      expect(data.minTileHeight, 48);
    });

    testWidgets('dTabBar resolves TabBarTheme', (t) async {
      final data = await t.run(
        (ctx) =>
            'text-primary unselected-secondary bg-surface hover:overlay-secondary font-bold border-outline border p-2 tab-indicator-label splash-none'
                .dTabBar(ctx),
      );
      expect(data.labelColor, const Color(0xFF6200EE));
      expect(data.unselectedLabelColor, const Color(0xFF03DAC6));
      expect(data.labelStyle, isNotNull);
      expect(data.indicator, isA<ShapeDecoration>());
      expect(data.dividerColor, const Color(0xFF79747E));
      expect(data.dividerHeight, 1);
      expect(data.indicatorSize, TabBarIndicatorSize.label);
      expect(data.labelPadding, isNotNull);
      expect(
        data.overlayColor!.resolve({WidgetState.hovered}),
        const Color(0xFF03DAC6),
      );
      expect(data.splashFactory, NoSplash.splashFactory);
    });

    testWidgets('dProgress resolves ProgressIndicatorThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'text-primary bg-surface'.dProgress(ctx),
      );
      expect(data.color, const Color(0xFF6200EE));
      expect(data.linearTrackColor, const Color(0xFFFFFBFE));
      expect(data.circularTrackColor, const Color(0xFFFFFBFE));
    });

    testWidgets('dTooltip resolves TooltipThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary text-onPrimary rounded-lg p-2 m-1 tooltip-above no-feedback tooltip-wait-500 tooltip-show-1500 tooltip-exit-100'
                .dTooltip(ctx),
      );
      expect(data.decoration, isNotNull);
      expect(data.textStyle, isNotNull);
      expect(data.padding, isNotNull);
      expect(data.margin, isNotNull);
      expect(data.constraints, isNull);
      expect(data.preferBelow, isFalse);
      expect(data.enableFeedback, isFalse);
      expect(data.waitDuration, const Duration(milliseconds: 500));
      expect(data.showDuration, const Duration(milliseconds: 1500));
      expect(data.exitDuration, const Duration(milliseconds: 100));
    });

    testWidgets('dDivider resolves DividerThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'text-primary border-2 w-10'.dDivider(ctx),
      );
      expect(data.color, const Color(0xFF6200EE));
      expect(data.thickness, 8);
    });

    testWidgets('dSnackBar resolves SnackBarThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary text-onPrimary disabled-action-error rounded-lg show-close snackbar-fixed'
                .dSnackBar(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.contentTextStyle, isNotNull);
      expect(data.shape, isNotNull);
      expect(data.actionTextColor, const Color(0xFFFFFFFF));
      expect(data.disabledActionTextColor, const Color(0xFFB00020));
      expect(data.closeIconColor, const Color(0xFFFFFFFF));
      expect(data.showCloseIcon, isTrue);
      expect(data.behavior, SnackBarBehavior.fixed);
    });

    testWidgets('dDialog resolves DialogTheme', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary barrier-scrim rounded-lg shadow-lg'.dDialog(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.shape, isNotNull);
      expect(data.elevation, isNotNull);
      expect(data.shadowColor, isNotNull);
      expect(data.surfaceTintColor, const Color(0xFF6200EE));
      expect(data.barrierColor, const Color(0xFF000000));
    });

    testWidgets('dBottomSheet resolves BottomSheetThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary barrier-scrim rounded-lg shadow-lg show-drag-handle'
                .dBottomSheet(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.modalBackgroundColor, const Color(0xFF6200EE));
      expect(data.modalBarrierColor, const Color(0xFF000000));
      expect(data.shape, isNotNull);
      expect(data.showDragHandle, isTrue);
    });

    testWidgets('dExpansionTile resolves ExpansionTileThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary rounded-lg'.dExpansionTile(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.textColor, const Color(0xFFFFFFFF));
      expect(data.iconColor, const Color(0xFFFFFFFF));
      expect(data.shape, isNotNull);
      expect(data.collapsedIconColor, isNull);
    });

    testWidgets('dFab resolves FloatingActionButtonThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary text-onPrimary rounded-full shadow-lg active:bg-error hover:bg-secondary hover:shadow-sm disabled:shadow-sm small:w-10 small:h-10 large:w-16 large:h-16 extended:w-32 extended:h-12'
                .dFab(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.foregroundColor, const Color(0xFFFFFFFF));
      expect(data.shape, isNotNull);
      expect(data.extendedTextStyle?.color, const Color(0xFFFFFFFF));
      expect(data.splashColor, const Color(0xFFB00020));
      expect(data.hoverColor, const Color(0xFF03DAC6));
      expect(data.hoverElevation, isNot(data.elevation));
      expect(data.disabledElevation, isNotNull);
      expect(data.smallSizeConstraints?.minWidth, 40);
      expect(data.largeSizeConstraints?.minWidth, 64);
      expect(data.extendedSizeConstraints?.minWidth, 128);
    });

    testWidgets('dIcon resolves IconThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'text-primary w-64 opacity-50 icon-fill icon-weight-600 icon-grade--25 icon-optical-48'
                .dIcon(ctx),
      );
      expect(data.color, const Color(0xFF6200EE));
      expect(data.size, 256);
      expect(data.opacity, 0.5);
      expect(data.shadows, isNull);
      expect(data.fill, 1);
      expect(data.weight, 600);
      expect(data.grade, -25);
      expect(data.opticalSize, 48);
    });

    testWidgets('dShape resolves ShapeDecoration', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary rounded-lg shadow-lg object-cover image-asset-[assets/card.png]'
                .dShape(ctx),
      );
      expect(data.color, const Color(0xFF6200EE));
      expect(data.shape, isA<RoundedRectangleBorder>());
      expect(data.shadows, isNotNull);
      expect(data.image, isNotNull);
      expect(data.image!.fit, BoxFit.cover);
    });
  });
}
