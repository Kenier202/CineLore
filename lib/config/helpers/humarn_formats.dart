import 'package:intl/intl.dart';

class HumanFormats {
  static String numbers(double number, [decimals]) {
    final numberFormatter = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: "",
      locale: "en",
    ).format(number);

    return numberFormatter;
  }
}
