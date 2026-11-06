import 'package:intl/intl.dart';

String parsingCurrency(dynamic value, {int decimalDigits = 0}) {
  final r = NumberFormat.currency(
    locale: "id",
    symbol: "Rp ",
    decimalDigits: decimalDigits,
  ).format(value);
  return r;
}
