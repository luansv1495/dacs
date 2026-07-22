# Material Widgets

DACS provides context-aware adapters for Material styles and themes.

```dart
ElevatedButton(
  style: 'bg-primary text-onPrimary rounded-lg p-4'.dButton(context),
  onPressed: () {},
  child: const Text('Save'),
)
```

## Supported Adapters

- `dButton`
- `dIconButton`
- `dSegmentedButton`
- `dCheckbox`
- `dSwitch`
- `dRadio`
- `dChip`
- `dBadge`
- `dAppBar`
- `dCard`
- `dListTile`
- `dTabBar`
- `dBottomNav`
- `dNavBar`
- `dNavRail`
- `dDrawer`
- `dBottomAppBar`
- `dInput` / `dInputOf`
- `dProgress`
- `dTooltip`
- `dDivider`
- `dScrollbar`
- `dSnackBar`
- `dDialog`
- `dBottomSheet`
- `dExpansionTile`
- `dFab`
- `dDataTable`
- `dSearchBar`
- `dMenu`
- `dPopupMenu`
- `dDropdownMenu`
- `dSlider`
- `dDatePicker`
- `dTimePicker`
- `dIcon`
- `dShape`

For the per-widget property matrix, see [widget-support.md](widget-support.md).

## Widget States

State variants are resolved into Flutter state properties when the target API
supports them:

```dart
'bg-primary hover:bg-primaryContainer disabled:bg-surface'
```

Supported state prefixes:

- `hover:`
- `focus:`
- `active:` / `pressed:`
- `disabled:`
- `selected:`
- `error:`
- `dragged:`
- `scrolledUnder:`

Compound conditions are supported:

```dart
'dark:md:hover:bg-red-500'
```

## Picker Themes

Date and time pickers use explicit semantic color channels so adapters never
derive interaction colors:

```dart
Theme.of(context).copyWith(
  datePickerTheme:
      'date-header-bg-primary date-header-text-onPrimary '
      'date-day-text-onSurface selected:date-day-bg-primary'
          .dDatePicker(context),
  timePickerTheme:
      'time-dial-bg-surfaceVariant time-dial-hand-primary '
      'time-hour-minute-bg-surfaceVariant '
      'selected:time-hour-minute-bg-secondary'
          .dTimePicker(context),
);
```
