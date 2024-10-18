import 'package:smart_travel_assistant/objects/translate_en_2_vn.dart';
import 'package:smart_travel_assistant/objects/translate_vn_2_en.dart';

class MachineTranslate {
  translate(bool _useEn2Vn, String inputText) {
    return _useEn2Vn
        ? TranslateEn2Vn.translate(inputText)
        : TranslateVn2En.translate(inputText);
  }
}
