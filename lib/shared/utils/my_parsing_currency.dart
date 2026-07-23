import 'package:intl/intl.dart';

String parsingCurrency(dynamic value, {int decimalDigits = 0}) {
  final r = NumberFormat.currency(
    // locale: "my"
    symbol: "Rp ",
    decimalDigits: decimalDigits,
  ).format(value);
  return r;
}

String parsingCurrencyAdd(dynamic value, {int decimalDigits = 0}) {
  final r = NumberFormat.currency(
    // locale: "my"
    symbol: "+Rp ",
    decimalDigits: decimalDigits,
  ).format(value);
  return r;
}

String parsingCurrencyMin(dynamic value, {int decimalDigits = 0}) {
  final r = NumberFormat.currency(
    // locale: "my"
    symbol: "-Rp ",
    decimalDigits: decimalDigits,
  ).format(value);
  return r;
}

String parsingCurrencyNonSymbol(dynamic value) {
  final r = NumberFormat.currency(
    // locale: "my"
    symbol: "",
    decimalDigits: 0,
  ).format(value);
  return r;
}

String parsingCurrencyAddNonSymbol(dynamic value) {
  final r = NumberFormat.currency(
    // locale: "my"
    symbol: "+",
    decimalDigits: 0,
  ).format(value);
  return r;
}

String parsingCurrencyMinNonSaymbol(dynamic value) {
  final r = NumberFormat.currency(
    // locale: "my"
    symbol: "-",
    decimalDigits: 0,
  ).format(value);
  return r;
}

// String parsingThousandToK(dynamic value) {
//   final r = NumberFormat.compact().format(value);
//   return r;
// }

String parsingCurrencyToK(num value) {
  final result = value / 1000;

  final formatted = result % 1 == 0
      ? result.toInt().toString()
      : result.toStringAsFixed(1).replaceAll('.0', '');

  return "Rp ${formatted}K";
}

String parsingThousandToRB(int number) {
  if (number >= 1000000000) {
    return '${(number / 1000000000).toStringAsFixed(1).replaceAll('.0', '')}M';
  } else if (number >= 1000000) {
    return '${(number / 1000000).toStringAsFixed(1).replaceAll('.0', '')}jt';
  } else if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(1).replaceAll('.0', '')}rb';
  } else {
    return number.toString();
  }
}
