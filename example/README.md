# DACS Example

Example Flutter app for the `dacs` package.

It demonstrates:

- Basic text, spacing, color, border, shadow, gradient, and transform utilities.
- Theme color resolution from `ColorScheme`.
- Dark/light and responsive variants.
- Chained variants such as `dark:hover:*`.
- Material adapters such as `dButton`, `dCheckbox`, `dInput`, and `dInputOf`.
- Material 3 theme adapters such as `dNavRail`, `dPopupMenu`, `dDropdownMenu`,
  `dDatePicker`, and `dTimePicker`.
- The difference between `TextField.style` (`.dTextOf(context)`) and
  `TextField.decoration` (`.dInputOf(context)`).

Run it from this directory:

```sh
flutter pub get
flutter run
```
