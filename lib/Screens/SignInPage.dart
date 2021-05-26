import 'dart:convert';
//import 'dart:html';
import 'package:apc_erp/Screens/HomePage.dart';
import 'package:apc_erp/Services/AppConstants.dart';
import 'package:apc_erp/Screens/LandingPage.dart';
import 'package:apc_erp/Widgets/GoogleSignInButton.dart';
import 'package:apc_erp/authentication.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

//import 'package:apc_erp/Screens/ConnectivityDemo.dart';
//import 'package:apc_erp/Screens/LandingPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:apc_erp/Services/AppConstants.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:async';

//import 'package:flutter/material.dart';
//import 'package:flutterfire_samples/res/custom_colors.dart';
//import 'package:flutterfire_samples/utils/authentication.dart';
//import 'package:flutterfire_samples/widgets/google_sign_in_button.dart';

//import 'package:connectivity/connectivity.dart';

import 'package:flutter/widgets.dart';
//import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class SignInPage extends StatefulWidget {
  static final String routeName = 'signInPageRoute';

  @override
  _SignInPageState createState() => _SignInPageState();
}

//class _SignInPageState extends State<SignInPage> with WidgetsBindingObserver {
class _SignInPageState extends State<SignInPage> {
  bool _isCnnAvailable = false;
  bool _isInAsyncCall = false;
  //Connectivity connectivity = Connectivity();
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    //sharedPrefInit();
    super.initState();
    //WidgetsBinding.instance.addObserver(this);

    _emailController.text = 'EzAppAdmin@gmail.com';
    //_emailController.text = '';
    _passwordController.text = '123456';
    //_passwordController.text = '';
    CheckLoginStatus();
  }

  void showToast(String msg) {
    Toast.show(msg.toString(), context,
        duration: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.green,
        gravity: Toast.CENTER);
  }

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
  void dispose() {
    //WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    //print('disposed');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //print('logged in');

    }

    /*
    if (state == AppLifecycleState.resumed) {
      // user returned to our app
    } else if (state == AppLifecycleState.inactive) {
      // app is inactive
    } else if (state == AppLifecycleState.paused) {
      // user is about quit our app temporally
    } else if (state == AppLifecycleState.suspending) {
      // app suspended (not used in iOS)
    }
    */
  }

  void CheckLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('UserID') == null) {
      //print('not yet login');
    } else if (prefs.getString('UserID') != '') {
      //print('already login');
      //print(prefs.getString('UserEmail'));
      //print(prefs.getString('UserID'));
      //print(prefs.getString('UserName'));

    } else {
      //print('not yet login');
    }
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> loginFailAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign In Failed'),
          content: const Text(
              'The email and password you entered did not match our records.\n\nPlease double-check and try again.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void makePostRequest() async {
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Map<String, dynamic> bodyParam = {
      'user_email': _emailController.text,
      'pwd': _passwordController.text,
      'username': _emailController.text,
    };

    setState(() {
      _isInAsyncCall = true;
    });

    //showToast('33333');
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      Uri.parse(AppConstants.AdminSigninURL),
      body: bodyParam,
    );

    var memberMap = json.decode(response.body);

    /*
    Response response = await post(
      AppConstants.SalesTransMasterGetUrl,
      body: bodyParam,
    );
    var memberMap = json.decode(response.body);
    print(memberMap);

    */

    //showToast('44444');
    setState(() {
      _isInAsyncCall = false;
    });

    if (json.decode(response.body)['status'] == 'success') {
      setSharedPrefValue('UserEmail',
          json.decode(response.body)['data'][0]['user_email'].toString());

      setSharedPrefValue('AdminID',
          json.decode(response.body)['data'][0]['user_row_id'].toString());

      setSharedPrefValue('UserName',
          json.decode(response.body)['data'][0]['user_name'].toString());

      setSharedPrefValue('ClientId',
          json.decode(response.body)['data'][0]['client_id'].toString());

      Navigator.pushNamed(context, LandingPage.routeName);

      /*


      //showToast(response.body.toString());
      _emailController.text = response.body[0].toString();

      //prefs.setString('UserID', json.decode(response.body)['data'][0]['user_id'].toString());

*/
      //Navigator.pushNamed(context, OtherPage.routeName);
    } else {
      //_isInAsyncCall = false;

      //showToast('88888');
      loginFailAlert(context);
    }
  }

  String getConnectionValue(var connectivityResult) {
    String status = '';
    /*
    switch (connectivityResult) {
      case ConnectivityResult.mobile:
        status = 'Mobile';
        break;
      case ConnectivityResult.wifi:
        status = 'Wi-Fi';
        break;
      case ConnectivityResult.none:
        status = 'None';
        break;
      default:
        status = 'None';
        break;
    }
    return status;
    */
  }

  void ShowAlertMsg(
      String TitleMsg, String ContentMsg, String ResponseMsg) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        TitleMsg.toString(),
                        style: TextStyle(fontSize: AppConstants.smallFontSize),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Container(
                            //color: Colors.blue,
                            height: 180,
                            child: Align(
                              alignment: Alignment
                                  .center, // Align however you like (i.e .centerRight, centerLeft)

                              child: AutoSizeText(
                                ContentMsg.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontSize: AppConstants.regularFontSize),
                                minFontSize: 10.0,
                                stepGranularity: 1.0,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, SignInPage.routeName);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        ResponseMsg.toString(),
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );

          /*
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              height: 300.0,
              width: 300.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Account Submitted !!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Text('asdf'),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Okay, proceed to log in.",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),

                  */ /*
                  Align(
                    // These values are based on trial & error method
                    alignment: Alignment(1.05, -1.05),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  */ /*
                ],
              ),
            ),
          );
*/
        });
  }

  void checkConnectivity() async {
    //var connectivityResult = await connectivity.checkConnectivity();
    //var conn = getConnectionValue(connectivityResult);

    makePostRequest();
    /*
    if (conn == 'None') {
      ShowAlertMsg(
          'NO CONNECTION',
          'Oops! Looks like you are offline.\n\nPlease check your internet connection.',
          'DISMISS');
    } else {
      makePostRequest();
    }
    */
  }

  void _login() async {
    checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //resizeToAvoidBottomInset: false,
      //resizeToAvoidBottomPadding: false,

      //  body: SingleChildScrollView(
      body: SafeArea(
        child: WillPopScope(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  AppConstants.AppLogoUrl.toString(),
                  width: MediaQuery.of(context).size.width / 3 * 2,
                  fit: BoxFit.fitHeight,
                ),

                /*
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10
                            //AppConstants.smallPadding,
                            //AppConstants.smallPadding,
                            //AppConstants.smallPadding,
                            //AppConstants.tinyPadding,
                            ),
                        child: TextFormField(
                          //initialValue: 'alvinchchoo@hotmail.com',
                          decoration: new InputDecoration(
                            labelText: "Enter Email",
                            hintText: 'Please keyin your email',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: new BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),

                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: (value) {
                            if (value.isEmpty || !value.contains("@")) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          //initialValue: '1qazxsw23edc',
                          decoration: new InputDecoration(
                            labelText: "Password",
                            hintText: 'Please keyin your password',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: new BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty || value.length < 6) {
                              return "Enter a valid password (6 or more characters)";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                */

                SizedBox(
                  height: 60,
                ),
                FutureBuilder(
                  future: Authentication.initializeFirebase(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error initializing Firebase');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return GoogleSignInButton();
                    }
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        //CustomColors.firebaseOrange,
                        Colors.orange,
                      ),
                    );
                  },
                ),
                /*
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: SizedBox(
                    width: double.infinity,
                    //height: MediaQuery.of(context).size.height / 12.0,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LandingPage.routeName);
                      },
                      child: Text(
                        'Log In with Gmail',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontSize: AppConstants.regularFontSize),
                      ),
                      //color: Color(0xff461e1e),
                      color: Color(0xff8D1735),
                      height: MediaQuery.of(context).size.height / 15,
                      shape: RoundedRectangleBorder(
                        //borderRadius: BorderRadius.circular(AppConstants.regularCornerRadius),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: SizedBox(
                    width: double.infinity,
                    //height: MediaQuery.of(context).size.height / 12.0,
                    child: MaterialButton(
                      onPressed: () {
                        //_login();
                        Navigator.pushNamed(context, LandingPage.routeName);
                      },
                      child: Text(
                        'Log In with Facebook',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontSize: AppConstants.regularFontSize),
                      ),
                      //color: Color(0xff461e1e),
                      color: Color(0xff8D1735),
                      height: MediaQuery.of(context).size.height / 15,
                      shape: RoundedRectangleBorder(
                        //borderRadius: BorderRadius.circular(AppConstants.regularCornerRadius),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                */
              ],
            ),
          ),
          onWillPop: () async => false,
        ),
      ),
    );
  }
}
