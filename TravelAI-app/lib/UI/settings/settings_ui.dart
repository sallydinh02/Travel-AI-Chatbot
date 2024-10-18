import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_travel_assistant/UI/login/login_signup.dart';
class SettingsUI extends StatefulWidget {
  const SettingsUI({Key? key}) : super(key: key);

  @override
  State<SettingsUI> createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 3,
        title: const Text(
          'Travel AI',
          style: TextStyle(
            color: Colors.white,
            //fontWeight: FontWeight.w500,
            //fontSize: 24,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFABE1FF),
    body: Center(
    child:
    Column(
    children:[
      SizedBox(height: 80),
    Center(
    child: Text("Settings", style: TextStyle(fontSize: 30,
        color: Colors.red, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
    ),),
      Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: SizedBox(
              width: 350,
              height: 45,
              child: ElevatedButton.icon(onPressed: () async {
                setState(() {
                });
              },
                  icon: Icon(Icons.person, color: Colors.black),
                  label: Text('Change Username', textAlign: TextAlign.left,style: TextStyle(color: Colors.black, fontSize: 19)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,)),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: SizedBox(
              width: 350,
              height: 45,
              child: ElevatedButton.icon(onPressed: () async {
                setState(() {
                });
              },
                icon: Icon(Icons.lock, color: Colors.black),
                label: Text('Change Password', textAlign: TextAlign.left,style: TextStyle(color: Colors.black, fontSize: 19)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: SizedBox(
              width: 350,
              height: 45,
              child:  ElevatedButton.icon(onPressed: () async {
                setState(() {
                });
              },
                icon: Icon(Icons.info, color: Colors.black),
                label: Text('About us', textAlign: TextAlign.left,style: TextStyle(color: Colors.black, fontSize: 19)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,),),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: SizedBox(
              width: 350,
              height: 45,
              child: ElevatedButton.icon(onPressed: () async {
                setState(() {
                });
              },
                icon: Icon(Icons.reviews, color: Colors.black),
                label: Text('Review', textAlign: TextAlign.left,style: TextStyle(color: Colors.black, fontSize: 19)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,),),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: SizedBox(
              width: 350,
              height: 45,
              child: ElevatedButton.icon(onPressed: () async {
                setState(() {
                  _signOut();
                });
              },
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text('Log out', textAlign: TextAlign.left,style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,),),
            ),
          ),

        ],),
    ]
    ),),);
  }

  void _signOut() async {
    try {
    await _auth.signOut();
    // Navigate back to the LoginSignUpScreen upon sign out
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginSignUp()),
    );
    /*ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sign out successful.'),
      ),
    );*/
    } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text('Sign out failed. Please try again. Error: $e'),
    ),
    );
    }
  }

}

