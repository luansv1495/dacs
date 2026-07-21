/// Set of known variant prefixes (dark/light mode and responsive breakpoints).
const Set<String> dacsVariantPrefixes = {
  'dark',
  'light',
  'sm',
  'md',
  'lg',
  'xl',
  '2xl',
};

/// Breakpoints for responsive variants mapped to min-width in pixels.
const Map<String, double> dacsBreakpoints = {
  'sm': 640,
  'md': 768,
  'lg': 1024,
  'xl': 1280,
  '2xl': 1536,
};

/// Application order for breakpoint variants (smallest first).
const List<String> dacsBreakpointOrder = ['sm', 'md', 'lg', 'xl', '2xl'];
