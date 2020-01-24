import 'package:flutter/material.dart';
import 'colors.dart';
import 'model/auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // TODO: Add text editing controllers (101)
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _usernameController.text = 'varu.sihara13@gmail.com';
    _passwordController.text = 'asdasd';
    return Scaffold(
      body: Builder(
        builder: (context) => Container(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(height: 250.0),
              Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo-full.png',
                    height: 70,
                  ),
                  // SizedBox(height: 16.0),
                  // Text('Tinosaur'),
                ],
              ),
              SizedBox(height: 30.0),
              // TODO: Wrap Username with AccentColorOverride (103)
              // TODO: Remove filled: true values (103)
              // TODO: Wrap Password with AccentColorOverride (103)
              // TODO: Add TextField widgets (101)
              // [Name]
              AccentColorOverride(
                color: tcDarkBlue,
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              ),
              // spacer
              SizedBox(height: 12.0),
              // [Password]
              AccentColorOverride(
                color: tcDarkBlue,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text('Forgot password?'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                    onPressed: () {
                      Auth().forgotPassword(_usernameController.text);
                    },
                  ),
                  RaisedButton(
                    child: Text('Register'),
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                    onPressed: () {
                      Auth()
                          .handleEmailSignUp(_usernameController.text,
                              _passwordController.text)
                          .then((FirebaseUser user) {
                        print(user);
                        if (user != null) {
                          final snackBar =
                              SnackBar(content: Text('Successful SignUp.'));
                          Scaffold.of(context).showSnackBar(snackBar);
                          // Show the next page (101)
                          Navigator.pop(context);
                        }
                      }).catchError((e) {
                        final snackBar = SnackBar(content: Text(e));
                        Scaffold.of(context).showSnackBar(snackBar);
                        // print(e);
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              RaisedButton(
                child: Text('Google Signin'),
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0))),
                onPressed: () {
                  // TODO: Show the next page (101)
                  // Navigator.pop(context);

                  Auth().handleGoogleSignIn().then((FirebaseUser user) {
                    print(user);
                    final snackBar =
                        SnackBar(content: Text('Successful logging in.'));
                    Scaffold.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                  }).catchError((e) {
                    final snackBar =
                        SnackBar(content: Text('Error logging in.'));
                    Scaffold.of(context).showSnackBar(snackBar);
                    print(e);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: Add AccentColorOverride (103)
class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
        accentColor: color,
        brightness: Brightness.dark,
      ),
    );
  }
}
