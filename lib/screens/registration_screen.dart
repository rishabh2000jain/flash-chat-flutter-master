import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/widgets/text_field_widget.dart';
import 'package:flash_chat/widgets/button_widget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email, password;
  TextEditingController controller = TextEditingController();
  bool showSpinner = false;

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
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
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
                  password = value;
                  //Do something with the user input.
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
                text: 'Register',
                buttonColor: Colors.blueAccent,
                onPress: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    if (email != null && password != null) {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      controller.clear();
                      if (newUser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    setState(() {
                      showSpinner = false;
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
