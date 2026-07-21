# Widget Support

Legend:

- `[x]` implemented with native state support where the Flutter property allows it
- `[~]` implemented, but the Flutter property is not state-aware or DACS has only a partial mapping
- `[ ]` not implemented
- `[-]` not applicable for the current DACS style model

## ButtonStyle

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| backgroundColor | [x] | `bg-*` | `WidgetStateProperty` |
| foregroundColor | [x] | `text-*` | `WidgetStateProperty` |
| overlayColor | [x] | `hover:bg-*`, `focus:bg-*`, `active:bg-*` | `WidgetStateProperty` |
| textStyle | [x] | `text-*`, `font-*`, decoration, tracking, leading | `WidgetStateProperty` |
| padding | [x] | `p-*`, `px-*`, `py-*`, etc. | `WidgetStateProperty` |
| side | [x] | `border-*` | `WidgetStateProperty` |
| shape | [x] | `rounded-*` | `WidgetStateProperty` |
| elevation | [x] | `shadow-*` blur radius | `WidgetStateProperty` |
| iconColor | [x] | `text-*` | `WidgetStateProperty` |
| iconSize | [x] | `text-*` size | `WidgetStateProperty` |
| minimumSize | [x] | `w-*`, `h-*` | `WidgetStateProperty` |
| maximumSize | [x] | `w-*`, `h-*` | `WidgetStateProperty` |
| fixedSize | [x] | `w-*`, `h-*` | `WidgetStateProperty` |
| mouseCursor | [x] | default cursor behavior | `WidgetStateProperty` |
| shadowColor | [x] | `shadow-*` color | `WidgetStateProperty` |
| surfaceTintColor | [x] | `bg-*` | `WidgetStateProperty` |

## CheckboxThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| fillColor | [x] | `bg-*` | `WidgetStateProperty` |
| checkColor | [x] | `text-*` | `WidgetStateProperty` |
| overlayColor | [x] | `hover:text-*` | `WidgetStateProperty` |
| side | [~] | `border-*` | plain `BorderSide` |
| shape | [~] | `rounded-*` | plain shape |
| splashRadius | [ ] | none | plain value |
| visualDensity | [ ] | none | plain value |
| materialTapTargetSize | [ ] | none | plain value |

## RadioThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| fillColor | [x] | `bg-*`, `active:text-*` | `WidgetStateProperty` |
| overlayColor | [x] | `hover:text-*` | `WidgetStateProperty` |
| splashRadius | [ ] | none | plain value |
| visualDensity | [ ] | none | plain value |
| materialTapTargetSize | [ ] | none | plain value |

## SwitchThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| thumbColor | [x] | `bg-*`, `active:text-*` | `WidgetStateProperty` |
| trackColor | [x] | `bg-*` | `WidgetStateProperty` |
| trackOutlineColor | [x] | `border-*` | `WidgetStateProperty` |
| overlayColor | [x] | `hover:bg-*` | `WidgetStateProperty` |
| thumbIcon | [ ] | none | `WidgetStateProperty` |
| trackOutlineWidth | [ ] | `border-*` not currently mapped | `WidgetStateProperty` |
| splashRadius | [ ] | none | plain value |
| materialTapTargetSize | [ ] | none | plain value |

## ChipThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| color | [x] | `bg-*` | `WidgetStateColor` |
| shape | [~] | `rounded-*` | plain shape |
| side | [~] | `border-*` | plain side |
| padding | [~] | `p-*` | plain padding |
| labelStyle | [ ] | text tokens not currently mapped here | plain text style |
| secondaryLabelStyle | [ ] | none | plain text style |
| brightness | [ ] | none | plain value |
| elevation | [ ] | `shadow-*` not currently mapped | plain value |
| shadowColor | [ ] | `shadow-*` not currently mapped | plain color |
| selectedShadowColor | [ ] | none | plain color |
| showCheckmark | [ ] | none | plain value |
| checkmarkColor | [ ] | `text-*` not currently mapped | plain color |

## InputDecoration

`TextField.style` controls the typed text. `InputDecoration` controls the input
chrome: label, hint, helper, error, prefix/suffix, fill, density, padding, and
borders.

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| border | [x] | `border-*`, `rounded-*` | base input border |
| enabledBorder | [x] | `border-*`, `rounded-*` | enabled border |
| focusedBorder | [x] | `focus:border-*`, `focus:rounded-*` | focused border |
| disabledBorder | [x] | `disabled:border-*`, `disabled:rounded-*` | disabled border |
| errorBorder | [x] | `error:border-*`, `error:rounded-*` | error border |
| focusedErrorBorder | [x] | `focus:error:border-*`, `focus:error:rounded-*` | focused error border |
| labelText | [x] | `label-[Email]` | plain value |
| hintText | [x] | `hint-[you@example.com]` | plain value |
| helperText | [x] | `helper-[Use your work email]` | plain value |
| errorText | [x] | `error-[Required field]` | plain value |
| prefixText | [x] | `prefix-[USD]` | plain value |
| suffixText | [x] | `suffix-[kg]` | plain value |
| labelStyle | [~] | text tokens | plain `TextStyle` |
| hintStyle | [~] | text tokens | plain `TextStyle` |
| helperStyle | [~] | text tokens | plain `TextStyle` |
| errorStyle | [~] | `error:text-*` or text tokens | plain `TextStyle` |
| prefixStyle | [~] | text tokens | plain `TextStyle` |
| suffixStyle | [~] | text tokens | plain `TextStyle` |
| filled | [x] | `filled`, `not-filled`, or inferred from `bg-*` | plain value |
| fillColor | [x] | `bg-*` | plain color |
| isDense | [x] | `dense`, `not-dense` | plain value |
| contentPadding | [x] | `p-*`, `px-*`, `py-*`, etc. | plain value |

## MenuStyle

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| backgroundColor | [x] | `bg-*` | `WidgetStateProperty` |
| shadowColor | [x] | `shadow-*` color | `WidgetStateProperty` |
| surfaceTintColor | [x] | `bg-*` | `WidgetStateProperty` |
| shape | [x] | `rounded-*` | `WidgetStateProperty` |
| side | [x] | `border-*` | `WidgetStateProperty` |
| elevation | [x] | `shadow-*` blur radius | `WidgetStateProperty` |
| padding | [x] | `p-*` | `WidgetStateProperty` |
| alignment | [ ] | alignment tokens not currently mapped | plain value |
| fixedSize | [ ] | `w-*`, `h-*` not currently mapped | `WidgetStateProperty` |
| minimumSize | [ ] | `min-w-*`, `min-h-*` not currently mapped | `WidgetStateProperty` |
| maximumSize | [ ] | `max-w-*`, `max-h-*` not currently mapped | `WidgetStateProperty` |
| visualDensity | [ ] | none | plain value |

## SearchBarThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| backgroundColor | [x] | `bg-*` | `WidgetStateProperty` |
| elevation | [x] | `shadow-*` blur radius | `WidgetStateProperty` |
| shadowColor | [x] | `shadow-*` color | `WidgetStateProperty` |
| surfaceTintColor | [x] | `bg-*` | `WidgetStateProperty` |
| overlayColor | [x] | `hover:bg-*`, `focus:bg-*` | `WidgetStateProperty` |
| side | [x] | `border-*` | `WidgetStateProperty` |
| shape | [x] | `rounded-*` | `WidgetStateProperty` |
| padding | [x] | `p-*` | `WidgetStateProperty` |
| textStyle | [x] | text tokens | `WidgetStateProperty` |
| hintStyle | [x] | text tokens | `WidgetStateProperty` |
| constraints | [~] | `w-*`, `h-*`, `min-*`, `max-*` | plain constraints |
| textCapitalization | [ ] | none | plain value |

## NavigationBarThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| backgroundColor | [~] | `bg-*` | plain color |
| indicatorColor | [~] | `bg-*` with alpha | plain color |
| indicatorShape | [~] | `rounded-*` | plain shape |
| iconTheme | [x] | `text-*`, `w-*` | `WidgetStateProperty` |
| labelTextStyle | [x] | text tokens | `WidgetStateProperty` |
| labelBehavior | [ ] | none | plain value |
| height | [ ] | `h-*` not currently mapped | plain value |
| elevation | [ ] | `shadow-*` not currently mapped | plain value |

## DataTableThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| headingRowColor | [x] | `hover:bg-*` | `WidgetStateProperty` |
| dataRowColor | [x] | `hover:bg-*` | `WidgetStateProperty` |
| headingTextStyle | [~] | text tokens | plain `TextStyle` |
| dataTextStyle | [~] | text tokens | plain `TextStyle` |
| dividerThickness | [~] | `border-*` width | plain value |
| decoration | [~] | `bg-*`, `border-*`, `rounded-*`, `shadow-*` | plain decoration |
| horizontalMargin | [~] | padding left | plain value |
| columnSpacing | [~] | padding right | plain value |
| headingRowHeight | [ ] | `h-*` not currently mapped | plain value |
| dataRowMinHeight | [ ] | `min-h-*` not currently mapped | plain value |
| dataRowMaxHeight | [ ] | `max-h-*` not currently mapped | plain value |
| checkboxHorizontalMargin | [ ] | none | plain value |

## ScrollbarThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| thumbColor | [x] | `bg-*`, `hover:bg-*`, `active:bg-*` | `WidgetStateProperty` |
| trackColor | [x] | `hover:bg-*`, `active:bg-*` alpha | `WidgetStateProperty` |
| trackBorderColor | [x] | `border-*` | `WidgetStateProperty` |
| thickness | [~] | `border-*` width | `WidgetStatePropertyAll` |
| radius | [~] | `rounded-*` | plain radius |
| minThumbLength | [~] | `min-h-*` | plain value |
| crossAxisMargin | [~] | margin left | plain value |
| mainAxisMargin | [~] | margin top | plain value |
| thumbVisibility | [ ] | none | `WidgetStateProperty` |
| trackVisibility | [ ] | none | `WidgetStateProperty` |
| interactive | [ ] | none | plain value |

## SliderThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| activeTrackColor | [~] | `bg-*` | plain color |
| inactiveTrackColor | [~] | `border-*` or `bg-*` alpha | plain color |
| secondaryActiveTrackColor | [~] | `text-*` | plain color |
| disabledActiveTrackColor | [~] | `disabled:bg-*` or `bg-*` alpha | disabled-specific color |
| disabledInactiveTrackColor | [~] | `disabled:border-*` or border alpha | disabled-specific color |
| thumbColor | [~] | `text-*` or `bg-*` | plain color |
| disabledThumbColor | [~] | `disabled:text-*` or text alpha | disabled-specific color |
| overlayColor | [~] | `active:bg-*`, `pressed:bg-*`, `hover:bg-*` | plain color |
| valueIndicatorColor | [~] | `bg-*` | plain color |
| activeTickMarkColor | [~] | `text-*` | plain color |
| inactiveTickMarkColor | [~] | `border-*` | plain color |
| disabledActiveTickMarkColor | [~] | `disabled:text-*` | disabled-specific color |
| disabledInactiveTickMarkColor | [~] | `disabled:border-*` | disabled-specific color |
| trackHeight | [~] | `h-*` or `border-*` width | plain value |
| trackShape | [ ] | none | shape object |
| thumbShape | [ ] | none | shape object |
| overlayShape | [ ] | none | shape object |
| valueIndicatorShape | [ ] | none | shape object |
| showValueIndicator | [ ] | none | plain value |
