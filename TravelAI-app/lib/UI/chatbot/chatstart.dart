import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:smart_travel_assistant/UI/chatbot/chat_ui.dart';

class ChatStart extends StatelessWidget {
  ChatStart({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color.fromRGBO(249, 238, 227, 1.0),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 95, 0, 0),
                child:
                Image(image: AssetImage("assets/images/startChatBotNew.png")),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.5),
                  child: SizedBox(
                      width: 200,
                      height: 70,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )
                          ),
                          onPressed: ()
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => ChatUI()));
                          },
                          child: Text("Start chatting!", style: TextStyle(color: Colors.white, fontSize: 20))
                      )
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 18, right: 18, top: 5),
                  child: Text("If you have any question, click on Start chatting button to chat with our bot!", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 14))
              )
            ],
          ),
        ),
      )
    );
  }
}

