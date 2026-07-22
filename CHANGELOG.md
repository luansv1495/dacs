## 0.5.0

- **Material 3 theme expansion**: added adapters and string extensions for `IconButtonThemeData`, `SegmentedButtonThemeData`, `BadgeThemeData`, `DrawerThemeData`, `BottomAppBarThemeData`, `NavigationRailThemeData`, `PopupMenuThemeData`, `DropdownMenuThemeData`, `DatePickerThemeData`, and `TimePickerThemeData`.
- **New Material extension methods**: added `.dIconButton(context)`, `.dSegmentedButton(context)`, `.dBadge(context)`, `.dDrawer(context)`, `.dBottomAppBar(context)`, `.dNavRail(context)`, `.dPopupMenu(context)`, `.dDropdownMenu(context)`, `.dDatePicker(context)`, and `.dTimePicker(context)`.
- **Picker semantic color channels**: added explicit Date/Time picker utilities such as `date-header-bg-*`, `date-day-bg-*`, `date-range-selection-overlay-*`, `time-dial-bg-*`, `time-dial-hand-*`, and `time-hour-minute-bg-*`.
- **State fidelity**: Material adapters continue to use only colors and states explicitly declared by the class string; no hover/focus/pressed alpha or disabled colors are derived by DACS.
- **Component color channels**: added semantic component color support inside `DacsStyle` / `DacsResolvedStyle` for advanced adapters without adding one field per picker property.
- **Widget support docs**: expanded `doc/widget-support.md` with support tables for the new Material 3 adapters and picker-specific channels.
- **Tests**: added focused coverage for Phase 6A, Phase 6B, and Phase 7 adapters.

## 0.4.0

- **Parser/resolver separation**: class strings now parse into `DacsStyleSheet`, with base styles separated from conditional rules before context/state resolution.
- **Compiler configuration**: added `Dacs.configure(...)` and `DacsCompiler.compile(...)` with context-free compilation, configurable cache size, unknown utility diagnostics, and optional strict mode.
- **Last class wins**: conditional rules now preserve source order so later classes win consistently, including overlapping `dark:`, breakpoint, and compound variants.
- **Compound variants**: chained variants such as `dark:md:hover:bg-red-500`, `focus:error:border-red-500`, and `light:disabled:text-gray-400` resolve through structured conditions.
- **Adapter split**: Material conversion logic moved into focused internal adapters for buttons, inputs, checkbox/radio, switch, chip, menu, navigation bar, data table, scrollbar, search bar, slider, layout, text, box, border, gradient, constraints, and transforms.
- **Public API cleanup**: concrete adapters and internal resolver types are no longer exported from `package:dacs/dacs.dart`; public exports focus on `DacsStyle`, `DacsStyleSheet`, `DacsLayoutStyle`, extensions, and tokens.
- **Public docs lint**: enabled `public_member_api_docs` and documented the exported API surface.
- **ButtonStyle expansion**: `surfaceTintColor`, `iconColor`, `iconSize`, `minimumSize`, `fixedSize`, `maximumSize`, `mouseCursor`, and dynamic `shape` now support WidgetState-aware resolution.
- **InputDecoration phase**: `.dInput(context)` / `.dInputOf(context)` now map base, focused, disabled, error, and focused-error borders to native `InputDecoration` border slots.
- **Input text helpers**: added `label-[...]`, `hint-[...]`, `helper-[...]`, `error-[...]`, `prefix-[...]`, and `suffix-[...]` tokens for `InputDecoration`.
- **Input flags**: added `filled`, `not-filled`, `dense`, and `not-dense`.
- **Tokenizer improvement**: arbitrary bracket values may contain spaces, enabling tokens like `helper-[Use your work email]`.
- **Layout/style helpers**: added `.dFixedSize`, `.dLayout`, `.dBorder`, `.dBorderSide`, `.dRadius`, `.dConstraints`, `.dAlignment`, `.dShapeBorder`, plus context-aware `*Of(context)` variants.
- **Layout utilities**: expanded reusable parsing for `min-w-*`, `max-w-*`, `min-h-*`, `max-h-*`, `aspect-*`, `overflow-*`, `object-cover`, and `object-contain`.
- **Material coverage**: added/expanded adapters and tests for `RadioThemeData`, `MenuStyle`, `SearchBarThemeData`, `NavigationBarThemeData`, `DataTableThemeData`, `ScrollbarThemeData`, and `SliderThemeData`.
- **Documentation**: added `doc/widget-support.md` with per-widget property support tables and updated README examples for TextField styling versus decoration.
- **Project governance and CI**: added GitHub Actions for format/analyze/tests/docs/pana, contributing guidelines, code of conduct, issue/PR templates, versioning policy, and category docs under `doc/`.

## 0.3.0

- **Theme colors**: use `ColorScheme` keys directly: `text-primary`, `bg-surface`, `border-error`, `from-tertiary`, etc.
- **Arbitrary values**: `text-[#ff0000]`, `bg-[rgb(255,0,0)]`, `p-[20]`, `w-[50%]`, `rounded-[12]`.
- **Material widget extensions**: 26 widgets: `.dButton(context)`, `.dCheckbox(context)`, `.dCard(context)`, `.dAppBar(context)`, etc.
- **WidgetState variants**: `hover:`, `focus:`, `active:`, `disabled:`, `selected:`, `error:`, `pressed:`, `dragged:`, `scrolledUnder:`.
- **Chained compound variants**: combine any prefixes: `dark:hover:`, `dark:md:focus:`, `light:lg:disabled:`.
- **Split padding/margin**: `.dPads` returns padding, `.dMargin` returns margin (breaking change from 0.2.0).
- **`ClassParser` singleton + LRU cache**: single instance with auto-eviction at 500 entries.
- Internal: `_addCompoundVariant` correctly resolves theme colors over base.
- Removed public `ClassParser` export and `clearCache()`; cache is self-managed.

## 0.2.0

- **Variants**: dark/light mode (`dark:`, `light:`) and responsive breakpoints (`sm:`, `md:`, `lg:`, `xl:`, `2xl:`).
- **Context-aware extensions**: `.dTextOf(context)`, `.dBoxOf(context)`, `.dPadsOf(context)`, etc. resolve variants from `MediaQuery`.
- **`DacsStyle.resolve()` / `resolveFor()`**: merge variants into a single style based on brightness and screen width.
- **`DacsStyle.clone()` / `mergeFrom()`**: utility methods for style composition.
- **Position**: `inset-*`, `top-*`, `right-*`, `bottom-*`, `left-*` via `.dPosition`.
- **Transform**: `scale-*`, `rotate-*`, `translate-*`, `skew-*` via `.dTransform`.
- **Gradient**: `bg-gradient-to-*`, `from-*`, `via-*`, `to-*` via `.dGradient`.
- **Decoration style/thickness/color**: `decoration-solid`, `decoration-2`, `decoration-red-500`, etc.
- **`ClassParser` cache**: static cache avoids redundant parsing.
- Renamed extension getters: `.dacsText` to `.dText`, `.dacsPad` to `.dPads`, `.dacsBox` to `.dBox`, `.dacsStyle` to `.dStyle`, `.dacsMargin` to `.dPads`.

## 0.1.0

- Initial release.
- Tailwind-inspired utility classes: text, font, text/bg/border color classes.
- Spacing: `p-*`, `m-*` with directional variants (`px`, `py`, `pt`, `pr`, `pb`, `pl`).
- Border radius: `rounded-*` with directional variants (`t`, `b`, `l`, `r`, `tl`, `tr`, `bl`, `br`).
- Sizing: `w-*`, `h-*`, `opacity-*`.
- Shadows: `shadow-sm` to `shadow-2xl`, `shadow-inner`, `shadow-none`.
- Typography: `italic`, `underline`, `line-through`, `tracking-*`, `leading-*`, `decoration-*`.
- String extensions: `.dText`, `.dPads`, `.dBox`, `.dStyle`, `.dShadow`, `.dSize`.
- Full Tailwind v3 color palette (22 colors x 11 shades).
