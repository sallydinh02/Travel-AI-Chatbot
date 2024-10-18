import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class MachineTranslationUI extends StatefulWidget {
  const MachineTranslationUI({super.key});

  @override
  State<MachineTranslationUI> createState() => _MachineTranslationUIState();
}

class _MachineTranslationUIState extends State<MachineTranslationUI> {
  final _srcTextController = TextEditingController();
  final _modelManagerVn2En = OnDeviceTranslatorModelManager();
  final _modelManagerEn2Vn = OnDeviceTranslatorModelManager();

  final OnDeviceTranslator _translatorVn2En = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.vietnamese,
      targetLanguage: TranslateLanguage.english);
  final OnDeviceTranslator _translatorEn2Vn = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.english,
      targetLanguage: TranslateLanguage.vietnamese);

  final List<DropdownMenuItem<bool>> _translationOptions = [
    const DropdownMenuItem<bool>(
      child: Text("English to Vietnamese"),
      value: true,
    ),
    const DropdownMenuItem<bool>(
      child: Text("Vietnamese to English"),
      value: false,
    ),
  ];

  bool _useEn2VnModel = true;

  String _translatedText = "Translated text";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _srcTextController.dispose();
    _translatorEn2Vn.close();
    _translatorVn2En.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Machine Translate',
        ),
        actions: const [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _chooseModelDropdownButton(),
              TextField(
                controller: _srcTextController,
                decoration: InputDecoration(
                  hintText: "Type something here",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                textAlign: TextAlign.start,
              ),
              TextButton(
                onPressed: _translate,
                child: const Text('Translate'),
              ),
              Text(_translatedText),
            ],
          ),
        ),
      ),
    );
  }

  _chooseModelDropdownButton() {
    return DropdownButton(
      items: _translationOptions,
      onChanged: ((bool? value) {
        setState(() {
          _useEn2VnModel = value!;
        });
      }),
      value: _useEn2VnModel,
    );
  }

  _translate() async {
    String result = "";
    if (_useEn2VnModel) {
      result = await _translatorEn2Vn.translateText(_srcTextController.text);
    } else {
      result = await _translatorVn2En.translateText(_srcTextController.text);
    }

    setState(() {
      _translatedText = result;
    });
  }
}
