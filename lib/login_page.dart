import 'package:chat_app/chat_page.dart';
import 'package:chat_app/utils/spaces.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/utils/textfield_styles.dart';
import 'package:chat_app/widgets/login_text_field.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  void login(context) {
    if (_formkey != null && _formkey.currentState!.validate()) {
      print(userNameController.text);
      print(passwordController.text);
      Navigator.pushReplacementNamed(context, '/chat',
          arguments: '${userNameController.text}');
      print("Login Successful");
    } else {
      print("Not Successful");
    }
  }

  final Uri _url = Uri.parse("https://poojabhaumik.com");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Let's sign you in",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              verticalSpacing(5.0),
              Text(
                "Welcome back!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.blueGrey,
                ),
              ),
              verticalSpacing(10.0),
              // Image.network(
              //   'https://3009709.youcanlearnit.net/Alien_LIL_131338.png',
              //   height: 200,
              // ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    LoginTextField(
                      hasAsterisks: false,
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            value.length < 5) {
                          return "Your username should be more than 5 characters";
                        } else if (value != null && value.isEmpty) {
                          return "Please type your username";
                        }
                        return null;
                      },
                      controller: userNameController,
                      hintText: 'Username',
                    ),
                    verticalSpacing(10.0),
                    LoginTextField(
                      hasAsterisks: true,
                      controller: passwordController,
                      hintText: 'Password',
                    ),
                    verticalSpacing(4.0),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => login(context),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (!await launchUrl(_url)) {
                    throw 'Could not launch this!';
                  }
                },
                child: Column(
                  children: [
                    Text('Find us on'),
                    Text("$_url"),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialMediaButton.twitter(
                      color: Colors.blue,
                      url: "https://twitter.com/pooja_bhaumik"),
                  SocialMediaButton.linkedin(
                      color: Colors.blue,
                      url: "https://linkedin.com/in/pooja26"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
