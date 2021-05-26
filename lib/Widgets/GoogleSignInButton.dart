import 'package:apc_erp/Screens/LandingPage.dart';
import 'package:apc_erp/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
//import 'package:flutterfire_samples/screens/user_info_screen.dart';
//import 'package:flutterfire_samples/utils/authentication.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  void setSharedPrefValue(String PairKey, String PairValue) async {
    try {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      prefs.setString(PairKey, PairValue.toString());
    } catch (err) {
      SharedPreferences.setMockInitialValues({});
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      prefs.setString(PairKey, PairValue);
    }
    //showToast('init shared');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                print('click sign in');
                setState(() {
                  _isSigningIn = true;
                });
                print('tunggu');
                User user =
                    await Authentication.signInWithGoogle(context: context);
                print(' user 123');
                print('You are logged in as ' + user.displayName.toString());

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  print('berjaya');
                  setSharedPrefValue('UserEmail', user.email);
                  setSharedPrefValue('UserDisplayName', user.displayName);
                  setSharedPrefValue('UserPhotoUrl', user.photoURL);
                  Navigator.pushNamedAndRemoveUntil(
                      context, LandingPage.routeName, (route) => false);

                  /*
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => UserInfoScreen(
                        user: user,
                      ),
                    ),
                  );
                  */
                } else {
                  print('gagal');
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/google_logo.png"),
                      height: 35.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
