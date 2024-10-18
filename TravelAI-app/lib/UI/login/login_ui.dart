// login using firebase authentication
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:smart_travel_assistant/UI/home/home_page_ui.dart';
class Auth {
  handleAuthState(){
    return StreamBuilder(
      // Initialize FlutterFire
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot)
          {
            if(snapshot.hasData)
              {
                return HomePageUI();
              }
            else
              {
                return LoginSignUpUI();
              }
          },

    );

  }
}
class LoginSignUpUI extends StatefulWidget {
  const LoginSignUpUI({Key? key}) : super(key: key);

  @override
  State<LoginSignUpUI> createState() => _LoginSignUpUIState();
}
String? email="";
class _LoginSignUpUIState extends State<LoginSignUpUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 255, 220, 1),
      //appBar: AppBar(title: Text("Welcome To Smart Travel Assistant"), centerTitle: true,),
    body: Center(child:
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child:
        Image(image: AssetImage("assets/images/TravelAILogoNew.png")),
      ),
      SizedBox(
        width: 270,
        height: 50,
        child: ElevatedButton(onPressed: () async {
          await signInWithGoogle();
          setState(() {
          });},
            child: Text("Continue With Google", style: TextStyle(color: Colors.white, fontSize: 16))),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
        child: SizedBox(
            width: 270,
            height: 50,
            child: ElevatedButton(onPressed: () async {
              await signInWithFacebook();
              setState(() {
              });}, child: Text("Continue With FaceBook", style: TextStyle(color: Colors.white, fontSize: 16)))
        )
      )

      ],
      ),
    ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    email = googleUser?.email;
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
