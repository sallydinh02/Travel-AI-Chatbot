import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:bubble/bubble.dart';
import 'package:http/http.dart' as http;

class ChatUI extends StatelessWidget {
  // state key for animated list state
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<String> _data = [];
  final ScrollController _scrollController=ScrollController();
  final lastKey = GlobalKey();
  // in flask app define route for query
  // Deploy link URL
  //static const String BOT_URL = "https://travel-ai-chatbot.onrender.com/bot"; // replace with server address

  // IPv4 link if run on physical device. This is the link when run Flask app in VSCode
  static const String BOT_URL = "http://192.168.x.xx:5000/bot";

  // Link for Android emulator to connect. It will convert to local host link from 10.0.2.2
  //static const String BOT_URL = "http://10.0.2.2:5000/bot";
  TextEditingController _queryController = TextEditingController();
  double positionSendSubmit=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Ask TravelAI Bot"),
        ),
        body: Stack(
          children: <Widget>[
            AnimatedList(
              key: _listKey,
              initialItemCount: _data.length,
              controller: _scrollController,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 50),
              //physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index, Animation<double> animation)
              {
                return buildItem(_data[index], animation, index);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ColorFiltered(
                colorFilter: ColorFilter.linearToSrgbGamma(),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                      padding: EdgeInsets.only(left:20, right: 20),
                      child: Row(children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              /*icon: Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),*/
                              hintText: "Send message",
                              hintStyle: const TextStyle(color: Colors.black54),
                              fillColor: Colors.white12,
                            ),
                            controller: _queryController,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (msg)
                            {
                              if (_scrollController.hasClients)
                              {
                                if(_scrollController.position.maxScrollExtent<=800) positionSendSubmit=0.0;
                                else positionSendSubmit = _scrollController.position.maxScrollExtent+30;
                                //positionSendSubmit = _scrollController.position.maxScrollExtent+30;
                                print("Position send");
                                print(positionSendSubmit);
                                _scrollController.jumpTo(positionSendSubmit);
                              }
                              Future.delayed(Duration(milliseconds: 500));
                              this.getResponse();
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_scrollController.hasClients)
                            {
                              if(_scrollController.position.maxScrollExtent<=800) positionSendSubmit=0.0;
                              else positionSendSubmit = _scrollController.position.maxScrollExtent+30;
                              print("Position send");
                              print(positionSendSubmit);
                              _scrollController.jumpTo(positionSendSubmit);
                            }
                            Future.delayed(Duration(milliseconds: 500));
                            //sendMessage();
                            this.getResponse();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                )),
                          ),
                        )
                      ])
                  ),
                ),
              ),
            )
          ],
        )
    );
  }

  // response
  void getResponse(){
    if (_queryController.text.length>0){
      this.insertSingleItem(_queryController.text);
      var client = _getClient();
      //print("URL: ");
      //print(Uri.parse(BOT_URL));
      try{
        client.post(Uri.parse(BOT_URL),
          //headers: {"Content-Type": "application/json"},
          body: {"query" : _queryController.text},
        )..then((response){
          print("Content:");
          print(response.body);
          //String jsonsDataString = response.body.replaceAll(r':', r'\\n');
          String jsonsDataString = response.body;
          Map<String, dynamic> data = jsonDecode(jsonsDataString);
          //String replaced=jsonsDataString.replaceAll(r'\', r'\\');
          //print(replaced);
          //Map<String, dynamic> data = jsonDecode(response.body);
          //Map<String, dynamic> data = jsonDecode(replaced);
          insertSingleItem(data['response']+"<bot>");
          if (_scrollController.hasClients)
          {
            //final position = positionSendSubmit+530;
            final position = positionSendSubmit+1500;
            print("Position bot");
            print(position);
            _scrollController.jumpTo(position);
          }
        });
      }catch(e){
        print("Failed -> $e");
      }finally{
        client.close();
        //_queryController.clear();
      }
      //print(Uri.parse(BOT_URL));
      _queryController.clear();
    }
  }

  void insertSingleItem(String message)
  {
    _data.add(message);
    _listKey.currentState?.insertItem(_data.length - 1);
  }

// get client
  http.Client _getClient()
  {
    return http.Client();
  }
}

// build item widget which will take context, animation and index as param
Widget buildItem(String item, Animation<double> animation, int index)
{
  bool isBot=item.endsWith("<bot>");
  return SizeTransition(
    sizeFactor: animation,
    child: Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
      child: Align(
          alignment: isBot?Alignment.topLeft:Alignment.topRight,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isBot? Colors.grey[200] : Colors.blue,
            ),
            padding: EdgeInsets.all(16),
            child: Text(
              item.replaceAll("<bot>", ""),
              style: TextStyle(
                  color: isBot? Colors.black : Colors.white,
                  fontSize: 14
              ),
            ),
          )
        /*child: Bubble(
          child: Text(
            item.replaceAll("<bot>", ""),
            style: TextStyle(
                color: isBot? Colors.black : Colors.white
            ),
          ),
          color: isBot? Colors.grey[200] : Colors.blue,
          padding: BubbleEdges.all(10),
        ),*/
      ),
    ),
  );
  /*return SizeTransition(
    sizeFactor: animation,
    child: Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 15),
      child: Container(
        alignment: isBot?Alignment.topLeft:Alignment.topRight,
        child: Bubble(
          child: Text(
            item.replaceAll("<bot>", ""),
            style: TextStyle(
                color: isBot? Colors.black : Colors.white
            ),
          ),
          color: isBot? Colors.grey[200] : Colors.blue,
          padding: BubbleEdges.all(12),
        ),
      ),
    ),
  );*/
}