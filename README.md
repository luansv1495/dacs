# DACS

[![pub.dev](https://img.shields.io/pub/v/dacs)](https://pub.dev/packages/dacs)
[![license](https://img.shields.io/github/license/luansv1495/dacs)](https://github.com/luansv1495/dacs/blob/main/LICENSE)

**DACS** brings Tailwind-inspired utility classes to Flutter. Write concise string expressions to define text styles, padding, margins, colors, borders, and more — just like Tailwind CSS.

```dart
Text(
  'Hello, World!',
  style: 'text-2xl font-medium text-sky-500'.dacsText,
)
```

## Features

- **Zero-config** — just install and use
- **Tailwind v3 color palette** — 22 colors × 11 shades
- **Spacing scale** — from 0 to 384px in Tailwind increments
- **Text utilities** — size, weight, color, letter spacing, line height, decoration
- **Background & border** — colors, border width, border radius with directional variants
- **Sizing & opacity** — width, height, opacity

## Installation

```yaml
dependencies:
  dacs: ^0.1.0
```

## Usage

### Text styles

```dart
Text(
  'Heading',
  style: 'text-3xl font-bold text-gray-900'.dacsText,
)
```

### Padding & Margin

```dart
Container(
  padding: 'px-4 py-2'.dacsPad,
  margin: 'mt-4'.dacsMargin,
  child: Text('Content', style: 'text-base'.dacsText),
)
```

### Box decoration

```dart
Container(
  decoration: 'bg-blue-500 rounded-lg'.dacsBox,
  child: Text('Button', style: 'text-white font-medium'.dacsText),
)
```

### Full example

```dart
Container(
  padding: 'px-6 py-4'.dacsPad,
  margin: 'mb-4'.dacsMargin,
  decoration: 'bg-white rounded-xl border border-gray-200'.dacsBox,
  child: Text(
    'Card Title',
    style: 'text-xl font-semibold text-gray-900'.dacsText,
  ),
)
```

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

### Colors (text, background, border)

Format: `{prefix}-{color}-{shade}`

```dart
'text-sky-500'     // text color
'bg-blue-200'      // background color
'border-red-600'   // border color
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

### Raw access

```dart
final style = 'text-lg font-bold text-red-600'.dacsStyle;
print(style.fontSize);   // 18
print(style.fontWeight); // FontWeight.w700
print(style.color);      // Color(0xFFDC2626)
```

## Extension methods

| Getter | Returns |
|---|---|
| `.dacsText` | `TextStyle` |
| `.dacsPad` | `EdgeInsets` |
| `.dacsMargin` | `EdgeInsets` |
| `.dacsBox` | `BoxDecoration` |
| `.dacsStyle` | `DacsStyle` |

## Additional information

- [Report issues](https://github.com/luansv1495/dacs/issues)
- [View source](https://github.com/luansv1495/dacs)
- Licensed under the [MIT License](LICENSE)
