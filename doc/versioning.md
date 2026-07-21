# Versioning Policy

DACS follows Semantic Versioning.

## Patch Releases

Patch releases are for compatible fixes:

- bug fixes;
- documentation corrections;
- test coverage;
- internal refactors with no public behavior change.

Example: `0.4.0 -> 0.4.1`

## Minor Releases

Minor releases add compatible functionality:

- new utility tokens;
- new Material adapters;
- new context-aware helpers;
- new diagnostics or configuration options with compatible defaults.

Example: `0.4.0 -> 0.5.0`

## Major Releases

Major releases are for breaking public API or behavior:

- removing or renaming public extensions;
- changing return types;
- changing parsing semantics in a way that breaks existing class strings;
- changing default strictness or diagnostics in a breaking way.

Example: `0.x -> 1.0.0` or `1.x -> 2.0.0`

## Internal APIs

Files under `lib/src/` are implementation details unless exported by
`package:dacs/dacs.dart`. Internal structure may change between minor releases.

## Release Checklist

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test --coverage
dart pub global activate dartdoc
dart pub global run dartdoc --validate-links
dart pub global activate pana
dart pub global run pana . --exit-code-threshold 130
flutter pub publish --dry-run
```

Update `CHANGELOG.md`, examples, and documentation before publishing.
