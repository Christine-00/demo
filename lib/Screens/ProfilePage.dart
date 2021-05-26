import 'dart:io';
//import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:apc_erp/Screens/ChangePasswordPage.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:apc_erp/Screens/SignInPage.dart';
import 'package:apc_erp/Services/AppConstants.dart';
//import 'package:apc_erp/Models/Accounts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class ProfilePage extends StatefulWidget {
  static final String routeName = 'ProfilePageRoute';
  ProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //user_id = int.parse(prefs.getString('UserID')).toInt();

  //SharedPreferences prefs = await SharedPreferences.getInstance();

  //SharedPreferences prefs = await SharedPreferences.getInstance();
  //SharedPreferences.setMockInitialValues({});

  //String epp_url = prefs.getString('epp_url').toString();
  //String epp_type = prefs.getString('epp_type').toString();
  //  SharedPreferences prefs = await SharedPreferences.getInstance();

  //SharedPreferences prefs = await SharedPreferences.getInstance();

  String epp_url;
  String epp_type;
  String tnc_url;
  String tnc_type;
  String faq_url;
  String faq_type;
  String privacy_policy_url;
  String privacy_policy_type;

  String pathPDF = '';
  String _message = '';
  String NotificationTitle;
  String NotificationContent;
  //Notifications _notifications;

  //StreamSubscription<NotificationEvent> _subscription;

  bool IsGuestLogin = true;
  //ProdCatList prodCatList = ProdCatList();
  final formatter = new NumberFormat("###,###,##0.00", "en_US");
  final formatter_1 = new NumberFormat("###,###,##0", "en_US");
  String UserID;
  String UserName;
  String AttName;
  bool isRegistered;

  bool Tab1Visible = true;
  bool Tab2Visible = false;
  bool Tab3Visible = false;
  //PromotionList promotionList = PromotionList();
  String barcode = "";
  double TotalPaid = 0.00;

  TabController controller;

  void getPdfDoc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    tnc_type = prefs.getString('tnc_type').toString();
    tnc_url = prefs.getString('tnc_url').toString();

    epp_url = prefs.getString('epp_url').toString();
    epp_type = prefs.getString('epp_type').toString();

    faq_url = prefs.getString('faq_url').toString();
    faq_type = prefs.getString('faq_type').toString();

    privacy_policy_url = prefs.getString('privacy_policy_url').toString();
    privacy_policy_type = prefs.getString('privacy_policy_type').toString();

    //String faq_url = 'http://members.sec.com.my/Epp.pdf?ID=V1';
    //String faq_type = 'PDF';
    //String privacy_policy_url = 'http://members.sec.com.my/Epp.pdf?ID=V1';
    //String privacy_policy_type = 'PDF';

    //String epp_url = 'http://members.sec.com.my/Epp.pdf?ID=V1';
    //String epp_type = 'PDF';

    //String tnc_url = 'http://members.sec.com.my/Epp.pdf?ID=V1';
    //String tnc_type = 'PDF';
  }

  void getLoginType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String member_code = prefs.getString('member_code');

    setState(() {
      (member_code == 'GUEST') ? IsGuestLogin = true : IsGuestLogin = false;
    });
  }

  @override
  void initState() {
    super.initState();

    isRegistered = false;

    Tab1Visible = true;
    Tab2Visible = false;
    Tab3Visible = false;
    UserID = '';
    UserName = '';
    //getStoreListData();
    //getProdCatList();
    getLoginType();
    getPdfDoc();
  }

  ViewTnC() async {
    String url;

    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //user_id = int.parse(prefs.getString('UserID')).toInt();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (tnc_type.toString() == 'WEB') {
      url = tnc_url.toString();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  ViewPrivacyPolicy() async {
    String url;

    if (privacy_policy_type.toString() == 'WEB') {
      url = privacy_policy_url.toString();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else if (privacy_policy_type.toString() == 'PDF') {
      url = privacy_policy_url.toString();
    }
  }

  ViewFaqs() async {
    String url;

    if (faq_type.toString() == 'WEB') {
      url = faq_url.toString();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  ViewEpp() async {
    String url;

    print('epp_url : ' + epp_url.toString());
    print('epp_type : ' + epp_type.toString());

    if (epp_type.toString() == 'WEB') {
      url = epp_url.toString();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  void _memberSignout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('UserID', '');

    Navigator.pushNamed(context, SignInPage.routeName);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void GoToMyProfile() async {
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String member_code = prefs.getString('member_code');

      if (member_code.toString() == 'GUEST') {
        print("not log in. cant show page");
      } else {
        //Navigator.pushNamed(context, MyProfilePage.routeName);
      }
    }

    void showTabDet(int TabIndex) {
      print(TabIndex);

      setState(() {
        if (TabIndex == 0) {
          Tab1Visible = true;
          Tab2Visible = false;
          Tab3Visible = false;
        } else if (TabIndex == 1) {
          Tab1Visible = false;
          Tab2Visible = true;
          Tab3Visible = false;
        } else if (TabIndex == 2) {
          Tab1Visible = false;
          Tab2Visible = false;
          Tab3Visible = true;
        }
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Setting',
            style: TextStyle(fontSize: AppConstants.smallFontSize),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment(0.2, 0.6),
                  child: Container(
                    height: 3,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    /*
                                    Navigator.push(context, CupertinoPageRoute(builder: (context) {return ExtWarPurchasePage();
                                    }));
*/
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      FaIcon(
                                        FontAwesomeIcons.award,
                                        color: Colors.blue[800],
                                        size: 24,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text(
                                          'e-Warranty',
                                          textScaleFactor: 1.0,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Montserrat',
                                              fontSize:
                                                  AppConstants.tinyFontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    ViewFaqs();
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      FaIcon(
                                        FontAwesomeIcons.fileContract,
                                        color: Colors.blue[800],
                                        size: 24,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text(
                                          'FAQs',
                                          textScaleFactor: 1.0,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Montserrat',
                                              fontSize:
                                                  AppConstants.tinyFontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    ViewTnC();
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      FaIcon(
                                        FontAwesomeIcons.fileContract,
                                        color: Colors.blue[800],
                                        size: 24,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text(
                                          'Terms of Use',
                                          textScaleFactor: 1.0,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Montserrat',
                                              fontSize:
                                                  AppConstants.tinyFontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    ViewPrivacyPolicy();
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      FaIcon(
                                        FontAwesomeIcons.fileContract,
                                        color: Colors.blue[800],
                                        size: 24,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text(
                                          'Privacy Policy',
                                          textScaleFactor: 1.0,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Montserrat',
                                              fontSize:
                                                  AppConstants.tinyFontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    //  _memberSignout();
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      FaIcon(
                                        FontAwesomeIcons.signOutAlt,
                                        color: Colors.blue[800],
                                        size: 24,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text(
                                          'Sign Out',
                                          textScaleFactor: 1.0,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Montserrat',
                                              fontSize:
                                                  AppConstants.tinyFontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  void showTabDet(int TabIndex) {
    print(TabIndex);

    setState(() {
      if (TabIndex == 0) {
        Tab1Visible = true;
        Tab2Visible = false;
        Tab3Visible = false;
        //TabMemberProfileVisible = true;
        //TabAccountListVisible = false;
      } else if (TabIndex == 1) {
        Tab1Visible = false;
        Tab2Visible = true;
        Tab3Visible = false;
        //TabMemberProfileVisible = false;
        //TabAccountListVisible = true;
      } else if (TabIndex == 2) {
        Tab1Visible = false;
        Tab2Visible = false;
        Tab3Visible = true;
        //TabMemberProfileVisible = false;
        //TabAccountListVisible = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: TextStyle(fontSize: AppConstants.smallFontSize),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async => true,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment(0.2, 0.6),
                  child: Container(
                    height: 3,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: [
                                Visibility(
                                  visible: !IsGuestLogin,
                                  child: MaterialButton(
                                    onPressed: () {
                                      GoToMyProfile();
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        FaIcon(
                                          FontAwesomeIcons.user,
                                          color: Colors.blue[800],
                                          size: 24,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          child: AutoSizeText(
                                            'My Profile',
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Montserrat',
                                                fontSize:
                                                    AppConstants.tinyFontSize),
                                            minFontSize:
                                                AppConstants.tinyFontSize - 3,
                                            stepGranularity: 1.0,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: !IsGuestLogin,
                                  child: MaterialButton(
                                    onPressed: () {
                                      //Navigator.pushNamed(context, ChangePasswordPage.routeName);
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        FaIcon(
                                          FontAwesomeIcons.key,
                                          color: Colors.blue[800],
                                          size: 24,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          child: Text(
                                            'Change Password',
                                            textScaleFactor: 1.0,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Montserrat',
                                                fontSize:
                                                    AppConstants.tinyFontSize),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: MaterialButton(
                                    onPressed: () {
                                      //Navigator.pushNamed(context, InvoicePage.routeName);
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        FaIcon(
                                          FontAwesomeIcons.receipt,
                                          color: Colors.blue[800],
                                          size: 24,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          child: Text(
                                            'Official Receipt',
                                            textScaleFactor: 1.0,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Montserrat',
                                                fontSize:
                                                    AppConstants.tinyFontSize),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    ViewFaqs();
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      FaIcon(
                                        FontAwesomeIcons.fileContract,
                                        color: Colors.blue[800],
                                        size: 24,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text(
                                          'FAQs',
                                          textScaleFactor: 1.0,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Montserrat',
                                              fontSize:
                                                  AppConstants.tinyFontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    ViewTnC();
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      FaIcon(
                                        FontAwesomeIcons.fileContract,
                                        color: Colors.blue[800],
                                        size: 24,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text(
                                          'Terms of Use',
                                          textScaleFactor: 1.0,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Montserrat',
                                              fontSize:
                                                  AppConstants.tinyFontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    ViewPrivacyPolicy();
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      FaIcon(
                                        FontAwesomeIcons.fileContract,
                                        color: Colors.blue[800],
                                        size: 24,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text(
                                          'Privacy Policy',
                                          textScaleFactor: 1.0,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Montserrat',
                                              fontSize:
                                                  AppConstants.tinyFontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    _memberSignout();
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      FaIcon(
                                        FontAwesomeIcons.signOutAlt,
                                        color: Colors.blue[800],
                                        size: 24,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text(
                                          'Sign Out',
                                          textScaleFactor: 1.0,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Montserrat',
                                              fontSize:
                                                  AppConstants.tinyFontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
