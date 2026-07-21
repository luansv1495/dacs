import 'package:flutter/painting.dart';
import '../dacs_style.dart';
import '../tokens/colors.dart';
import 'parser.dart';

const _themeColors = {
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
};

/// Parses color tokens: text color (`text-{color}-{shade}`), background color
/// (`bg-{color}-{shade}`), border color (`border-{color}-{shade}`), decoration
/// color (`decoration-{color}-{shade}`), and theme color keys
/// (`text-primary`, `bg-surface`, `border-error`, etc.).
class ColorParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    if (_tryText(token, style)) return true;
    if (_tryBg(token, style)) return true;
    if (_tryBorder(token, style)) return true;
    if (_tryDecoration(token, style)) return true;
    if (_tryFrom(token, style)) return true;
    if (_tryVia(token, style)) return true;
    if (_tryTo(token, style)) return true;
    return false;
  }

  bool _tryPrefix(
    String prefix,
    String token,
    DacsStyle style,
    void Function(String) setTheme,
    void Function(Color) setColor,
  ) {
    final expected = '$prefix-';
    if (!token.startsWith(expected)) return false;
    final value = token.substring(expected.length);
    if (_themeColors.contains(value)) {
      setTheme(value);
      return true;
    }
    final color = parseDacsColor(value);
    if (color != null) {
      setColor(color);
      return true;
    }
    return false;
  }

  bool _tryText(String token, DacsStyle style) => _tryPrefix(
    'text',
    token,
    style,
    (v) {
      style.textThemeColor = v;
    },
    (c) {
      style.color = c;
    },
  );

  bool _tryBg(String token, DacsStyle style) => _tryPrefix(
    'bg',
    token,
    style,
    (v) {
      style.bgThemeColor = v;
    },
    (c) {
      style.backgroundColor = c;
    },
  );

  bool _tryBorder(String token, DacsStyle style) => _tryPrefix(
    'border',
    token,
    style,
    (v) {
      style.borderThemeColor = v;
    },
    (c) {
      style.borderColor = c;
    },
  );

  bool _tryDecoration(String token, DacsStyle style) => _tryPrefix(
    'decoration',
    token,
    style,
    (v) {
      style.decorationThemeColor = v;
    },
    (c) {
      style.textDecorationColor = c;
    },
  );

  bool _tryFrom(String token, DacsStyle style) => _tryPrefix(
    'from',
    token,
    style,
    (v) {
      style.gradientFromThemeColor = v;
    },
    (c) {
      style.gradientFromColor = c;
    },
  );

  bool _tryVia(String token, DacsStyle style) => _tryPrefix(
    'via',
    token,
    style,
    (v) {
      style.gradientViaThemeColor = v;
    },
    (c) {
      style.gradientViaColor = c;
    },
  );

  bool _tryTo(String token, DacsStyle style) => _tryPrefix(
    'to',
    token,
    style,
    (v) {
      style.gradientToThemeColor = v;
    },
    (c) {
      style.gradientToColor = c;
    },
  );
}
