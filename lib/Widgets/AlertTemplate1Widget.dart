import 'package:apc_erp/Services/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Container AlertTemplate1Widget(
  context,
  //{bool isAppTitle, String strTitle, bool isVisibleBackButton}) {
  {
  String StrTitle,
  String StrText,
  int intRowCnt = 1,
}) {
  return Container(
    //color: Colors.green,
    width: MediaQuery.of(context).size.width,
    child: Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      //mainAxisSize: MainAxisSize.min,

      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: AutoSizeText(
            StrTitle.toString(),
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
        SizedBox(height: 5),
        Container(
          width: MediaQuery.of(context).size.width,
          child: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.wifi,
              color: Colors.red,
              size: 90,
            ),
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
                      StrText.toString(),
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
      ],
    ),
  );

  /*
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AutoSizeText(
            StrTitle.toString(),
            textScaleFactor: 1.0,
            style: TextStyle(
                color: Colors.grey[500],
                fontFamily: 'Ubuntu',
                fontSize: AppConstants.tinyFontSize),
            minFontSize: 10.0,
            stepGranularity: 1.0,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          AutoSizeText(
            StrText.toString(),
            textScaleFactor: 1.0,
            style: TextStyle(
                color: Colors.blue[600],
                fontFamily: 'Montserrat',
                fontSize: AppConstants.smallFontSize),
            minFontSize: 10.0,
            stepGranularity: 1.0,
            maxLines: intRowCnt,
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Divider(color: Colors.grey[300]),
          ),
        ],
      ),
    ),
  );
  */
}
