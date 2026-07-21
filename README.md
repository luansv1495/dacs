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
- **Dark/Light mode & responsive variants** — `dark:`, `light:`, `sm:`, `md:`, `lg:`, `xl:`, `2xl:`

## Installation

```yaml
dependencies:
  dacs: ^0.2.0
```

## Usage

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

### Raw style access

```dart
final style = 'text-lg font-bold text-red-600'.dStyle;
print(style.fontSize);   // 18
print(style.fontWeight); // FontWeight.w700
print(style.color);      // Color(0xFFDC2626)
```

## Extension methods

### Simple getters (no context)

These parse classes and convert immediately. Useful when you don't need variant resolution.

| Getter | Returns |
|---|---|
| `.dText` | `TextStyle` |
| `.dPads` | `EdgeInsets` |
| `.dBox` | `BoxDecoration` |
| `.dStyle` | `DacsStyle` |
| `.dShadow` | `List<BoxShadow>` |
| `.dSize` | `(double?, double?)` |
| `.dPosition` | `(double?, double?, double?, double?)` |
| `.dTransform` | `Matrix4` |
| `.dGradient` | `LinearGradient?` |

### Context-aware methods (resolve variants)

These accept a `BuildContext` to resolve dark/light mode and responsive breakpoints from `MediaQuery`.

| Method | Returns |
|---|---|
| `.dTextOf(context)` | `TextStyle` |
| `.dPadsOf(context)` | `EdgeInsets` |
| `.dBoxOf(context)` | `BoxDecoration` |
| `.dStyleOf(context)` | `DacsStyle` |
| `.dShadowOf(context)` | `List<BoxShadow>` |
| `.dSizeOf(context)` | `(double?, double?)` |
| `.dPositionOf(context)` | `(double?, double?, double?, double?)` |
| `.dTransformOf(context)` | `Matrix4` |
| `.dGradientOf(context)` | `LinearGradient?` |

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

Resolution order: base → sm → md → lg → xl → 2xl → dark/light. Later overrides earlier.

## Additional information

- [Report issues](https://github.com/luansv1495/dacs/issues)
- [View source](https://github.com/luansv1495/dacs)
- Licensed under the [MIT License](LICENSE)
