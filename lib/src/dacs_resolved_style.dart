import 'dacs_style.dart';

/// The result of resolving a [DacsStyleSheet] against a set of conditions.
///
/// Currently a type alias for [DacsStyle]. In the future this will become
/// an immutable class that owns the generated style result, removing the
/// ambiguity between mutable (programmatic) and immutable (resolved) styles.
typedef DacsResolvedStyle = DacsStyle;
