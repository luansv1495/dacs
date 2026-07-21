/// Callback called when the compiler finds a utility it cannot parse.
typedef DacsUnknownUtilityCallback = void Function(String utility);

/// Global configuration for DACS parsing and diagnostics.
class Dacs {
  Dacs._();

  /// Whether unknown utilities should throw a [DacsUnknownUtilityException].
  static bool get strictMode => _strictMode;

  /// Maximum number of compiled class strings kept in the parser cache.
  static int get cacheSize => _cacheSize;

  /// Callback called for unknown utilities when configured.
  static DacsUnknownUtilityCallback? get onUnknownUtility => _onUnknownUtility;

  static bool _strictMode = false;
  static int _cacheSize = 500;
  static DacsUnknownUtilityCallback? _onUnknownUtility;

  /// Configures global DACS parsing behavior.
  ///
  /// Set [cacheSize] to zero to disable caching. When [strictMode] is true,
  /// unknown utilities throw a [DacsUnknownUtilityException] after the
  /// optional [onUnknownUtility] callback is called.
  static void configure({
    bool strictMode = false,
    int cacheSize = 500,
    DacsUnknownUtilityCallback? onUnknownUtility,
  }) {
    _strictMode = strictMode;
    _cacheSize = cacheSize < 0 ? 0 : cacheSize;
    _onUnknownUtility = onUnknownUtility;
  }
}

/// Error thrown when strict mode encounters an unknown DACS utility.
class DacsUnknownUtilityException implements Exception {
  /// The unknown utility token that could not be parsed.
  final String utility;

  /// The full class string being compiled when [utility] was found.
  final String source;

  /// Creates an exception for an unknown utility.
  const DacsUnknownUtilityException(this.utility, this.source);

  @override
  String toString() =>
      'Unknown DACS utility "$utility" while compiling "$source".';
}
