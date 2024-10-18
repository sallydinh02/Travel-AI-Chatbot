import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslateEn2Vn {
  static final OnDeviceTranslator _translatorEn2Vn = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.english,
      targetLanguage: TranslateLanguage.vietnamese);

  static translate(String inputText) async {
    return await _translatorEn2Vn.translateText(inputText);
  }
}
