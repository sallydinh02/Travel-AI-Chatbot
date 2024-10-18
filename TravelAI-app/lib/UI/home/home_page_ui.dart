import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_travel_assistant/UI/chatbot/chatstart.dart';
import 'package:smart_travel_assistant/UI/OCR/OCR_ui.dart';
import 'package:smart_travel_assistant/UI/travel/travel_ui.dart';
import 'package:smart_travel_assistant/UI/travel/searchbar.dart';
import 'package:smart_travel_assistant/UI/settings/settings_ui.dart';
import 'package:smart_travel_assistant/objects/city.dart';

class HomePageUI extends StatefulWidget {
  const HomePageUI({Key? key}) : super(key: key);

  @override
  State<HomePageUI> createState() => _HomePageUIState();
}

class _HomePageUIState extends State<HomePageUI> {
  List pages=[
    ChatStart(),
    OCRUI(),
    SearchCityScreen(),
    //TravelUI(),
    //SelectCityOrProvince(city: City.hcmCity),
    SettingsUI()
  ];
  int currentIndex=0;
  void onTap(int index)
  {
    setState(() {
      currentIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepOrangeAccent,
        unselectedItemColor: Colors.black45,
        showUnselectedLabels: false,
        onTap: onTap,
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/customicons/chatboticon.png"),
              size:28.0,
            ),
            label: 'Chatbot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.translate),
            label: 'OCR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Travel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],

      ),
    );
  }
}
