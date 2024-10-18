import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslateVn2En {
  static final OnDeviceTranslator _translatorVn2En = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.vietnamese,
      targetLanguage: TranslateLanguage.english);

  static translate(String inputText) async {
    return await _translatorVn2En.translateText(inputText);
  }
}
