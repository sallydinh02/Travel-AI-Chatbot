/*
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_travel_assistant/UI/home/home_page_ui.dart';

class LoginSignUp extends StatefulWidget {
  @override
  _LoginSignUpState createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Travel AI!'),
        backgroundColor: Colors.deepOrange,
      ),
      backgroundColor: const Color(0xFFABE1FF),
        body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
        Container(
        alignment: Alignment.center,
        child: Image.asset(
          "assets/images/TravelAILogoNew.png", // Replace with your logo asset
        width: 250,
        height: 250,
        ),
        ),
        SizedBox(height: 20.0),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(icon: Icon(Icons.email), labelText: 'Enter Your Email', border: OutlineInputBorder(),),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(icon: Icon(Icons.lock), labelText: 'Enter Your Password', border: OutlineInputBorder(),),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_isLogin) {
                      _login();
                    } else {
                      _signUp();
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,), child: Text(
                _isLogin ? 'Log In' : 'Sign Up',
                style: TextStyle(fontSize: 15),
              ),
              ),
              SizedBox(height: 12.0),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                child: Text(
                  _isLogin? 'Do not have an account yet? Create one' : 'Already have an account? Sign in',
                  style: TextStyle(color: Colors.deepOrange, fontSize: 15),
                ),
              ),
            ],
          ),
        ),],
      ),),),
    );
  }

  void _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      User? user = userCredential.user;
      */
/*ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Log In Successful. Welcome User: ${user?.email}'),
        ),
      );*//*

      _email.clear();
      _password.clear();
      // Navigate to HomePage upon successful login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePageUI()),
      );
    } catch (e) {
      */
/*ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed. Please try again. Error: $e .'),
        ),
      );*//*

      _email.clear();
      _password.clear();

      // Navigate back to LoginSignUpScreen upon failed login
    }
  }

  void _signUp() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      User? user = userCredential.user;
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sign up successful. User: ${user?.email}'),
      ),);
      _email.clear();
      _password.clear();
      // Navigate to HomePage upon successful signup
    } catch (e) {
      // Show error message using SnackBar
      */
/*ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign up failed. Please try again. Error: $e .'),
        ),
      );*//*

      _email.clear();
      _password.clear();
    }
  }
}

*/
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_travel_assistant/UI/home/home_page_ui.dart';

class LoginSignUp extends StatefulWidget {
  @override
  _LoginSignUpState createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  bool _isLoginForm = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 255, 220, 1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 45),
              //margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child:
              Image(image: AssetImage("assets/images/TravelAILogoNew.png")),
            ),
            Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Password'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ]
                )
            ),

            Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 130,
                  height: 50,
                  child:  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_isLoginForm) {
                          _login();
                        } else {
                          _signUp();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                    ), child: Text(
                    _isLoginForm ? 'Login' : 'Sign Up',
                    style: TextStyle(fontSize: 20),
                  ),
                  ),
                )
            ),
            SizedBox(height: 12.0),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoginForm = !_isLoginForm;
                });
              },
              child: Text(
                _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),),
    );
  }

  void _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;
      print('Login successful. User: ${user?.email}');

      // Navigate to HomePage upon successful login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePageUI()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed.. Please try again. Error: $e .'),
        ),
      );

      // Navigate back to LoginSignUp upon failed login
      Navigator.pop(context);
    }
  }

  void _signUp() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;
      print('Sign up successful. User: ${user?.email}');

      // Navigate to HomePage upon successful signup
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePageUI()),
      );
    } catch (e) {
      // Show error message using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign up failed. Please try again. Error: $e .'),
        ),
      );
    }
  }
}

