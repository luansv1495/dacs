# DACS

[![pub.dev](https://img.shields.io/pub/v/dacs)](https://pub.dev/packages/dacs)
[![license](https://img.shields.io/github/license/luansv1495/dacs)](https://github.com/luansv1495/dacs/blob/main/LICENSE)

**DACS** brings Tailwind-inspired utility classes to Flutter. Write concise string expressions to define text styles, padding, colors, borders, shadows, transforms, gradients, and more.

```dart
Text('Hello, World!', style: 'text-2xl font-medium text-sky-500'.dText)
```

## Features

- **Zero-config** — just install and use
- **Tailwind v3 color palette** — 22 colors × 11 shades
- **Spacing scale** — 0 to 384px in Tailwind increments
- **Text utilities** — size, weight, color, letter spacing, line height, decoration
- **Background & border** — colors, border width, border radius with directional variants
- **Sizing, shadows & opacity** — width, height, box shadows, opacity
- **Position** — inset-*, top-*, right-*, bottom-*, left-*
- **Transform** — scale, rotate, translate, skew
- **Gradient** — linear gradients from Tailwind color tokens
- **Theme colors from `ColorScheme`** — `text-primary`, `bg-surface`, `border-error`
- **Arbitrary values** — `text-[#ff0000]`, `p-[20]`, `w-[50%]`, `rounded-[12]`
- **Material widget extensions** — style any Material widget: `.dButton(context)`, `.dCheckbox(context)`, `.dCard(context)`, etc.
- **WidgetState variants** — `hover:`, `focus:`, `disabled:`, `pressed:`, `selected:`, `error:`, `dragged:`, `scrolledUnder:`
- **Chained compound variants** — combine any prefixes: `dark:hover:`, `dark:md:focus:`, `light:lg:disabled:`
- **Dark/Light mode & responsive variants** — `dark:`, `light:`, `sm:`, `md:`, `lg:`, `xl:`, `2xl:`
- **Material 3 theme coverage** — includes buttons, inputs, menus, navigation, drawers, badges, sliders, date pickers, and time pickers

## Documentation

- [Getting started](https://github.com/luansv1495/dacs/blob/main/doc/getting-started.md)
- [Core concepts](https://github.com/luansv1495/dacs/blob/main/doc/core-concepts.md)
- [Utilities](https://github.com/luansv1495/dacs/blob/main/doc/utilities.md)
- [Material widgets](https://github.com/luansv1495/dacs/blob/main/doc/material-widgets.md)
- [Inputs](https://github.com/luansv1495/dacs/blob/main/doc/inputs.md)
- [Public API](https://github.com/luansv1495/dacs/blob/main/doc/public-api.md)
- [Widget support matrix](https://github.com/luansv1495/dacs/blob/main/doc/widget-support.md)
- [Versioning policy](https://github.com/luansv1495/dacs/blob/main/doc/versioning.md)
- [Contributing guide](https://github.com/luansv1495/dacs/blob/main/CONTRIBUTING.md)

## Installation

```yaml
dependencies:
  dacs: ^0.5.0
```

## Usage

### Configuration and compilation

DACS works without configuration, but you can enable diagnostics for unknown
utilities and tune the parser cache:

```dart
Dacs.configure(
  strictMode: false,
  cacheSize: 500,
  onUnknownUtility: (utility) {
    debugPrint('Unknown DACS utility: $utility');
  },
);

final sheet = DacsCompiler.compile('text-sm dark:md:hover:bg-red-500');
```

Compilation is context-free: `DacsCompiler.compile` only parses the string into
a `DacsStyleSheet`. Runtime values such as `BuildContext`, theme colors,
brightness, breakpoints, and widget states are applied later by methods such as
`.dTextOf(context)`, `.dBoxOf(context)`, and `.dButton(context)`.

### Text styles

```dart
Text('Heading', style: 'text-3xl font-bold text-gray-900'.dText)
Text('Body', style: 'text-base leading-relaxed text-gray-600'.dText)
```

### Padding & Margin

```dart
Container(
  padding: 'px-4 py-2'.dPads,
  margin: 'mt-4'.dPads,
  child: Text('Content', style: 'text-base'.dText),
)
```

### Box decoration

```dart
Container(
  decoration: 'bg-blue-500 rounded-lg shadow-md'.dBox,
  child: Text('Button', style: 'text-white font-medium'.dText),
)
```

### Gradients

```dart
Container(
  decoration: 'bg-gradient-to-r from-sky-400 to-blue-600'.dBox,
  child: Text('Gradient', style: 'text-white text-xl'.dText),
)
```

### Shadows

```dart
Container(decoration: 'bg-white rounded-xl shadow-lg'.dBox)
// Or just the shadow list:
final shadows = 'shadow-lg'.dShadow;
```

### Sizing

```dart
final (width, height) = 'w-64 h-48'.dSize;
```

### Position (for Stack)

```dart
final (top, right, bottom, left) = 'inset-0'.dPosition;
```

### Transform

```dart
Transform(
  transform: 'scale-125 rotate-45'.dTransform,
  child: Text('Styled'),
)
```

### Dark / Light mode variants

```dart
// Resolves automatically from MediaQuery:
Text(
  'Responsive text',
  style: 'text-gray-900 dark:text-white'.dTextOf(context),
)

Container(
  decoration: 'bg-white dark:bg-gray-900'.dBoxOf(context),
  child: Text(
    'Content',
    style: 'text-base text-gray-600 dark:text-gray-300'.dTextOf(context),
  ),
)
```

### Responsive variants

```dart
// Applies breakpoints based on screen width from MediaQuery:
Text(
  'Responsive heading',
  style: 'text-base sm:text-lg md:text-xl lg:text-2xl'.dTextOf(context),
)

Container(
  padding: 'p-4 md:p-8 lg:p-12'.dPadsOf(context),
  decoration: 'bg-white dark:bg-gray-900 rounded-lg'.dBoxOf(context),
  child: Text(
    'Content',
    style: 'text-sm md:text-base'.dTextOf(context),
  ),
)
```

### Theme colors

Use any `ColorScheme` key as a color — no need to import or reference the theme directly:

```dart
Text('Primary', style: 'text-primary font-bold'.dTextOf(context))
Container(decoration: 'bg-surface rounded-lg border-outline'.dBoxOf(context))
CheckboxTheme(
  data: 'checked:bg-primary unchecked:bg-surface'.dCheckbox(context),
  child: Checkbox(value: true, onChanged: (_) {}),
)
```

Supported keys: `primary`, `onPrimary`, `primaryContainer`, `onPrimaryContainer`, `secondary`, `onSecondary`, `secondaryContainer`, `onSecondaryContainer`, `tertiary`, `onTertiary`, `tertiaryContainer`, `onTertiaryContainer`, `error`, `onError`, `errorContainer`, `onErrorContainer`, `surface`, `onSurface`, `surfaceVariant`, `onSurfaceVariant`, `outline`, `outlineVariant`, `inverseSurface`, `onInverseSurface`, `inversePrimary`, `shadow`, `scrim`

### Arbitrary values

Use square brackets for one-off values:

```dart
'text-[#ff0000]'         // exact color
'bg-[rgb(255,0,0)]'      // rgb syntax
'p-[20]'                  // 20px padding
'w-[50%]'                 // 50% width
'rounded-[12]'            // 12px border radius
'opacity-[0.75]'          // 75% opacity
'scale-[200]'             // 2x scale
```

### Material widget extensions

Style Material widgets via context-aware methods. WidgetState variant support
(`hover:`, `focus:`, `disabled:`, etc.) varies by adapter — see the table below.

```dart
ElevatedButton(
  style: 'bg-primary text-white rounded-lg'.dButton(context),
  onPressed: () {},
  child: const Text('Submit'),
)

CheckboxTheme(
  data: 'bg-primary hover:bg-primaryContainer'.dCheckbox(context),
  child: Checkbox(value: true, onChanged: (_) {}),
)

CardTheme(
  data: 'bg-surface rounded-xl shadow-md'.dCard(context),
  child: Card(child: Text('Content', style: 'text-base'.dText)),
)
```

All 37 Material adapters are supported: `dButton`, `dIconButton`, `dSegmentedButton`, `dCheckbox`, `dSwitch`, `dRadio`, `dChip`, `dBadge`, `dAppBar`, `dCard`, `dListTile`, `dTabBar`, `dBottomNav`, `dNavBar`, `dNavRail`, `dDrawer`, `dBottomAppBar`, `dInput`, `dProgress`, `dTooltip`, `dDivider`, `dScrollbar`, `dSnackBar`, `dDialog`, `dBottomSheet`, `dExpansionTile`, `dFab`, `dDataTable`, `dSearchBar`, `dMenu`, `dPopupMenu`, `dDropdownMenu`, `dSlider`, `dDatePicker`, `dTimePicker`, `dIcon`, `dShape`.

For the detailed per-widget property matrix, see the
[widget support matrix](https://github.com/luansv1495/dacs/blob/main/doc/widget-support.md).

### TextField inputs

`TextField.style` and `TextField.decoration` are different Flutter APIs.
Use `.dTextOf(context)` for the typed text and `.dInputOf(context)` for the
input chrome: label, hint, helper, error, prefix/suffix, fill, density, padding,
and borders.

```dart
const classes = 'text-onSurface label-[Email] hint-[you@example.com] '
    'helper-[Use your work email] filled dense bg-surface '
    'border-outline focus:border-primary error:border-error '
    'focus:error:border-primaryContainer rounded-lg p-4';

TextField(
  style: classes.dTextOf(context),
  decoration: classes.dInputOf(context),
)
```

### Date and time picker themes

Picker adapters use explicit semantic color channels, so DACS does not guess
hover, selected, disabled, or overlay colors for you. Declare every visual state
you want to control:

```dart
Theme(
  data: Theme.of(context).copyWith(
    datePickerTheme:
        'bg-surface text-onSurface rounded-lg shadow-md '
        'date-header-bg-primary date-header-text-onPrimary '
        'date-day-text-onSurface selected:date-day-bg-primary '
        'hover:date-day-overlay-secondary date-today-text-secondary'
            .dDatePicker(context),
    timePickerTheme:
        'bg-surface text-onSurface rounded-lg shadow-md '
        'time-dial-bg-surfaceVariant time-dial-hand-primary '
        'time-hour-minute-bg-surfaceVariant '
        'selected:time-hour-minute-bg-secondary '
        'time-hour-minute-text-onSurface '
        'selected:time-hour-minute-text-onSecondary'
            .dTimePicker(context),
  ),
  child: const SizedBox.shrink(),
)
```

### WidgetState variants

For Material widgets, use interactive state variants:

```dart
ElevatedButton(
  style: 'bg-primary hover:bg-primaryContainer disabled:bg-surface 
          rounded-lg hover:rounded-xl'.dButton(context),
  onPressed: () {},
  child: const Text('Submit'),
)
```

State order: base → disabled → pressed → hover → focus → selected → error → dragged → scrolledUnder.
Shape variants (`hover:rounded-xl`, `pressed:rounded-sm`) resolve dynamically via `_stateProp`.

### Chained compound variants

Combine any variant prefixes with `:`:

```dart
// Applies only in dark mode AND when hovered
Text(
  'Styled text',
  style: 'text-white dark:hover:text-primary'.dTextOf(context),
)

// Triple compound: dark mode, medium breakpoint, hover
Container(
  decoration: 'bg-primary dark:md:hover:bg-error'.dBoxOf(context),
)
```

### Parsed style access

```dart
final sheet = 'text-lg font-bold text-red-600 dark:text-white'.dStyle;
final base = sheet.base;

print(base.fontSize);   // 18
print(base.fontWeight); // FontWeight.w700
print(base.color);      // Color(0xFFDC2626)

final resolved = sheet.resolveFor(context); // DacsResolvedStyle
```

## Extension methods

### Simple getters (no context)

These parse classes and convert immediately. Useful when you don't need variant resolution.

| Getter | Returns |
|---|---|
| `.dText` | `TextStyle` |
| `.dPads` | `EdgeInsets` |
| `.dBox` | `BoxDecoration` |
| `.dStyle` | `DacsStyleSheet` |
| `.dBase` | `DacsStyle` |
| `.dShadow` | `List<BoxShadow>` |
| `.dSize` | `(double?, double?)` |
| `.dFixedSize` | `Size?` |
| `.dLayout` | `DacsLayoutStyle` |
| `.dPosition` | `(double?, double?, double?, double?)` |
| `.dTransform` | `Matrix4` |
| `.dGradient` | `LinearGradient?` |
| `.dBorder` | `BoxBorder?` |
| `.dBorderSide` | `BorderSide?` |
| `.dRadius` | `BorderRadiusGeometry?` |
| `.dConstraints` | `BoxConstraints?` |
| `.dAlignment` | `AlignmentGeometry?` |
| `.dShapeBorder` | `ShapeBorder?` |

### Context-aware methods (resolve variants)

These accept a `BuildContext` to resolve dark/light mode, responsive breakpoints, and theme colors from `MediaQuery` / `Theme`.

| Method | Returns |
|---|---|
| `.dTextOf(context)` | `TextStyle` |
| `.dPadsOf(context)` | `EdgeInsets` |
| `.dMarginOf(context)` | `EdgeInsets` |
| `.dBoxOf(context)` | `BoxDecoration` |
| `.dStyleOf(context)` | `DacsResolvedStyle` |
| `.dShadowOf(context)` | `List<BoxShadow>` |
| `.dSizeOf(context)` | `(double?, double?)` |
| `.dFixedSizeOf(context)` | `Size?` |
| `.dLayoutOf(context)` | `DacsLayoutStyle` |
| `.dPositionOf(context)` | `(double?, double?, double?, double?)` |
| `.dTransformOf(context)` | `Matrix4` |
| `.dGradientOf(context)` | `LinearGradient?` |
| `.dBorderOf(context)` | `BoxBorder?` |
| `.dBorderSideOf(context)` | `BorderSide?` |
| `.dRadiusOf(context)` | `BorderRadiusGeometry?` |
| `.dConstraintsOf(context)` | `BoxConstraints?` |
| `.dAlignmentOf(context)` | `AlignmentGeometry?` |
| `.dShapeBorderOf(context)` | `ShapeBorder?` |

### Material widget extensions

These accept a `BuildContext` and return Material theme data with variant resolution.
WidgetState support is marked per method.
For property-level support, see the
[widget support matrix](https://github.com/luansv1495/dacs/blob/main/doc/widget-support.md).

| Method | Returns | WidgetState |
|---|---|---|
| `.dButton(context)` | `ButtonStyle` | full |
| `.dIconButton(context)` | `IconButtonThemeData` | full through `ButtonStyle` |
| `.dSegmentedButton(context)` | `SegmentedButtonThemeData` | full through `ButtonStyle` |
| `.dCheckbox(context)` | `CheckboxThemeData` | partial |
| `.dSwitch(context)` | `SwitchThemeData` | partial |
| `.dRadio(context)` | `RadioThemeData` | partial |
| `.dChip(context)` | `ChipThemeData` | only color |
| `.dBadge(context)` | `BadgeThemeData` | — |
| `.dScrollbar(context)` | `ScrollbarThemeData` | partial |
| `.dNavBar(context)` | `NavigationBarThemeData` | only label |
| `.dNavRail(context)` | `NavigationRailThemeData` | — |
| `.dDrawer(context)` | `DrawerThemeData` | — |
| `.dBottomAppBar(context)` | `BottomAppBarThemeData` | — |
| `.dDataTable(context)` | `DataTableThemeData` | partial |
| `.dSearchBar(context)` | `SearchBarThemeData` | partial |
| `.dMenu(context)` | `MenuStyle` | partial |
| `.dPopupMenu(context)` | `PopupMenuThemeData` | partial |
| `.dDropdownMenu(context)` | `DropdownMenuThemeData` | partial |
| `.dSlider(context)` | `SliderThemeData` | partial |
| `.dDatePicker(context)` | `DatePickerThemeData` | partial |
| `.dTimePicker(context)` | `TimePickerThemeData` | partial |
| `.dAppBar(context)` | `AppBarTheme` | — |
| `.dCard(context)` | `CardTheme` | — |
| `.dListTile(context)` | `ListTileThemeData` | — |
| `.dTabBar(context)` | `TabBarTheme` | — |
| `.dBottomNav(context)` | `BottomNavigationBarThemeData` | — |
| `.dInput(context)` / `.dInputOf(context)` | `InputDecoration` | focus, disabled, error, focus:error border mappings |
| `.dProgress(context)` | `ProgressIndicatorThemeData` | — |
| `.dTooltip(context)` | `TooltipThemeData` | — |
| `.dDivider(context)` | `DividerThemeData` | — |
| `.dSnackBar(context)` | `SnackBarThemeData` | — |
| `.dDialog(context)` | `DialogTheme` | — |
| `.dBottomSheet(context)` | `BottomSheetThemeData` | — |
| `.dExpansionTile(context)` | `ExpansionTileThemeData` | — |
| `.dFab(context)` | `FloatingActionButtonThemeData` | — |
| `.dIcon(context)` | `IconThemeData` | — |
| `.dShape(context)` | `ShapeDecoration` | — |

## Supported classes

### Typography

| Class | Flutter property |
|---|---|
| `text-xs` … `text-9xl` | `fontSize` (12 … 128) |
| `font-thin` … `font-black` | `fontWeight` (100 … 900) |
| `leading-3` … `leading-10` | `height` (line height) |
| `leading-none` … `leading-loose` | `height` (relative) |
| `tracking-tighter` … `tracking-widest` | `letterSpacing` |
| `italic` / `not-italic` | `fontStyle` |
| `underline` / `line-through` / `no-underline` | `textDecoration` |
| `decoration-solid` / `double` / `dotted` / `dashed` / `wavy` | `textDecorationStyle` |
| `decoration-{1..}` | `textDecorationThickness` |
| `decoration-{color}-{shade}` | `textDecorationColor` |

### Colors (text, background, border, decoration)

Format: `{prefix}-{color}-{shade}`

```dart
'text-sky-500'         // text color
'bg-blue-200'          // background color
'border-red-600'       // border color
'decoration-green-500' // text decoration color
```

Supported colors: `slate`, `gray`, `zinc`, `neutral`, `stone`, `red`, `orange`, `amber`, `yellow`, `lime`, `green`, `emerald`, `teal`, `cyan`, `sky`, `blue`, `indigo`, `violet`, `purple`, `fuchsia`, `pink`, `rose`

Shades: `50`, `100`, `200`, `300`, `400`, `500`, `600`, `700`, `800`, `900`, `950`

Also: `text-black`, `text-white`, `text-transparent`

### Spacing

| Class | Output |
|---|---|
| `p-4` | `EdgeInsets.all(16)` |
| `px-4` | `EdgeInsets.symmetric(horizontal: 16)` |
| `py-2` | `EdgeInsets.symmetric(vertical: 8)` |
| `pt-4`, `pr-4`, `pb-4`, `pl-4` | Directional padding |
| `m-*`, `mx-*`, `my-*`, `mt-*`, `mr-*`, `mb-*`, `ml-*` | Same for margin |

Spacing keys: `0`, `px`, `0.5`, `1`, `1.5`, `2`, `2.5`, `3`, `3.5`, `4`, `5`, `6`, `7`, `8`, `9`, `10`, `11`, `12`, `14`, `16`, `20`, `24`, `28`, `32`, `36`, `40`, `44`, `48`, `52`, `56`, `60`, `64`, `72`, `80`, `96`

### Border

| Class | Output |
|---|---|
| `rounded-none` | `BorderRadius.circular(0)` |
| `rounded-sm` | `BorderRadius.circular(2)` |
| `rounded` | `BorderRadius.circular(4)` |
| `rounded-md` / `rounded-lg` / `rounded-xl` / `rounded-2xl` / `rounded-3xl` | 6 / 8 / 12 / 16 / 24 |
| `rounded-full` | `BorderRadius.circular(9999)` |
| `rounded-t-lg`, `rounded-b-sm`, `rounded-l-md`, `rounded-r-xl` | Directional |
| `rounded-tl-lg`, `rounded-tr-lg`, `rounded-bl-lg`, `rounded-br-lg` | Corner-specific |
| `border` | `Border.all(width: 1)` |
| `border-2` … `border-8` | `Border.all(width: size)` |

### Sizing & opacity

```dart
'w-64'       // width: 256
'h-32'       // height: 128
'w-full'     // width: double.infinity
'opacity-50' // opacity: 0.5
```

### Shadows

| Class | BoxShadows |
|---|---|
| `shadow-sm` | 1 shadow (subtle) |
| `shadow` | 2 shadows (default) |
| `shadow-md` / `shadow-lg` / `shadow-xl` / `shadow-2xl` | Increasing blur/spread |
| `shadow-inner` | Inset shadow |
| `shadow-none` | Empty list |

### Position

| Class | Properties |
|---|---|
| `inset-0` | top=0, right=0, bottom=0, left=0 |
| `inset-x-4` | left=16, right=16 |
| `inset-y-2` | top=8, bottom=8 |
| `top-4`, `right-4`, `bottom-4`, `left-4` | Individual inset |

### Transform

| Class | Property |
|---|---|
| `scale-125` | `scaleX=1.25, scaleY=1.25` |
| `scale-x-150` | `scaleX=1.5` |
| `scale-y-75` | `scaleY=0.75` |
| `rotate-45` | `rotateDegrees=45` |
| `translate-x-4` | `translateX=16` |
| `translate-y-2` | `translateY=8` |
| `skew-x-12` | `skewX=12` |
| `skew-y-6` | `skewY=6` |

### Gradient

```dart
'bg-gradient-to-r from-red-500 to-blue-600'
'bg-gradient-to-tl from-amber-400 via-orange-500 to-red-600'
```

Directions: `to-r`, `to-l`, `to-t`, `to-b`, `to-tr`, `to-tl`, `to-br`, `to-bl`

### Variants

Prefix any class with a variant to scope it:

| Variant | Trigger |
|---|---|
| `dark:` | Applies when `MediaQuery.platformBrightness == Brightness.dark` |
| `light:` | Applies when `MediaQuery.platformBrightness == Brightness.light` |
| `sm:` | Applies at `min-width: 640px` |
| `md:` | Applies at `min-width: 768px` |
| `lg:` | Applies at `min-width: 1024px` |
| `xl:` | Applies at `min-width: 1280px` |
| `2xl:` | Applies at `min-width: 1536px` |
| `hover:` | `WidgetState.hovered` |
| `focus:` | `WidgetState.focused` |
| `active:` / `pressed:` | `WidgetState.pressed` |
| `disabled:` | `WidgetState.disabled` |
| `selected:` | `WidgetState.selected` |
| `error:` | `WidgetState.error` |
| `dragged:` | `WidgetState.dragged` |
| `scrolledUnder:` | `WidgetState.scrolledUnder` |

Resolution order (Material contexts): base → disabled → pressed → hover → focus → selected → error → dragged → scrolledUnder.

**Chained compound variants**: combine multiple prefix types with `:`.

```dart
'dark:hover:text-white'      // dark mode + hover
'light:md:bg-primary'        // light mode + md breakpoint
'dark:lg:focus:border-error' // dark + lg + focus
```

Compound variants match only when ALL conditions are met. WidgetState conditions re-map to simple keys for Material widget resolution.

## Additional information

- [Report issues](https://github.com/luansv1495/dacs/issues)
- [View source](https://github.com/luansv1495/dacs)
- Licensed under the [MIT License](https://github.com/luansv1495/dacs/blob/main/LICENSE)
