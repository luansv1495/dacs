// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsInputDecorationAdapter implements DacsAdapter<InputDecoration> {
  const DacsInputDecorationAdapter();

  @override
  InputDecoration build(DacsStyleSheet sheet, DacsResolveContext context) {
    final st = materialStateFor(sheet, context);
    final s = st.base;
    final focused = _stateStyle(st, 'focus');
    final disabled = _stateStyle(st, 'disabled');
    final error = _stateStyle(st, 'error');
    final focusedError = _compoundStyle(st, {
          WidgetState.focused,
          WidgetState.error,
        }) ??
        _compoundStyle(st, {
          WidgetState.error,
          WidgetState.focused,
        });

    return InputDecoration(
      labelText: s.inputLabelText,
      hintText: s.inputHintText,
      helperText: s.inputHelperText,
      errorText: s.inputErrorText,
      prefixText: s.inputPrefixText,
      suffixText: s.inputSuffixText,
      labelStyle: _textStyle(s),
      hintStyle: _textStyle(s),
      helperStyle: _textStyle(s),
      errorStyle: _textStyle(error ?? s),
      prefixStyle: _textStyle(s),
      suffixStyle: _textStyle(s),
      filled: s.inputFilled ?? s.backgroundColor != null,
      isDense: s.inputDense,
      fillColor: s.backgroundColor,
      border: _outline(s),
      enabledBorder: _outline(s),
      focusedBorder: _outline(focused),
      disabledBorder: _outline(disabled),
      errorBorder: _outline(error),
      focusedErrorBorder: _outline(focusedError),
      contentPadding: s.padding,
    );
  }

  TextStyle? _textStyle(DacsStyle? style) {
    if (style == null) return null;
    final textStyle = style.toTextStyle();
    if (textStyle == const TextStyle()) return null;
    return textStyle;
  }

  DacsStyle? _stateStyle(DacsMaterialState state, String key) {
    return state.variants[key];
  }

  DacsStyle? _compoundStyle(DacsMaterialState state, Set<WidgetState> states) {
    for (final rule in state.compoundVariants) {
      if (rule.requiredStates.length == states.length &&
          rule.requiredStates.containsAll(states)) {
        return rule.style;
      }
    }
    return null;
  }

  OutlineInputBorder? _outline(DacsStyle? style) {
    if (style == null) return null;
    if (style.borderColor == null &&
        style.borderWidth == null &&
        style.borderRadius == null) {
      return null;
    }
    return OutlineInputBorder(
      borderSide: dacsSide(style) ?? BorderSide.none,
      borderRadius: style.borderRadius is BorderRadius
          ? (style.borderRadius as BorderRadius)
          : BorderRadius.zero,
    );
  }
}
