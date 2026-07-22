import 'package:dacs/dacs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('phase 7 picker theme adapters', () {
    testWidgets('dDatePicker resolves DatePickerThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-surface text-onSurface indicator-secondary border-outline rounded-lg shadow-md '
                'date-header-bg-primary date-header-text-onPrimary '
                'date-day-text-onSurface selected:date-day-bg-primary hover:date-day-overlay-secondary '
                'date-today-text-secondary date-today-bg-surface '
                'date-year-text-onSurface selected:date-year-bg-secondary '
                'date-range-bg-surface date-range-header-bg-primary date-range-header-text-onPrimary '
                'date-range-selection-bg-secondary date-range-selection-overlay-primary date-divider-outline'
            .dDatePicker(ctx),
      );

      expect(data.backgroundColor, const Color(0xFFFFFBFE));
      expect(data.elevation, isNotNull);
      expect(data.shadowColor, isNotNull);
      expect(data.surfaceTintColor, const Color(0xFF03DAC6));
      expect(data.shape, isA<RoundedRectangleBorder>());
      expect(data.headerBackgroundColor, const Color(0xFF6200EE));
      expect(data.headerForegroundColor, const Color(0xFFFFFFFF));
      expect(data.dayForegroundColor!.resolve({}), const Color(0xFF1C1B1F));
      expect(
        data.dayBackgroundColor!.resolve({WidgetState.selected}),
        const Color(0xFF6200EE),
      );
      expect(
        data.dayOverlayColor!.resolve({WidgetState.hovered}),
        const Color(0xFF03DAC6),
      );
      expect(
        data.todayForegroundColor!.resolve({}),
        const Color(0xFF03DAC6),
      );
      expect(data.todayBorder, isNotNull);
      expect(
        data.yearBackgroundColor!.resolve({WidgetState.selected}),
        const Color(0xFF03DAC6),
      );
      expect(data.rangePickerBackgroundColor, const Color(0xFFFFFBFE));
      expect(data.rangePickerHeaderBackgroundColor, const Color(0xFF6200EE));
      expect(data.rangePickerHeaderForegroundColor, const Color(0xFFFFFFFF));
      expect(data.rangeSelectionBackgroundColor, const Color(0xFF03DAC6));
      expect(
        data.rangeSelectionOverlayColor!.resolve({}),
        const Color(0xFF6200EE),
      );
      expect(data.dividerColor, const Color(0xFF79747E));
      expect(data.cancelButtonStyle, isNotNull);
      expect(data.confirmButtonStyle, isNotNull);
    });

    testWidgets('dTimePicker resolves TimePickerThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-surface text-onSurface border-outline rounded-lg shadow-md p-4 '
                'time-day-period-border-outline time-day-period-bg-surfaceVariant '
                'selected:time-day-period-bg-primary time-day-period-text-onSurface '
                'selected:time-day-period-text-onPrimary time-dial-bg-surfaceVariant '
                'time-dial-hand-primary time-dial-text-onSurface '
                'selected:time-dial-text-onPrimary time-entry-icon-secondary '
                'time-hour-minute-bg-surfaceVariant selected:time-hour-minute-bg-secondary '
                'time-hour-minute-text-onSurface selected:time-hour-minute-text-onSecondary '
                'time-separator-outline'
            .dTimePicker(ctx),
      );

      expect(data.backgroundColor, const Color(0xFFFFFBFE));
      expect(data.cancelButtonStyle, isNotNull);
      expect(data.confirmButtonStyle, isNotNull);
      expect(data.dayPeriodBorderSide?.color, const Color(0xFF79747E));
      expect(
        WidgetStateProperty.resolveAs<Color?>(
          data.dayPeriodColor,
          {WidgetState.selected},
        ),
        const Color(0xFF6200EE),
      );
      expect(data.dayPeriodShape, isA<RoundedRectangleBorder>());
      expect(
        WidgetStateProperty.resolveAs<Color?>(
          data.dayPeriodTextColor,
          {WidgetState.selected},
        ),
        const Color(0xFFFFFFFF),
      );
      expect(data.dialBackgroundColor, const Color(0xFFE6E1E5));
      expect(data.dialHandColor, const Color(0xFF6200EE));
      expect(
        WidgetStateProperty.resolveAs<Color?>(
          data.dialTextColor,
          {WidgetState.selected},
        ),
        const Color(0xFFFFFFFF),
      );
      expect(data.elevation, isNotNull);
      expect(data.entryModeIconColor, const Color(0xFF03DAC6));
      expect(
        WidgetStateProperty.resolveAs<Color?>(
          data.hourMinuteColor,
          {WidgetState.selected},
        ),
        const Color(0xFF03DAC6),
      );
      expect(data.hourMinuteShape, isA<RoundedRectangleBorder>());
      expect(
        WidgetStateProperty.resolveAs<Color?>(
          data.hourMinuteTextColor,
          {WidgetState.selected},
        ),
        const Color(0xFF000000),
      );
      expect(data.padding, isNotNull);
      expect(data.shape, isA<RoundedRectangleBorder>());
      expect(
        data.timeSelectorSeparatorColor!.resolve({}),
        const Color(0xFF79747E),
      );
    });
  });
}
