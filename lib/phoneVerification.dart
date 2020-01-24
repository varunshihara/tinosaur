import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tinosaur/tinohome.dart';
import 'colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class PhoneVerificationPage extends StatefulWidget {
  PhoneVerificationPage({this.phoneNumber});
  final phoneNumber;
  @override
  _PhoneVerificationPageState createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  String phoneNumber;
  String verificationId;
  int forceResendingToken;
  String _authCredentiall =
      '{jsonObject: {"zza":"AM5PThB_YYgM_En0q0jOa54djphOF4j5dPQtbqTDM53DGxe7fz2-H72zWURN_bMxREENvpKReUeaECN5_r6QEgZ4gaLPuRZdfDE7bQIF7tyxAbDWs0zqbs2JgeZ9lWcZTLDpISGN1yXMPl1BJG-uRAQiT7q5Ky9MgP5Y9o-jsr65PDLa797Zxp8NG2P-aQ8v5v09FuhwPXI870IkrTxWVhOXjMmEikoF1s-yLGwOZtgcLSSn1wC0icA","zzb":"263759","zzc":false,"zze":true}}';
  final _verificationCodeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneNumber = widget.phoneNumber;
    handlePhone(phoneNumber);
    // print(widget.phoneNumber);
  }

  Future<Null> handlePhone(String phone) async {
    // print(email + password);
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: Duration(seconds: 120),
          forceResendingToken: 3,
          verificationCompleted: (AuthCredential authCredential) {
            print(authCredential);
            _authCredentiall = authCredential.toString();
            print(jsonDecode(_authCredentiall));
            // _verificationCodeController.text =                jsonDecode(authCredentiall)['jsonObject']['zzb'];
            // Navigator.pushReplacementNamed(lcontext, '/home');
          },
          verificationFailed: (AuthException e) {
            print('Error : ' + e.message);
            // Navigator.pushReplacementNamed(lcontext, '/home');
          },
          codeSent: (String verificationId, [int forceResendingToken]) {
            this.verificationId = verificationId;
            this.forceResendingToken = forceResendingToken;
            print('verificationId - ' +
                verificationId +
                ', forceResendingToken - ');
            print(forceResendingToken);
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            print('codeAutoRetrievalTimeout');
          });
      print("verification code sent to - " + phone);
      // return user;
    } on PlatformException catch (e) {
      // if (e.message == 'ERROR_EMAIL_ALREADY_IN_USE'){
        print(e.message);
      // }
      // throw e.message;
    } catch (error) {
      // List<String> errors = error.toString().split(',');
      print("Error: " + error.message);
      // throw error.message;
    }
  }

  Future<String> verifyCode(String code) async {
    // print(email + password);
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: verificationId, smsCode: code);
      final AuthResult user = await _auth.signInWithCredential(credential);
      final FirebaseUser currentUser = await _auth.currentUser();
      // assert(user.uid == currentUser.uid);
      print(user.user.phoneNumber);
      print(currentUser.phoneNumber);
      return 'true';
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_VERIFICATION_CODE':
          {
            return('Verification code invalid.');
          }
          break;
        default:
          {
            print('Platform e - ' + e.code);
            return('Platform e - ' + e.message);
          }
      }
    } catch (error) {
      // List<String> errors = error.toString().split(',');
      // print("Error: " + error);
      return('just e - ' + error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(jsonDecode(authCredentiall)['jsonObject']);
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
                            controller: _verificationCodeController,
                            decoration: InputDecoration(
                              labelText: 'Verification Code',
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
                                print('pressed!');
                                verifyCode(_verificationCodeController.text)
                                    .then((String msg) async {
                                  print(msg);
                                  if (msg != 'true') {
                                    Scaffold.of(context).showSnackBar(
                                        SnackBar(content: Text(msg)));
                                  } else {
                                    Navigator.pop(context);
                                  }
                                });
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
