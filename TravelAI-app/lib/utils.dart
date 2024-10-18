import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> convertToListStringToListDropdownMenuItem(
    List<String> list) {
  return list
      .map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(child: Text(e), value: e))
      .toList();
}
