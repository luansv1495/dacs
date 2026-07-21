// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';
import 'adapter.dart';
import 'material_state.dart';

class DacsChipThemeAdapter implements DacsAdapter<ChipThemeData> {
  const DacsChipThemeAdapter();

  @override
  ChipThemeData build(DacsStyleSheet sheet, DacsResolveContext context) {
    final st = materialStateFor(sheet, context);
    return ChipThemeData(
      color: dacsStateProp<WidgetStateColor?>(
        st,
        (s) => s.backgroundColor != null
            ? WidgetStateColor.resolveWith((_) => s.backgroundColor!)
            : null,
      ),
      backgroundColor: st.base.backgroundColor,
      disabledColor: st.variantOverrides['disabled']?.backgroundColor,
      selectedColor: st.variantOverrides['selected']?.backgroundColor,
      shadowColor: st.base.boxShadow?.firstOrNull?.color,
      surfaceTintColor: st.base.backgroundColor,
      selectedShadowColor:
          st.variantOverrides['selected']?.boxShadow?.firstOrNull?.color,
      checkmarkColor: st.base.color,
      shape: dacsShape(st.base),
      side: dacsSide(st.base),
      padding: st.base.padding,
      labelPadding: st.base.margin,
      labelStyle: st.base.toTextStyle(),
      secondaryLabelStyle: st.variantOverrides['selected']?.toTextStyle(),
      brightness: st.base.chipBrightness,
      showCheckmark: st.base.chipShowCheckmark,
      elevation: st.base.boxShadow?.firstOrNull?.blurRadius,
      pressElevation:
          st.variantOverrides['pressed']?.boxShadow?.firstOrNull?.blurRadius ??
              st.variantOverrides['active']?.boxShadow?.firstOrNull?.blurRadius,
      iconTheme: st.base.color != null || st.base.width != null
          ? IconThemeData(color: st.base.color, size: st.base.width)
          : null,
      avatarBoxConstraints: st.base.toConstraints(),
      deleteIconBoxConstraints:
          st.variantOverrides['disabled']?.toConstraints(),
    );
  }
}
