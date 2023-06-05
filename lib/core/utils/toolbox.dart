// THIS IS A COMPILATION OF ALL THE USEFUL METHODS I USE THROUGH MY FLUTTER PROJECTS //

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input;
  }

  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}
