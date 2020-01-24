import 'package:flutter/material.dart';
import 'colors.dart';
import 'phoneVerification.dart';
import 'model/auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _usernameController.text = '9638113178';
    return Scaffold(
      backgroundColor: Color(0xFF80cbc4),
      body: Builder(
        builder: (context) => Column(
          // padding: EdgeInsets.symmetric(horizontal: 24.0),
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // SizedBox(height: 250.0),

            Image.asset(
              'assets/images/logo-full.png',
              height: 70,
            ),

            SizedBox(height: 50.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0)),
                child: Container(
                  // height: 400,
                  decoration: BoxDecoration(
                    // border: Border.all(),
                    color: tcBackgroundWhite,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(height: 12.0),
                        AccentColorOverride(
                          color: tcDarkBlue,
                          child: TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Phone',
                            ),
                          ),
                        ),
                        // spacer
                        SizedBox(height: 50.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FloatingActionButton(
                              // mini: true,
                              onPressed: () {
                                // Auth().handlePhone('+91' + _usernameController.text, context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PhoneVerificationPage(phoneNumber: '+91' + _usernameController.text),
                                  ),
                                );
                              },
                              backgroundColor: tcDarkBlue,
                              child: Icon(Icons.arrow_forward),
                            )
                          ],
                        ),

                        SizedBox(height: 50.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
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
