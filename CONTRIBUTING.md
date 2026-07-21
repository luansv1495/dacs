# Contributing to DACS

Thanks for helping improve DACS. This package aims to keep Tailwind-like class
strings ergonomic while producing normal Flutter style objects.

## Local Setup

```bash
flutter pub get
cd example
flutter pub get
cd ..
```

## Validation Checklist

Run these before opening a pull request:

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test --coverage
dart pub global activate dartdoc
dart pub global run dartdoc --validate-links
flutter pub publish --dry-run
```

For pub score checks:

```bash
dart pub global activate pana
dart pub global run pana . --exit-code-threshold 130
```

## Development Guidelines

- Keep parsing context-free. `DacsCompiler.compile` must not depend on
  `BuildContext`; only resolution/adapters should use runtime context.
- Preserve "last class wins" behavior when adding utilities or variants.
- Add tests for new utility tokens, responsive/dark behavior, and Material
  state behavior where applicable.
- Public API exported from `package:dacs/dacs.dart` must have dartdoc comments.
- Prefer focused adapters under `lib/src/adapters/` instead of growing central
  extension files.
- Update README or `doc/` when user-facing behavior changes.
- Do not expose internal adapter/parser APIs unless there is a clear user need.

## Commit Style

Use concise Conventional Commit messages when possible:

```text
feat: add slider theme adapter
fix: preserve source order for compound variants
docs: document input decoration states
test: cover arbitrary layout values
```

## Pull Requests

Every PR should include:

- what changed and why;
- tests added or updated;
- documentation updates, if user-facing behavior changed;
- any breaking changes or migration notes.

## Releases

Releases follow SemVer. See [doc/versioning.md](doc/versioning.md).
