# Getting Started

DACS lets you write Tailwind-inspired utility strings and convert them into
Flutter style objects.

## Install

```yaml
dependencies:
  dacs: ^0.5.0
```

```dart
import 'package:dacs/dacs.dart';
```

## Basic Usage

```dart
Text(
  'Hello',
  style: 'text-2xl font-bold text-sky-500'.dText,
)
```

```dart
Container(
  padding: 'px-4 py-2'.dPads,
  decoration: 'bg-white rounded-lg shadow-md'.dBox,
  child: const Text('Card'),
)
```

## Context-Aware Usage

Use `*Of(context)` methods when classes need theme colors, dark/light mode, or
responsive breakpoints.

```dart
Text(
  'Responsive',
  style: 'text-base md:text-xl text-primary dark:text-white'.dTextOf(context),
)
```

## Configuration

DACS works without configuration. Configure diagnostics when you want unknown
utilities to be reported or rejected.

```dart
Dacs.configure(
  strictMode: false,
  cacheSize: 500,
  onUnknownUtility: debugPrint,
);
```

`DacsCompiler.compile(classes)` parses a string without reading `BuildContext`.
Resolution happens later through `resolve`, `resolveFor`, or adapter methods.
