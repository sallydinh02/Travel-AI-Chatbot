import 'package:flutter/material.dart';
import 'package:smart_travel_assistant/UI/login/login_ui.dart';
import 'package:smart_travel_assistant/UI/login/login_signup.dart';
import 'package:smart_travel_assistant/UI/home/home_page_ui.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}): super(key:key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
{
    @override
    void initState()
    {
      super.initState();
      _navigateToLogin();
    }

    _navigateToLogin()async
    {
      await Future.delayed(Duration(seconds: 8), (){});
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginSignUp()));
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Auth().handleAuthState()));
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePageUI()));
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginSignUpUI()));
    }

    @override
    Widget build(BuildContext context)
    {
      return Scaffold(
          /*body: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/TravelSplashBack.png"),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                Center(
                  child: Image(image: AssetImage("assets/images/TravelLogoNew.png")),
                )
              ]
          )*/
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/images/TravelAISplash.png"),
              fit: BoxFit.cover
            )
          ),
        )
      );
    }
}