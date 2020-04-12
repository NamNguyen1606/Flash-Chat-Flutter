import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/ButtonWidget.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    'Flash Chat',
                    style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.yellowAccent.shade700),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            ButtonWidget(
              text: 'Login',
              destination: LoginScreen.id,
              color: Colors.lightBlueAccent,
            ),
            ButtonWidget(
              text: 'Register',
              destination: RegistrationScreen.id,
              color: Colors.lightBlue,
            ),
          ],
        ),
      ),
    );
  }
}
