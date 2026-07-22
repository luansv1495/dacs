# Public API

`package:dacs/dacs.dart` is the only supported public entry point.

Files under `lib/src/` may move over time. Import them directly only when
working on DACS itself.

## Main API

These exports are the recommended surface for application code:

| Export | Purpose |
|---|---|
| `src/extensions/string_ext.dart` | String extensions such as `.dText`, `.dBox`, `.dButton(context)`, and `.dInputOf(context)`. |
| `src/extensions/material_ext.dart` | Material component adapters exposed as string extensions. |
| `src/dacs_style.dart` | Mutable style value object used for base parsed styles and advanced composition. |
| `src/dacs_style_sheet.dart` | Context-free compiled stylesheet containing base style plus conditional rules. |
| `src/dacs_resolved_style.dart` | Read-only resolved style returned after applying context and conditions. |
| `src/dacs_layout_style.dart` | Layout values that do not map to one Flutter style object. |

## Advanced API

These exports are public for users building tooling, diagnostics, or custom
adapters:

| Export | Purpose |
|---|---|
| `src/dacs_compiler.dart` | Compiles class strings into `DacsStyleSheet` and manages the parser cache. |
| `src/dacs_config.dart` | Configures strict mode, cache size, and unknown utility diagnostics. |
| `src/dacs_condition.dart` | Typed representation of brightness, breakpoint, and widget-state conditions. |
| `src/dacs_conditional_rule.dart` | Conditional style rule stored by `DacsStyleSheet.rules`. |
| `src/dacs_resolve_context.dart` | Explicit context object used by low-level resolution APIs. |

## Internal API

These areas are intentionally not exported from `package:dacs/dacs.dart`:

| Area | Reason |
|---|---|
| `src/adapters/*` | Implementation detail behind the string extension methods. |
| `src/parsers/*` | Parser internals can change without a migration path. |
| `src/tokens/*` | Token tables document supported utilities but are not a stable runtime API. |

Token values such as colors, typography scales, shadows, and breakpoints are
documented as supported utility behavior. They should not be imported as API
contracts unless a future release promotes a dedicated token API.

## Compatibility

There are no temporary compatibility exports in `0.5.0`.

Because the package is still pre-`1.0.0`, advanced APIs may evolve in minor
releases when the change improves the style engine. Main extension APIs should
remain the most stable way to use DACS.
