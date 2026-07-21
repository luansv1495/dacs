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
- `dCheckbox`
- `dSwitch`
- `dRadio`
- `dChip`
- `dAppBar`
- `dCard`
- `dListTile`
- `dTabBar`
- `dBottomNav`
- `dInput` / `dInputOf`
- `dProgress`
- `dTooltip`
- `dDivider`
- `dScrollbar`
- `dSnackBar`
- `dDialog`
- `dBottomSheet`
- `dExpansionTile`
- `dNavBar`
- `dFab`
- `dDataTable`
- `dSearchBar`
- `dMenu`
- `dSlider`
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
