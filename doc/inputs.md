# Inputs

`InputDecoration` is separate from typed text style in Flutter. DACS keeps that
separation explicit.

```dart
const classes = 'text-onSurface label-[Email] hint-[you@example.com] '
    'helper-[Use your work email] filled dense bg-surface '
    'border-outline focus:border-primary error:border-error '
    'focus:error:border-primaryContainer rounded-lg p-4';

TextField(
  style: classes.dTextOf(context),
  decoration: classes.dInputOf(context),
)
```

## Text Slots

```dart
'label-[Email]'
'hint-[you@example.com]'
'helper-[Use your work email]'
'error-[Required field]'
'prefix-[USD]'
'suffix-[per month]'
```

## Flags

```dart
'filled'
'not-filled'
'dense'
'not-dense'
```

## Borders

Input border states map to native `InputDecoration` slots:

| DACS class | Flutter property |
|---|---|
| `border:*` | `border`, `enabledBorder` |
| `focus:border:*` | `focusedBorder` |
| `disabled:border:*` | `disabledBorder` |
| `error:border:*` | `errorBorder` |
| `focus:error:border:*` | `focusedErrorBorder` |

Use text utilities separately for the typed input text:

```dart
TextField(
  style: 'text-onSurface'.dTextOf(context),
  decoration: 'label-[Email] border-outline'.dInputOf(context),
)
```
