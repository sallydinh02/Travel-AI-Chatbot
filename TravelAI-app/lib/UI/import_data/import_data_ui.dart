import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_travel_assistant/objects/attraction.dart';

class ImportDataUi extends StatefulWidget {
  const ImportDataUi({Key? key}) : super(key: key);

  @override
  State<ImportDataUi> createState() => _ImportDataUiState();
}

class _ImportDataUiState extends State<ImportDataUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextButton(
        child: const Text("push data"),
        onPressed: pushData,
      ),
    ));
  }

  FutureOr<void> pushData() async {
    String json = await rootBundle.loadString('assets/attraction.json');
    final data = jsonDecode(json);

    for (var attractionData in data) {
      Attraction attraction = Attraction.fromJson(attractionData);
      attraction.addAttractionToFirebase();
    }
  }
}
