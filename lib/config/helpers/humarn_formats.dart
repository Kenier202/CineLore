import 'package:intl/intl.dart';

class HumanFormats {
  static String numbers(double number) {
    final numberFormatter = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: "",
      locale: "en",
    ).format(number);

    return numberFormatter;
  }
}
