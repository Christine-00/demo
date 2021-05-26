import 'dart:convert';
import 'package:apc_erp/Models/NotificationDetModel.dart';
import 'package:apc_erp/Screens/NotificationDet.dart';
import 'package:apc_erp/Services/AppConstants.dart';
import 'package:apc_erp/Widgets/AlertTemplate1Widget.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:sls_b/Services/notificationHelper.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String _message = '';
  String NotificationTitle = '';
  String NotificationContent = '';
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool IsInternetAvailable = true;
  //Connectivity connectivity = Connectivity();
  //final String uri = 'http://sls.b.alphaclick.com.my/PHPFiles/getNotificationList.php';
  //NotificationList notificationList = NotificationList();
  NotificationList notificationList = NotificationList();

  Future<String> getNotificationListData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ClientId = prefs.getString('ClientId');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    Map<String, dynamic> bodyParam = {
      'client_id': ClientId.toString(),
    };

    final encoding = Encoding.getByName('utf-8');

    Response response = await post(

      Uri.parse(AppConstants.NotificationGetUrl.toString()),
      body: bodyParam,
    );
    var memberMap = json.decode(response.body);
    print(memberMap.toString());
    if (memberMap['status'] == 'success') {
      setState(() {
        //customerList = CustomerList.fromJson(memberMap['data']);
        notificationList = NotificationList.fromJson(memberMap['data']);
      });
    }
  }

  /*
  Future<List<NotificationDetModel>> _fetchUsers() async {
    var response = await http.get(uri);
    print(uri);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final items =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      List<NotificationDetModel> listOfUsers =
          items.map<NotificationDetModel>((json) {
        print(json);
        return NotificationDetModel.fromJson(json);
      }).toList();

      return listOfUsers;
    } else {
      throw Exception('Failed to load internet');
    }
  }
*/

  @override
  void initState() {
    super.initState();
    CheckConnection();
  }

  void ShowNoInternetAlert(String TitleMsg, String ContentMsg,
      String ResponseMsg, String MsgStatus) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: AutoSizeText(
                      TitleMsg.toString(),
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: AppConstants.smallFontSize),
                      minFontSize: 10.0,
                      stepGranularity: 1.0,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  SizedBox(height: 5),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.wifi,
                      color: Colors.red,
                      size: 90,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontSize: AppConstants.smallFontSize),
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
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      //Navigator.pushNamed(context, SignInPage.routeName);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        color: MsgStatus == 'PASS' ? Colors.green : Colors.red,
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
        });
  }

  Future<String> CheckConnection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String member_code = prefs.getString('member_code');

    getNotificationListData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppConstants.ScaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Notification',
          style: TextStyle(fontSize: AppConstants.smallFontSize),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Visibility(
              visible: IsInternetAvailable,
              child: Expanded(
                  child: new ListView.builder(
                      itemCount: (notificationList == null ||
                              notificationList.notification == null ||
                              notificationList.notification.length == 0)
                          ? 0
                          : notificationList.notification.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return GestureDetector(
                          onTap: () {
                            print('content is');
                            print(notificationList
                                .notification[index].notification_desc);

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NotificationDet(
                                NotificationId: notificationList
                                    .notification[index].notification_id
                                    .toString(),
                                NotificationTitle: notificationList
                                    .notification[index].notification_title,
                                NotificationContent: notificationList
                                    .notification[index].notification_content,
                                NotificationDesc: notificationList
                                    .notification[index].notification_desc,
                                AddDate: notificationList
                                    .notification[index].add_date,
                              );
                            }));

                            //print('all right');
                            /*
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {

                            return StoreDet(
                              storeName: rewardList.reward[index]
                                  .store_group_name, // user.store_name,
                              storeAttName:
                                  rewardList.reward[index].store_group_name,
                              storeLat:
                                  rewardList.reward[index].store_group_name,
                              storeLng:
                                  rewardList.reward[index].store_group_name,
                            );

                          }));
                          */
                          },
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            notificationList.notification[index]
                                                .notification_title,
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),

                                      /*
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          notificationList.notification[index]
                                              .notification_title,
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 15,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    */
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            notificationList
                                                .notification[index].add_date,
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
            ),
            Visibility(
              visible: !IsInternetAvailable,
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AlertTemplate1Widget(context,
                        StrTitle: 'NO CONNECTION',
                        StrText:
                            'Oops! Looks like you are offline.\n\nPlease check your internet connection'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 12.0,
                        child: MaterialButton(
                          onPressed: () {
                            CheckConnection();
                          },
                          child: Text(
                            'Refresh',
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      /*
      body: FutureBuilder<List<NotificationDetModel>>(
        future: _fetchUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data
                .map((user) => ListTile(
                      title: Text(user.notification_title),
                      subtitle: Text(user.notification_content),
                    ))
                .toList(),
          );
        },
      ),
      */
    );
  }
}
