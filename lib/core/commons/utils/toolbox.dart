// THIS IS A COMPILATION OF ALL THE USEFUL METHODS I USE THROUGH MY FLUTTER PROJECTS //

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input;
  }

  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}

double convertDollarsToFrancCFA(double amount) {
  const double conversionRate = 538.17; // Taux de conversion : 1 dollar = 538.17 francs CFA
  return (amount * conversionRate);
}

String formatPrice(double price) {
  String formattedPrice = price.toStringAsFixed(0);
  List<String> parts = [];

  while (formattedPrice.length > 3) {
    parts.insert(0, formattedPrice.substring(formattedPrice.length - 3));
    formattedPrice = formattedPrice.substring(0, formattedPrice.length - 3);
  }

  parts.insert(0, formattedPrice);
  return parts.join(' ');
}

String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength - 3)}...';
  }
}

