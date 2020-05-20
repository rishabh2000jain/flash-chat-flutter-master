import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/widgets/text_field_widget.dart';
import 'package:flash_chat/widgets/button_widget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email, password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  bool showSpinner = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration:
                    KTextDecorationStyle.copyWith(hintText: 'Enter your email'),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                controller: controller,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: KTextDecorationStyle.copyWith(
                    hintText: 'Enter your password'),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              ButtonWidget(
                text: 'Log In',
                buttonColor: Colors.lightBlueAccent,
                onPress: () async {
                  controller.clear();
                  try {
                    if (email.isNotEmpty && password.isNotEmpty) {
                      setState(() {
                        showSpinner = true;
                      });
                      final result = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (result != null) {
                        setState(() {
                          showSpinner = false;
                        });
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    }
                    setState(() {
                      showSpinner  = false;
                    });
                  } catch (e) {
                    setState(() {
                      showSpinner=false;
                    });
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
