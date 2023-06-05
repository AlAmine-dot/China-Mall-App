// To parse this JSON data, do
//
//     final categoryDto = categoryDtoFromJson(jsonString);

import 'dart:convert';

List<String> categoryDtoFromJson(List<dynamic> json) {
  return List<String>.from(json.map((x) => x.toString()));
}

String categoryDtoToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
