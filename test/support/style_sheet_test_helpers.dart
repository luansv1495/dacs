import 'package:dacs/dacs.dart';

DacsStyle ruleStyle(DacsStyleSheet sheet, String name) {
  final style = DacsStyle();
  for (final rule in sheet.rules.where((rule) => rule.condition.name == name)) {
    style.mergeFrom(rule.style);
  }
  return style;
}
