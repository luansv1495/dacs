# Utilities

This page groups the core utility categories. See the README for quick examples.

## Typography

- `text-*`
- `font-*`
- `leading-*`
- `tracking-*`
- `italic`, `not-italic`
- `underline`, `line-through`, `no-underline`
- `decoration-*`

## Colors

Use Tailwind color names or Flutter `ColorScheme` keys:

```dart
'text-sky-500 bg-white border-gray-200'
'text-primary bg-surface border-outline'
```

## Spacing

Padding and margin utilities support all directions:

```dart
'p-4 px-2 py-3 pt-1 pr-2 pb-3 pl-4'
'm-4 mx-2 my-3 mt-1 mr-2 mb-3 ml-4'
```

## Borders and Radius

```dart
'border border-2 border-red-500 rounded-lg'
'rounded-t-lg rounded-br-xl rounded-ss-md'
```

## Layout Values

Use layout helpers when values do not map to one Flutter style object:

```dart
final layout = 'w-64 h-32 min-w-48 max-w-96 aspect-video object-cover'
    .dLayout;
```

Supported groups include:

- `w-*`, `h-*`;
- `min-w-*`, `max-w-*`, `min-h-*`, `max-h-*`;
- `aspect-*`;
- `overflow-*`;
- `object-cover`, `object-contain`, `object-fill`, `object-none`,
  `object-scale-down`;
- `align-*`.

## Arbitrary Values

Use square brackets for one-off values:

```dart
'text-[#ff0000]'
'bg-[rgb(255,0,0)]'
'p-[20]'
'w-[50%]'
'rounded-[12]'
```
