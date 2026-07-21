import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('Important', () {
    test('sets isImportant with ! suffix', () {
      final style = 'text-red-500!'.dBase;
      expect(style.isImportant, isTrue);
      expect(style.color, const Color(0xFFEF4444));
    });

    test('important prevents variant override', () {
      final style = 'text-red-500! dark:text-blue-300'.dStyle;
      final resolved = style.resolve(brightness: Brightness.dark);
      expect(resolved.color, const Color(0xFFEF4444));
    });

    test('important does not affect non-important', () {
      final style = 'text-lg'.dBase;
      expect(style.isImportant, isFalse);
    });

    test('variant with important', () {
      final style = 'text-lg dark:text-white!'.dStyle;
      final resolved = style.resolve(brightness: Brightness.dark);
      expect(resolved.color, const Color(0xFFFFFFFF));
    });
  });

  group('DacsStyleSheet', () {
    test('.dStyle returns a stylesheet and .dBase returns only base values',
        () {
      final sheet = 'text-sm dark:text-white hover:bg-red-500'.dStyle;
      final base = 'text-sm dark:text-white hover:bg-red-500'.dBase;

      expect(sheet, isA<DacsStyleSheet>());
      expect(sheet.base.fontSize, 14);
      expect(sheet.rules, hasLength(2));
      expect(sheet.rules.first.condition.name, 'dark');
      expect(sheet.rules.last.condition.name, 'hover');
      expect(base.fontSize, 14);
      expect(base.variants, isNull);
    });

    test('rules expose typed conditional parser output', () {
      final rules = 'dark:text-white md:hover:bg-blue-500'.dStyle.rules;

      expect(rules, hasLength(2));
      expect(rules.first.condition.name, 'dark');
      expect(rules.first.style.color, const Color(0xFFFFFFFF));
      expect(rules.last.condition.name, 'md:hover');
      expect(rules.last.style.backgroundColor, const Color(0xFF3B82F6));
    });

    test('resolve ignores unmatched compound state variants', () {
      final resolved = 'bg-white dark:hover:bg-red-500'.dStyle.resolve(
            brightness: Brightness.light,
            screenWidth: 1200,
          );

      expect(resolved.backgroundColor, const Color(0xFFFFFFFF));
      expect(resolved.variants, isNull);
    });

    test('resolve remaps matched compound state variants', () {
      final resolved = 'bg-white dark:md:hover:bg-red-500'.dStyle.resolve(
            brightness: Brightness.dark,
            screenWidth: 900,
          );

      expect(resolved.backgroundColor, const Color(0xFFFFFFFF));
      expect(resolved.variants, isNotNull);
      expect(resolved.variants!.keys, contains('hover'));
      expect(resolved.variants!['hover']!.backgroundColor,
          const Color(0xFFEF4444));
    });

    test('resolve returns a clone when there are no conditional rules', () {
      final base = DacsStyle()..color = const Color(0xFF111111);
      final resolved = DacsStyleSheet(base).resolve();

      expect(resolved, isA<DacsResolvedStyle>());
      expect(resolved.color, const Color(0xFF111111));
      expect(identical(resolved, base), isFalse);
    });

    test('resolved style does not expose mutable parser state', () {
      final resolved = 'text-sm hover:text-lg'.dStyle.resolve();
      final mutable = resolved.toMutableStyle()..fontSize = 99;
      final variants = resolved.variants!;

      variants['hover']!.fontSize = 42;

      expect(mutable.fontSize, 99);
      expect(resolved.fontSize, 14);
      expect(resolved.variants!['hover']!.fontSize, 18);
      expect(() => variants['focus'] = DacsStyle(), throwsUnsupportedError);
    });

    test('resolve applies matching non-state rules by source order', () {
      final sheet = DacsStyleSheet(
        DacsStyle()..backgroundColor = const Color(0xFFFFFFFF),
        [
          DacsConditionalRule(
            condition: DacsCondition.fromPrefix('md'),
            style: DacsStyle()..backgroundColor = const Color(0xFF111111),
            sourceOrder: 2,
          ),
          DacsConditionalRule(
            condition: DacsCondition.fromPrefix('dark'),
            style: DacsStyle()..backgroundColor = const Color(0xFF222222),
            sourceOrder: 1,
          ),
        ],
      );

      final resolved =
          sheet.resolve(brightness: Brightness.dark, screenWidth: 900);

      expect(resolved.backgroundColor, const Color(0xFF111111));
    });

    test('resolve does not merge matching rules over an important base', () {
      final sheet = DacsStyleSheet(
        DacsStyle()
          ..backgroundColor = const Color(0xFFFFFFFF)
          ..isImportant = true,
        [
          DacsConditionalRule(
            condition: DacsCondition.fromPrefix('dark'),
            style: DacsStyle()..backgroundColor = const Color(0xFF111111),
            sourceOrder: 1,
          ),
        ],
      );

      final resolved = sheet.resolve(brightness: Brightness.dark);

      expect(resolved.backgroundColor, const Color(0xFFFFFFFF));
    });

    test('resolve merges multiple matched compound state rules', () {
      final sheet = DacsStyleSheet(
        DacsStyle(),
        [
          DacsConditionalRule(
            condition: DacsCondition.fromPrefixes(['dark', 'hover', 'focus']),
            style: DacsStyle()..backgroundColor = const Color(0xFF111111),
            sourceOrder: 1,
          ),
          DacsConditionalRule(
            condition: DacsCondition.fromPrefixes(['dark', 'hover', 'focus']),
            style: DacsStyle()..color = const Color(0xFF222222),
            sourceOrder: 2,
          ),
        ],
      );

      final resolved = sheet.resolve(brightness: Brightness.dark);

      expect(resolved.variants!['hover:focus']!.backgroundColor,
          const Color(0xFF111111));
      expect(resolved.variants!['hover:focus']!.color, const Color(0xFF222222));
    });

    test('resolve preserves last class wins across matching conditions', () {
      final resolved = 'dark:text-red-500 md:text-blue-500 dark:text-green-500'
          .dStyle
          .resolve(brightness: Brightness.dark, screenWidth: 900);

      expect(resolved.color, const Color(0xFF22C55E));
    });

    test('base exposes style conversion methods explicitly', () {
      final sheet = DacsStyleSheet(
        DacsStyle()
          ..fontSize = 16
          ..color = const Color(0xFF111111)
          ..padding = const EdgeInsets.all(4)
          ..margin = const EdgeInsets.all(5)
          ..borderWidth = 1
          ..borderColor = const Color(0xFF222222)
          ..borderRadius = BorderRadius.circular(6)
          ..width = 40
          ..height = 30
          ..alignment = Alignment.center
          ..gradientDirection = DacsGradientDirection.toR
          ..gradientFromColor = const Color(0xFF333333)
          ..gradientToColor = const Color(0xFF444444)
          ..translateX = 7,
      );

      final clone = sheet.base.clone();
      final copied =
          sheet.base.copyWith(DacsStyle()..fontWeight = FontWeight.w700);
      sheet.base.mergeFrom(DacsStyle()..lineHeight = 1.4);

      expect(clone.fontSize, 16);
      expect(copied.fontWeight, FontWeight.w700);
      expect(sheet.base.lineHeight, 1.4);
      expect(sheet.base.toMatrix4().storage, isNotEmpty);
      expect(sheet.base.toTextStyle().fontSize, 16);
      expect(sheet.base.toPadding(), const EdgeInsets.all(4));
      expect(sheet.base.toMargin(), const EdgeInsets.all(5));
      expect(sheet.base.toGradient(), isA<LinearGradient>());
      expect(sheet.base.toBoxDecoration(), isA<BoxDecoration>());
      expect(sheet.base.toBorder(), isA<BoxBorder>());
      expect(sheet.base.toBorderSide(), isA<BorderSide>());
      expect(sheet.base.toRadius(), BorderRadius.circular(6));
      expect(sheet.base.toConstraints(), isA<BoxConstraints>());
      expect(sheet.base.toAlignment(), Alignment.center);
      expect(sheet.base.toShapeBorder(), isA<ShapeBorder>());
      expect(sheet.base.toFixedSize(), const Size(40, 30));
      expect(sheet.base.toLayoutStyle().alignment, Alignment.center);
    });

    test('splitVariantKey preserves condition order', () {
      expect(splitVariantKey('dark:md:hover'), ['dark', 'md', 'hover']);
    });
  });

  group('DacsCondition', () {
    test('maps brightness, breakpoint, and widget state prefixes', () {
      final dark = DacsCondition.fromPrefix('dark');
      final md = DacsCondition.fromPrefix('md');
      final hover = DacsCondition.fromPrefix('hover');

      expect(dark.isBrightnessCondition, isTrue);
      expect(dark.matches(brightness: Brightness.dark), isTrue);
      expect(dark.matches(brightness: Brightness.light), isFalse);
      expect(md.isResponsive, isTrue);
      expect(md.matches(screenWidth: 768), isTrue);
      expect(md.matches(screenWidth: 767), isFalse);
      expect(hover.isWidgetState, isTrue);
      expect(hover.requiredStates, {WidgetState.hovered});
    });

    test('compound conditions keep max breakpoint and all widget states', () {
      final condition = DacsCondition.fromPrefixes(
        ['sm', 'lg', 'dark', 'hover', 'focus'],
      );

      expect(condition.name, 'sm:lg:dark:hover:focus');
      expect(condition.minWidth, 1024);
      expect(condition.brightness, Brightness.dark);
      expect(
          condition.requiredStates, {WidgetState.hovered, WidgetState.focused});
      expect(condition.atomicConditions.map((c) => c.name),
          ['sm', 'lg', 'dark', 'hover', 'focus']);
    });

    test('environment requires width when breakpoint is present', () {
      final condition = DacsCondition.fromPrefix('md');

      expect(condition.matchesEnvironment(), isFalse);
      expect(condition.matchesEnvironment(screenWidth: 900), isTrue);
    });

    test('equality and hash code are based on condition name', () {
      final a = DacsCondition.fromPrefixes(['dark', 'hover']);
      final b = DacsCondition.fromPrefixes(['dark', 'hover']);
      final c = DacsCondition.fromPrefixes(['hover', 'dark']);

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a == c, isFalse);
    });
  });

  group('DacsConditionalRule', () {
    test('exposes condition groups and important metadata', () {
      final rule = DacsConditionalRule(
        condition: DacsCondition.fromPrefixes(['dark', 'hover']),
        style: DacsStyle()..color = const Color(0xFF111111),
        sourceOrder: 7,
        importantFields: {'color'},
      );

      expect(rule.conditions.map((c) => c.name), ['dark', 'hover']);
      expect(rule.nonWidgetStateConditions.map((c) => c.name), ['dark']);
      expect(rule.widgetStateConditions.map((c) => c.name), ['hover']);
      expect(rule.allWidgetState, isFalse);
      expect(rule.isImportant, isTrue);
      expect(rule.matches(brightness: Brightness.dark), isTrue);
      expect(rule.toString(), 'DacsConditionalRule(dark:hover)');
    });

    test('detects rules made only of widget state conditions', () {
      final rule = DacsConditionalRule(
        condition: DacsCondition.fromPrefixes(['hover', 'focus']),
        style: DacsStyle(),
        sourceOrder: 1,
      );

      expect(rule.allWidgetState, isTrue);
      expect(rule.nonWidgetStateConditions, isEmpty);
      expect(rule.isImportant, isFalse);
    });
  });

  group('DacsResolveContext', () {
    test('withStates preserves environment and replaces states', () {
      const context = DacsResolveContext(
        brightness: Brightness.dark,
        screenWidth: 1200,
        states: {WidgetState.hovered},
      );

      final next = context.withStates({WidgetState.pressed});

      expect(next.brightness, Brightness.dark);
      expect(next.screenWidth, 1200);
      expect(next.states, {WidgetState.pressed});
    });
  });

  group('DacsLayoutStyle', () {
    test('fixedSize uses zero for unspecified dimensions', () {
      const widthOnly = DacsLayoutStyle(width: 64);
      const heightOnly = DacsLayoutStyle(height: 32);

      expect(widthOnly.fixedSize, const Size(64, 0));
      expect(heightOnly.fixedSize, const Size(0, 32));
    });

    test('hasLayout reflects any layout-related value', () {
      expect(const DacsLayoutStyle().hasLayout, isFalse);
      expect(const DacsLayoutStyle(aspectRatio: 16 / 9).hasLayout, isTrue);
      expect(const DacsLayoutStyle(boxFit: BoxFit.cover).hasLayout, isTrue);
      expect(const DacsLayoutStyle(overflow: Clip.hardEdge).hasLayout, isTrue);
      expect(
          const DacsLayoutStyle(alignment: Alignment.center).hasLayout, isTrue);
    });
  });
}
