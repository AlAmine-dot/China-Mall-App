// THIS IS A COMPILATION OF ALL THE USEFUL METHODS I USE THROUGH MY FLUTTER PROJECTS //

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input;
  }

  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}

int convertDollarsToFrancCFA(double amount) {
  const double conversionRate = 538.17; // Taux de conversion : 1 dollar = 538.17 francs CFA
  return (amount * conversionRate).toInt();
}
