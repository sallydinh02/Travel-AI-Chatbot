import 'dart:io';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/android_ios.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:smart_travel_assistant/objects/translate_en_2_vn.dart';
import 'package:smart_travel_assistant/objects/translate_vn_2_en.dart';
int lang=0;
final List<bool> _selected= <bool>[true, false];
class OCRUI extends StatefulWidget {
  const OCRUI({Key? key}) : super(key: key);

  @override
  State<OCRUI> createState() => _OCRUIState();
}

class _OCRUIState extends State<OCRUI> {
  var text = '';
  File? image;
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: const Color(0xFFABE1FF),
       body: Center(
    child:
    Column(
      children:[
        const SizedBox(height: 60),
        Center(
       child:
        Text("OCR: Image To Text and \nTranslate", style: TextStyle(fontSize: 20,
            color: Colors.black, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,),),
        const SizedBox(height: 10),
        ToggleButtons(
          isSelected: _selected,
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0; buttonIndex < _selected.length; buttonIndex++) {
                if (buttonIndex == index) {
                  _selected[buttonIndex] = true;
                } else {
                  _selected[buttonIndex] = false;
                }
              }
              lang=index;
            });
          },
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          selectedBorderColor: Colors.blue[700],
          selectedColor: Colors.white,
          fillColor: Colors.blue[900],
          color: Colors.blueAccent[400],
          children: const <Widget>[
            Text('   Eng to Viet   ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('   Viet to Eng   ', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(child: buildImage()),
        const SizedBox(height: 8),
        Center(
          child:
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                ElevatedButton.icon(onPressed: () async {
                  await pickImage();
                  setState(() {
                  });
                },
                    icon: Icon(Icons.file_upload),
                    label: Text('Pick Image'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6259),),),
                SizedBox(width: 16),
                ElevatedButton.icon(onPressed: () async {
                  await takeImage();
                  setState(() {
                  });
                },
                    icon: Icon(Icons.camera),
                    label: Text('Take Photo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6259),),),
              ]
          ),),
        const SizedBox(height: 10),
        TextAreaWidget(textShow: text),
        const SizedBox(height: 10),
        Center(
    child:
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children:[
        ElevatedButton.icon(onPressed: () async {
          text = await FlutterTesseractOcr.extractText(image!.path, language: 'eng+vie',
              args: {
                "psm": "4",
                "preserve_interword_spaces": "1",
              }) ;
          setState(() {
          });
        },
            icon: Icon(Icons.gesture),
            label: Text('    To Text     '),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow[800],),
        ),
      SizedBox(width: 16),
      ElevatedButton.icon(onPressed: () async {
if(lang==0)
  text= await translate(true, text);
else
  text= await translate(false, text);
        setState(() {
        });
      },
          icon: Icon(Icons.translate),
          label: Text('    Translate    '),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow[800],),),
    ],),),
        const SizedBox(height: 50),
  ],
    ),),);}

  Widget buildImage() => Container (
    child: image != null
        ?Image.file(image!, height: 300, width: 300)
        : Image.asset("assets/images/photo.jpg", height: 500, width: 1000),
    height: 10,
    width: 1000,
  );
  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);
    setImage(File(img!.path));
  }
  Future takeImage() async{
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    setImage(File(photo!.path));
  }
  void setImage(File newImage)
  {
setState((){
  image = newImage;
}
);
  }
  void setText(var recognition) {
    setState(() {
      text = recognition;
    }
    );}
  translate(bool _useEn2Vn, String inputText) async {
    return _useEn2Vn
        ? TranslateEn2Vn.translate(inputText)
        : TranslateVn2En.translate(inputText);
  }}
class TextAreaWidget extends StatelessWidget {
  final textShow;

  const TextAreaWidget({
    required this.textShow,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
        Row(
        children: [
          SizedBox(width: 16),
          Expanded(
              child:
              Container(
                  height: 200,
                  decoration: BoxDecoration(border: Border.all(
                      width: 2.0, color: Colors.black12)),
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: SelectableText(
                      textShow.isEmpty
                          ? 'Take/Up an image then click button "To Text" to get text'
                          : textShow,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, fontStyle: FontStyle.normal,
                        color: Colors.black, decoration: TextDecoration.none,),
                  )

              )

          ),
          SizedBox(width: 16),
         // const SizedBox(width: 40),
         /* IconButton(
        icon: Icon(Icons.translate, color: Colors.deepOrange),
        color: Colors.blue,
        onPressed:translate(),
      )*/
    ]
    );
  }
}

