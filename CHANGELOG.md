## 0.4.0

- **dButton expansion**: `surfaceTintColor`, `iconColor`, `minimumSize`, `fixedSize`, `maximumSize` now use `_stateProp` for dynamic WidgetState resolution
- **dButton shape fix**: `shape` now uses `_stateProp<OutlinedBorder?>` instead of `WidgetStatePropertyAll` — variants like `hover:rounded-xl`, `pressed:rounded-sm` resolve dynamically
- **dButton new fields**: `surfaceTintColor`, `iconColor`, `iconSize`, `minimumSize`, `fixedSize`, `maximumSize`, `mouseCursor` — all using `_stateProp` for WidgetState variant resolution

## 0.3.0

- **Theme colors**: use `ColorScheme` keys directly — `text-primary`, `bg-surface`, `border-error`, `from-tertiary`, etc.
- **Arbitrary values**: `text-[#ff0000]`, `bg-[rgb(255,0,0)]`, `p-[20]`, `w-[50%]`, `rounded-[12]`
- **Material widget extensions**: 26 widgets — `.dButton(context)`, `.dCheckbox(context)`, `.dCard(context)`, `.dAppBar(context)`, etc.
- **WidgetState variants**: `hover:`, `focus:`, `active:`, `disabled:`, `selected:`, `error:`, `pressed:`, `dragged:`, `scrolledUnder:`
- **Chained compound variants**: combine any prefixes — `dark:hover:`, `dark:md:focus:`, `light:lg:disabled:`
- **Split padding/margin**: `.dPads` returns padding, `.dMargin` for margin (breaking change from 0.2.0)
- **`ClassParser` singleton + LRU cache**: single instance with auto-eviction at 500 entries
- Internal: `_addCompoundVariant` correctly resolves theme colors over base
- Removed public `ClassParser` export and `clearCache()` — cache is self-managed

## 0.2.0

- **Variants**: dark/light mode (`dark:`, `light:`) and responsive breakpoints (`sm:`, `md:`, `lg:`, `xl:`, `2xl:`)
- **Context-aware extensions**: `.dTextOf(context)`, `.dBoxOf(context)`, `.dPadsOf(context)` etc. resolve variants from `MediaQuery`
- **`DacsStyle.resolve()` / `resolveFor()`**: merge variants into a single style based on brightness and screen width
- **`DacsStyle.clone()` / `mergeFrom()`**: utility methods for style composition
- **Position**: `inset-*`, `top-*`, `right-*`, `bottom-*`, `left-*` via `.dPosition`
- **Transform**: `scale-*`, `rotate-*`, `translate-*`, `skew-*` via `.dTransform`
- **Gradient**: `bg-gradient-to-*`, `from-*`, `via-*`, `to-*` via `.dGradient`
- **Decoration style/thickness/color**: `decoration-solid`, `decoration-2`, `decoration-red-500`, etc.
- **`ClassParser` cache**: static cache avoids redundant parsing
- Renamed extension getters: `.dacsText` → `.dText`, `.dacsPad` → `.dPads`, `.dacsBox` → `.dBox`, `.dacsStyle` → `.dStyle`, `.dacsMargin` → `.dPads`

## 0.1.0

- Initial release.
- Tailwind-inspired utility classes: text-*, font-*, text|bg|border-{color}-{shade}
- Spacing: p-*, m-* with directional variants (px, py, pt, pr, pb, pl)
- Border radius: rounded-* with directional variants (t, b, l, r, tl, tr, bl, br)
- Sizing: w-*, h-*, opacity-*
- Shadows: shadow-sm to shadow-2xl, shadow-inner, shadow-none
- Typography: italic, underline, line-through, tracking-*, leading-*, decoration-*
- String extensions: .dText, .dPads, .dBox, .dStyle, .dShadow, .dSize
- Full Tailwind v3 color palette (22 colors × 11 shades)
