# Core Concepts

## Compile, Resolve, Adapt

DACS separates style processing into explicit phases:

```text
String
  -> DacsCompiler.compile
DacsStyleSheet
  -> resolve(context / brightness / width / states)
DacsResolvedStyle
  -> adapter
TextStyle / BoxDecoration / ButtonStyle / ThemeData
```

Compilation is context-free. It parses tokens into a `DacsStyleSheet` containing
base style values and conditional rules. Resolution applies runtime information
such as brightness, screen width, theme colors, and widget states, then returns
an immutable `DacsResolvedStyle`.

For the supported public surface of `package:dacs/dacs.dart`, see
[Public API](public-api.md). Adapters, parsers, and token tables are internal
implementation details unless they are promoted there.

## Last Class Wins

When two classes set the same property, the later class wins.

```dart
'text-sm text-lg'.dText.fontSize // 18
```

The same rule applies to matching variants:

```dart
'dark:text-red-500 md:text-blue-500 dark:text-green-500'
```

If both `dark` and `md` match, source order decides the final value.

## Conditions

Variant prefixes are parsed into typed conditions:

- brightness: `dark:`, `light:`;
- breakpoints: `sm:`, `md:`, `lg:`, `xl:`, `2xl:`;
- widget states: `hover:`, `focus:`, `pressed:`, `disabled:`, `selected:`,
  `error:`, `dragged:`, `scrolledUnder:`.

Compound variants require all conditions to match:

```dart
'dark:md:hover:bg-red-500'
```

## Unknown Utilities

Unknown utilities are ignored by default. Configure diagnostics to see or reject
them:

```dart
Dacs.configure(
  strictMode: true,
  onUnknownUtility: (utility) {
    debugPrint('Unknown DACS utility: $utility');
  },
);
```
