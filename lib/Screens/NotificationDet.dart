import 'package:flutter/material.dart';
import 'package:apc_erp/Services/AppConstants.dart';
//import 'package:sls_b/Screens/StoreMapPage.dart';

class NotificationDet extends StatefulWidget {
  final String NotificationId;
  final String NotificationTitle;
  final String NotificationContent;
  final String NotificationDesc;
  final String AddDate;

  NotificationDet({
    this.NotificationId,
    this.NotificationTitle,
    this.NotificationDesc,
    this.NotificationContent,
    this.AddDate,
  });

  @override
  _NotificationDetState createState() => _NotificationDetState();
}

class _NotificationDetState extends State<NotificationDet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void showTabDet(int TabIndex) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: TextStyle(
              fontFamily: 'Montserrat', fontSize: AppConstants.smallFontSize),
        ),
        backgroundColor: AppConstants.AppColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Card(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.NotificationTitle.toString(),
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.AddDate.toString(),
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 10,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.NotificationDesc.toString(),
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Tab1 extends StatefulWidget {
  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  @override
  Widget build(BuildContext context) {
    //return Container();

    return Text('this is tab 1');
  }
}

class Tab2 extends StatefulWidget {
  @override
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  @override
  Widget build(BuildContext context) {
    return Text('this is tab 2');
  }
}

class Tab3 extends StatefulWidget {
  @override
  _Tab3State createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {
  @override
  Widget build(BuildContext context) {
    return Text('this is tab 3');
  }
}
