import 'package:flutter/material.dart';

/// Runtime information used to resolve conditional DACS rules.
class DacsResolveContext {
  /// Optional Flutter build context used for theme color resolution.
  final BuildContext? buildContext;

  /// Current platform or app brightness.
  final Brightness? brightness;

  /// Current screen width used for responsive breakpoints.
  final double? screenWidth;

  /// Active widget states used by state-aware adapters.
  final Set<WidgetState> states;

  /// Creates a resolve context from explicit values.
  const DacsResolveContext({
    this.buildContext,
    this.brightness,
    this.screenWidth,
    this.states = const {},
  });

  /// Creates a resolve context from [MediaQuery] and [Theme] access in [context].
  factory DacsResolveContext.fromBuildContext(
    BuildContext context, {
    Set<WidgetState> states = const {},
  }) {
    final media = MediaQuery.of(context);
    return DacsResolveContext(
      buildContext: context,
      brightness: media.platformBrightness,
      screenWidth: media.size.width,
      states: states,
    );
  }

  /// Returns a copy of this context with different active widget [states].
  DacsResolveContext withStates(Set<WidgetState> states) {
    return DacsResolveContext(
      buildContext: buildContext,
      brightness: brightness,
      screenWidth: screenWidth,
      states: states,
    );
  }
}
