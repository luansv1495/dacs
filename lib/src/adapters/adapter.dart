// ignore_for_file: public_member_api_docs

import '../dacs_resolve_context.dart';
import '../dacs_style_sheet.dart';

abstract interface class DacsAdapter<T> {
  T build(DacsStyleSheet sheet, DacsResolveContext context);
}
