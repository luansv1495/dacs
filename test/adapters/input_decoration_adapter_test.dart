import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('input decoration adapter', () {
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
  });
}
