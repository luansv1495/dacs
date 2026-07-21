# Widget Support

Legend:

- `[x]` implemented with native state support where the Flutter property allows it
- `[~]` implemented, but the Flutter property is not state-aware or DACS has only a partial mapping
- `[ ]` not implemented
- `[-]` not applicable for the current DACS style model

State mappings use only values explicitly declared by the class string. DACS
does not derive colors, opacity, overlays, disabled colors, unselected colors,
or hover/focus/pressed alpha values inside adapters.

## ButtonStyle

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| backgroundColor | [x] | `bg-*` | `WidgetStateProperty` |
| foregroundColor | [x] | `text-*` | `WidgetStateProperty` |
| overlayColor | [x] | `overlay-*` | `WidgetStateProperty` |
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
| mouseCursor | [x] | `cursor-*` | `WidgetStateProperty` |
| shadowColor | [x] | `shadow-*` color | `WidgetStateProperty` |
| surfaceTintColor | [x] | `bg-*` | `WidgetStateProperty` |
| alignment | [~] | `align-*` | plain alignment |
| iconAlignment | [~] | `icon-align-start`, `icon-align-end` | plain value |
| visualDensity | [~] | `density-*` | plain value |
| tapTargetSize | [~] | `tap-target-*` | plain value |
| animationDuration | [~] | `duration-*` | plain value |
| enableFeedback | [~] | `feedback`, `no-feedback` | plain value |
| splashFactory | [~] | `splash-none`, `splash-ripple`, `splash-ink`, `splash-sparkle` | factory preset |
| backgroundBuilder | [~] | `button-bg-layer` | layer builder preset |
| foregroundBuilder | [~] | `button-fg-layer` | layer builder preset |

## CheckboxThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| fillColor | [x] | `bg-*` | `WidgetStateProperty` |
| checkColor | [x] | `text-*` | `WidgetStateProperty` |
| overlayColor | [x] | `overlay-*` | `WidgetStateProperty` |
| side | [~] | `border-*` | plain `BorderSide` |
| shape | [~] | `rounded-*` | plain shape |
| mouseCursor | [x] | `cursor-*` | `WidgetStateProperty` |
| splashRadius | [~] | `splash-*` | plain value |
| visualDensity | [~] | `density-*` | plain value |
| materialTapTargetSize | [~] | `tap-target-*` | plain value |

## RadioThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| fillColor | [x] | `bg-*` | `WidgetStateProperty` |
| overlayColor | [x] | `overlay-*` | `WidgetStateProperty` |
| backgroundColor | [x] | `bg-*` | `WidgetStateProperty` |
| side | [~] | `border-*` | plain `BorderSide` |
| innerRadius | [x] | `w-*` or `h-*` | `WidgetStateProperty` |
| mouseCursor | [x] | `cursor-*` | `WidgetStateProperty` |
| splashRadius | [~] | `splash-*` | plain value |
| visualDensity | [~] | `density-*` | plain value |
| materialTapTargetSize | [~] | `tap-target-*` | plain value |

## SwitchThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| thumbColor | [x] | `text-*` | `WidgetStateProperty` |
| trackColor | [x] | `bg-*` | `WidgetStateProperty` |
| trackOutlineColor | [x] | `border-*` | `WidgetStateProperty` |
| overlayColor | [x] | `overlay-*` | `WidgetStateProperty` |
| thumbIcon | [x] | `thumb-icon-*` | `WidgetStateProperty` |
| trackOutlineWidth | [x] | `border-*` width | `WidgetStateProperty` |
| mouseCursor | [x] | `cursor-*` | `WidgetStateProperty` |
| padding | [~] | `p-*` | plain padding |
| splashRadius | [~] | `splash-*` | plain value |
| materialTapTargetSize | [~] | `tap-target-*` | plain value |

## ChipThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| color | [x] | `bg-*` | `WidgetStateColor` |
| shape | [~] | `rounded-*` | plain shape |
| side | [~] | `border-*` | plain side |
| padding | [~] | `p-*` | plain padding |
| backgroundColor | [~] | `bg-*` | plain color |
| disabledColor | [~] | `disabled:bg-*` | plain color |
| selectedColor | [~] | `selected:bg-*` | plain color |
| surfaceTintColor | [~] | `bg-*` | plain color |
| labelPadding | [~] | `m-*` | plain padding |
| labelStyle | [~] | text tokens | plain text style |
| secondaryLabelStyle | [~] | `selected:*` text tokens | plain text style |
| brightness | [~] | `brightness-light`, `brightness-dark` | plain value |
| elevation | [~] | `shadow-*` blur radius | plain value |
| pressElevation | [~] | `pressed:shadow-*` or `active:shadow-*` blur radius | plain value |
| shadowColor | [~] | `shadow-*` color | plain color |
| selectedShadowColor | [~] | `selected:shadow-*` color | plain color |
| showCheckmark | [~] | `checkmark`, `no-checkmark` | plain value |
| checkmarkColor | [~] | `text-*` | plain color |
| iconTheme | [~] | `text-*`, `w-*` | plain icon theme |
| avatarBoxConstraints | [~] | `w-*`, `h-*`, `min-*`, `max-*` | plain constraints |
| deleteIconBoxConstraints | [~] | `disabled:w-*`, `disabled:h-*`, `disabled:min-*`, `disabled:max-*` | plain constraints |

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
| floatingLabelStyle | [~] | `focus:text-*` or text tokens | plain `TextStyle` |
| hintStyle | [~] | text tokens | plain `TextStyle` |
| helperStyle | [~] | text tokens | plain `TextStyle` |
| errorStyle | [~] | `error:text-*` or text tokens | plain `TextStyle` |
| prefixStyle | [~] | text tokens | plain `TextStyle` |
| suffixStyle | [~] | text tokens | plain `TextStyle` |
| iconColor | [~] | `text-*` | plain color |
| prefixIconColor | [~] | `focus:text-*` or `text-*` | plain color |
| suffixIconColor | [~] | `focus:text-*` or `text-*` | plain color |
| filled | [x] | `filled`, `not-filled`, or inferred from `bg-*` | plain value |
| fillColor | [x] | `bg-*` | plain color |
| focusColor | [~] | `focus:bg-*` | plain color |
| hoverColor | [~] | `hover:bg-*` | plain color |
| isDense | [x] | `dense`, `not-dense` | plain value |
| contentPadding | [x] | `p-*`, `px-*`, `py-*`, etc. | plain value |
| constraints | [~] | `w-*`, `h-*`, `min-*`, `max-*` | plain constraints |
| alignLabelWithHint | [~] | `label-align-hint`, `label-no-align-hint` | plain value |
| floatingLabelBehavior | [~] | `label-float-auto`, `label-float-always`, `label-float-never` | plain value |

## AppBarTheme

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| backgroundColor | [~] | `bg-*` | plain color |
| foregroundColor | [~] | `text-*` | plain color |
| elevation | [~] | `shadow-*` blur radius | plain value |
| shadowColor | [~] | `shadow-*` color | plain color |
| surfaceTintColor | [~] | `bg-*` | plain color |
| shape | [~] | `rounded-*` | plain shape |
| iconTheme | [~] | `text-*`, `w-*` | plain icon theme |
| actionsIconTheme | [~] | `text-*`, `w-*` | plain icon theme |
| titleSpacing | [~] | margin left | plain value |
| leadingWidth | [~] | `w-*` | plain value |
| toolbarHeight | [~] | `h-*` | plain value |
| toolbarTextStyle | [~] | text tokens | plain text style |
| titleTextStyle | [~] | text tokens | plain text style |
| actionsPadding | [~] | `p-*` | plain padding |

## CardTheme

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| color | [~] | `bg-*` | plain color |
| shadowColor | [~] | `shadow-*` color | plain color |
| surfaceTintColor | [~] | `bg-*` | plain color |
| elevation | [~] | `shadow-*` blur radius | plain value |
| margin | [~] | `m-*`, `mx-*`, `my-*`, etc. | plain margin |
| shape | [~] | `rounded-*` | plain shape |
| clipBehavior | [~] | `overflow-*` | plain value |

## ListTileThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| tileColor | [~] | `bg-*` | plain color |
| textColor | [~] | `text-*` | plain color |
| iconColor | [~] | `text-*` | plain color |
| selectedColor | [~] | `text-*` | plain color |
| shape | [~] | `rounded-*` | plain shape |
| contentPadding | [~] | `p-*`, `px-*`, `py-*`, etc. | plain padding |
| selectedTileColor | [~] | `selected:bg-*` | plain color |
| titleTextStyle | [~] | text tokens | plain text style |
| subtitleTextStyle | [~] | text tokens | plain text style |
| leadingAndTrailingTextStyle | [~] | text tokens | plain text style |
| dense | [x] | `dense`, `not-dense` | plain value |
| horizontalTitleGap | [~] | `gap-*` | plain value |
| minVerticalPadding | [~] | padding top | plain value |
| minLeadingWidth | [~] | `min-w-*` | plain value |
| minTileHeight | [~] | `min-h-*` | plain value |

## TabBarTheme

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| labelColor | [~] | `text-*` | plain color |
| unselectedLabelColor | [~] | `unselected-*` | plain color |
| indicatorColor | [~] | `text-*` | plain color |
| labelStyle | [~] | text tokens | plain text style |
| unselectedLabelStyle | [~] | text tokens | plain text style |
| indicator | [~] | `bg-*`, `border-*`, `rounded-*` | decoration |
| dividerColor | [~] | `border-*` color | plain color |
| dividerHeight | [~] | `border-*` width | plain value |
| indicatorSize | [~] | `tab-indicator-label`, `tab-indicator-tab` | plain value |
| labelPadding | [~] | `p-*` | plain padding |
| overlayColor | [x] | `overlay-*` | `WidgetStateProperty` |
| splashFactory | [~] | `splash-none`, `splash-ripple`, `splash-ink`, `splash-sparkle` | factory preset |

## BottomNavigationBarThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| backgroundColor | [~] | `bg-*` | plain color |
| selectedItemColor | [~] | `text-*` | plain color |
| unselectedItemColor | [~] | `unselected-*` | plain color |
| selectedLabelStyle | [~] | text tokens | plain text style |
| unselectedLabelStyle | [~] | text tokens | plain text style |
| elevation | [~] | `shadow-*` blur radius | plain value |
| selectedIconTheme | [~] | `text-*`, `w-*` | plain icon theme |
| unselectedIconTheme | [~] | `unselected-*`, `w-*` | plain icon theme |
| showSelectedLabels | [~] | `show-selected-labels`, `hide-selected-labels` | plain value |
| showUnselectedLabels | [~] | `show-unselected-labels`, `hide-unselected-labels` | plain value |
| type | [~] | `bottom-nav-fixed`, `bottom-nav-shifting` | plain value |
| landscapeLayout | [~] | `bottom-nav-layout-*` | plain value |

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
| alignment | [~] | `align-*` | plain value |
| fixedSize | [x] | `w-*`, `h-*` | `WidgetStateProperty` |
| minimumSize | [x] | `min-w-*`, `min-h-*` | `WidgetStateProperty` |
| maximumSize | [x] | `max-w-*`, `max-h-*` | `WidgetStateProperty` |
| visualDensity | [~] | `density-*` | plain value |

## SearchBarThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| backgroundColor | [x] | `bg-*` | `WidgetStateProperty` |
| elevation | [x] | `shadow-*` blur radius | `WidgetStateProperty` |
| shadowColor | [x] | `shadow-*` color | `WidgetStateProperty` |
| surfaceTintColor | [x] | `bg-*` | `WidgetStateProperty` |
| overlayColor | [x] | `overlay-*` | `WidgetStateProperty` |
| side | [x] | `border-*` | `WidgetStateProperty` |
| shape | [x] | `rounded-*` | `WidgetStateProperty` |
| padding | [x] | `p-*` | `WidgetStateProperty` |
| textStyle | [x] | text tokens | `WidgetStateProperty` |
| hintStyle | [x] | text tokens | `WidgetStateProperty` |
| constraints | [~] | `w-*`, `h-*`, `min-*`, `max-*` | plain constraints |
| textCapitalization | [~] | `capitalize-*` | plain value |

## NavigationBarThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| backgroundColor | [~] | `bg-*` | plain color |
| surfaceTintColor | [~] | `bg-*` | plain color |
| shadowColor | [~] | `shadow-*` color | plain color |
| indicatorColor | [~] | `indicator-*` | plain color |
| indicatorShape | [~] | `rounded-*` | plain shape |
| iconTheme | [x] | `text-*`, `w-*` | `WidgetStateProperty` |
| labelTextStyle | [x] | text tokens | `WidgetStateProperty` |
| labelBehavior | [~] | `nav-label-*` | plain value |
| overlayColor | [x] | `overlay-*` | `WidgetStateProperty` |
| labelPadding | [~] | `p-*` | plain padding |
| height | [~] | `h-*` | plain value |
| elevation | [~] | `shadow-*` blur radius | plain value |

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
| headingRowHeight | [~] | `h-*` | plain value |
| dataRowMinHeight | [~] | `min-h-*` | plain value |
| dataRowMaxHeight | [~] | `max-h-*` | plain value |
| checkboxHorizontalMargin | [~] | margin left | plain value |
| headingRowAlignment | [~] | `justify-*` | plain value |

## ScrollbarThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| thumbColor | [x] | `bg-*`, `hover:bg-*`, `active:bg-*` | `WidgetStateProperty` |
| trackColor | [x] | explicit state `border-*` values only | `WidgetStateProperty` |
| trackBorderColor | [x] | `border-*` | `WidgetStateProperty` |
| thickness | [~] | `border-*` width | `WidgetStatePropertyAll` |
| radius | [~] | `rounded-*` | plain radius |
| minThumbLength | [~] | `min-h-*` | plain value |
| crossAxisMargin | [~] | margin left | plain value |
| mainAxisMargin | [~] | margin top | plain value |
| thumbVisibility | [x] | `opacity-*` (`opacity-0` hides) | `WidgetStatePropertyAll` |
| trackVisibility | [x] | `opacity-*` (`opacity-0` hides) | `WidgetStatePropertyAll` |
| interactive | [~] | `opacity-0` disables interaction | plain value |

## SliderThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| activeTrackColor | [~] | `bg-*` | plain color |
| inactiveTrackColor | [~] | `border-*` | plain color |
| secondaryActiveTrackColor | [~] | `text-*` | plain color |
| disabledActiveTrackColor | [~] | `disabled:bg-*` | disabled-specific color |
| disabledInactiveTrackColor | [~] | `disabled:border-*` | disabled-specific color |
| thumbColor | [~] | `text-*`, falling back to `bg-*` only when `text-*` is absent | plain color |
| disabledThumbColor | [~] | `disabled:text-*` | disabled-specific color |
| overlayColor | [~] | `overlay-*` | plain color |
| valueIndicatorColor | [~] | `bg-*` | plain color |
| activeTickMarkColor | [~] | `text-*` | plain color |
| inactiveTickMarkColor | [~] | `border-*` | plain color |
| disabledActiveTickMarkColor | [~] | `disabled:text-*` | disabled-specific color |
| disabledInactiveTickMarkColor | [~] | `disabled:border-*` | disabled-specific color |
| trackHeight | [~] | `h-*` or `border-*` width | plain value |
| valueIndicatorTextStyle | [~] | text tokens | plain text style |
| mouseCursor | [x] | `cursor-*` | `WidgetStateProperty` |
| padding | [~] | `p-*` | plain padding |
| thumbSize | [x] | `w-*`, `h-*` | `WidgetStatePropertyAll` |
| trackGap | [~] | `gap-*` | plain value |
| trackShape | [~] | `slider-track-rounded`, `slider-track-rect` | shape preset |
| thumbShape | [~] | `slider-thumb-round`, `slider-thumb-none` | shape preset |
| overlayShape | [~] | `slider-overlay-round`, `slider-overlay-none` | shape preset |
| valueIndicatorShape | [~] | `slider-value-indicator-rect`, `slider-value-indicator-paddle` | shape preset |
| showValueIndicator | [~] | `value-indicator-*` | plain value |

## ProgressIndicatorThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| color | [~] | `text-*` | plain color |
| linearTrackColor | [~] | `bg-*` | plain color |
| circularTrackColor | [~] | `bg-*` | plain color |
| linearMinHeight | [~] | `h-*` | plain value |
| refreshBackgroundColor | [~] | `bg-*` | plain color |
| stopIndicatorColor | [~] | `border-*` color | plain color |
| stopIndicatorRadius | [~] | `border-*` width | plain value |

## TooltipThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| decoration | [~] | `bg-*`, `border-*`, `rounded-*`, `shadow-*` | plain decoration |
| textStyle | [~] | text tokens | plain text style |
| padding | [~] | `p-*`, `px-*`, `py-*`, etc. | plain padding |
| margin | [~] | `m-*`, `mx-*`, `my-*`, etc. | plain margin |
| height | [-] | deprecated in Flutter; use constraints | plain value |
| constraints | [~] | `w-*`, `h-*`, `min-*`, `max-*` | plain constraints |
| preferBelow | [~] | `tooltip-below`, `tooltip-above` | plain value |
| verticalOffset | [~] | `top-*` / `inset-t-*` | plain value |
| waitDuration | [~] | `tooltip-wait-*` | duration |
| showDuration | [~] | `tooltip-show-*` | duration |
| exitDuration | [~] | `tooltip-exit-*` | duration |
| enableFeedback | [~] | `feedback`, `no-feedback` | plain value |

## DividerThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| color | [~] | `text-*` | plain color |
| thickness | [~] | `border-*` width | plain value |
| space | [~] | `h-*` | plain value |
| indent | [~] | `left-*` / `inset-l-*` | plain value |
| endIndent | [~] | `right-*` / `inset-r-*` | plain value |

## SnackBarThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| backgroundColor | [~] | `bg-*` | plain color |
| contentTextStyle | [~] | text tokens | plain text style |
| shape | [~] | `rounded-*` | plain shape |
| behavior | [~] | `snackbar-floating`, `snackbar-fixed` | plain value |
| actionTextColor | [~] | `text-*` | plain color |
| disabledActionTextColor | [~] | `disabled-action-*` | plain color |
| closeIconColor | [~] | `text-*` | plain color |
| elevation | [~] | `shadow-*` blur radius | plain value |
| insetPadding | [~] | `m-*` | plain padding |
| showCloseIcon | [~] | `show-close`, `hide-close` | plain value |

## DialogTheme

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| backgroundColor | [~] | `bg-*` | plain color |
| elevation | [~] | `shadow-*` blur radius | plain value |
| shape | [~] | `rounded-*` | plain shape |
| shadowColor | [~] | `shadow-*` color | plain color |
| surfaceTintColor | [~] | `bg-*` | plain color |
| alignment | [~] | `align-*` | plain alignment |
| iconColor | [~] | `text-*` | plain color |
| titleTextStyle | [~] | text tokens | plain text style |
| contentTextStyle | [~] | text tokens | plain text style |
| actionsPadding | [~] | `p-*` | plain padding |
| barrierColor | [~] | `barrier-*` | plain color |
| insetPadding | [~] | `m-*` | plain padding |
| clipBehavior | [~] | `overflow-*` | plain value |
| constraints | [-] | not available on current `DialogTheme` target | plain constraints |

## BottomSheetThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| backgroundColor | [~] | `bg-*` | plain color |
| elevation | [~] | `shadow-*` blur radius | plain value |
| shape | [~] | `rounded-*` | plain shape |
| surfaceTintColor | [~] | `bg-*` | plain color |
| modalBackgroundColor | [~] | `bg-*` | plain color |
| modalBarrierColor | [~] | `barrier-*` | plain color |
| shadowColor | [~] | `shadow-*` color | plain color |
| modalElevation | [~] | `shadow-*` blur radius | plain value |
| showDragHandle | [~] | `show-drag-handle`, `hide-drag-handle` | plain value |
| dragHandleColor | [~] | `text-*` | plain color |
| dragHandleSize | [~] | `w-*`, `h-*` | plain size |
| clipBehavior | [~] | `overflow-*` | plain value |
| constraints | [~] | `w-*`, `h-*`, `min-*`, `max-*` | plain constraints |

## ExpansionTileThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| backgroundColor | [~] | `bg-*` | plain color |
| collapsedBackgroundColor | [~] | explicit `collapsed:bg-*` values only | plain color |
| iconColor | [~] | `text-*` | plain color |
| textColor | [~] | `text-*` | plain color |
| shape | [~] | `rounded-*` | plain shape |
| collapsedShape | [~] | `rounded-*` | plain shape |
| tilePadding | [~] | `p-*` | plain padding |
| childrenPadding | [~] | `m-*` | plain padding |
| expandedAlignment | [~] | `align-*` | plain alignment |
| collapsedIconColor | [~] | explicit `collapsed:text-*` values only | plain color |
| collapsedTextColor | [~] | explicit `collapsed:text-*` values only | plain color |
| clipBehavior | [~] | `overflow-*` | plain value |
| expansionAnimationStyle | [-] | none | animation style |

## FloatingActionButtonThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| backgroundColor | [~] | `bg-*` | plain color |
| foregroundColor | [~] | `text-*` | plain color |
| elevation | [~] | `shadow-*` blur radius | plain value |
| shape | [~] | `rounded-*` | plain shape |
| splashColor | [~] | explicit `active:bg-*` or `pressed:bg-*` values only | plain color |
| focusColor | [~] | explicit `focus:bg-*` values only | plain color |
| hoverColor | [~] | explicit `hover:bg-*` values only | plain color |
| highlightElevation | [~] | explicit `active:shadow-*` or `pressed:shadow-*` values only | plain value |
| focusElevation | [~] | explicit `focus:shadow-*` values only | plain value |
| hoverElevation | [~] | explicit `hover:shadow-*` values only | plain value |
| disabledElevation | [~] | `disabled:shadow-*` | plain value |
| sizeConstraints | [~] | `w-*`, `h-*`, `min-*`, `max-*` | plain constraints |
| smallSizeConstraints | [~] | `small:w-*`, `small:h-*`, `small:min-*`, `small:max-*` | plain constraints |
| largeSizeConstraints | [~] | `large:w-*`, `large:h-*`, `large:min-*`, `large:max-*` | plain constraints |
| extendedSizeConstraints | [~] | `extended:w-*`, `extended:h-*`, `extended:min-*`, `extended:max-*` | plain constraints |
| extendedTextStyle | [~] | text tokens | plain text style |
| extendedPadding | [~] | `p-*` | plain padding |
| iconSize | [~] | `text-*` size or `w-*` | plain value |

## IconThemeData

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| color | [~] | `text-*` | plain color |
| size | [~] | `w-*` | plain value |
| opacity | [~] | `opacity-*` | plain value |
| shadows | [~] | `shadow-*` | plain shadows |
| fill | [~] | `icon-fill`, `icon-no-fill`, `icon-fill-*` | plain value |
| weight | [~] | `icon-weight-*` | plain value |
| grade | [~] | `icon-grade-*` | plain value |
| opticalSize | [~] | `icon-optical-*` | plain value |

## ShapeDecoration

| Property | Status | DACS source | Native state |
| --- | --- | --- | --- |
| color | [~] | `bg-*` | plain color |
| gradient | [~] | `bg-gradient-to-*`, `from-*`, `via-*`, `to-*` | plain gradient |
| shape | [~] | `rounded-*`; defaults to `RoundedRectangleBorder` | plain shape |
| shadows | [~] | `shadow-*` | plain shadows |
| image | [~] | `image-asset-[...]`, `image-network-[...]` | decoration image |

## Remaining Unsupported Properties

These fields are intentionally not mapped yet because they need a richer object
model, direct widget callbacks, or a clear naming decision. They should not be
derived from existing color, spacing, or shadow utilities.

### Interaction Tokens

Most interaction tokens are now supported through explicit utilities like
`overlay-*`, `cursor-*`, `splash-*`, `density-*`, `tap-target-*`, `feedback`,
`duration-*`, and `tooltip-*-*`.

### Component-Specific Flags And Enums

Most simple flags and enums are now supported. Remaining component-specific
fields need a clearer naming decision or a larger model:

- `BottomNavigationBarThemeData.mouseCursor` is not available on the current
  target theme API
- `SnackBarThemeData.actionOverflowThreshold`
- `SnackBarThemeData.dismissDirection`
- `SnackBarThemeData.actionBackgroundColor`
- `SnackBarThemeData.disabledActionBackgroundColor`

### Separate Color Channels

Dedicated color-channel utilities are now available for supported widgets:
`overlay-*`, `indicator-*`, `barrier-*`, `unselected-*`, and
`disabled-action-*`.

### Complex Shape Or Size Objects

Several shape and factory presets are now available. Remaining complex fields:

- additional custom `SliderComponentShape` and `SliderTrackShape` objects
- custom `ButtonLayerBuilder` callbacks beyond `button-bg-layer` and
  `button-fg-layer`
- custom `InteractiveInkFeatureFactory` implementations beyond the named
  presets
- image repeat/filter/center-slice options for `ShapeDecoration.image`
