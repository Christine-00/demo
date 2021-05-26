import 'package:apc_erp/Models/Package.dart';
import 'package:apc_erp/Models/PackageAtt.dart';
import 'package:flutter/material.dart';
//import 'package:apc_erp/Screens/ProductListPage.dart';
import 'package:apc_erp/Services/AppConstants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
//import 'package:apc_erp/Models/ProductImage.dart';
//import 'package:apc_erp/Widget/HeaderWidget.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'dart:async';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PackageDetPage extends StatefulWidget {
  static final String routeName = 'PackageDetPageRoute';

  final String PackageId;

  PackageDetPage({
    this.PackageId,
  });

  @override
  _PackageDetPageState createState() => _PackageDetPageState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _PackageDetPageState extends State<PackageDetPage> {
  PackageAttList packageAttList = PackageAttList();
  //ProductImageList productImageList = ProductImageList();

  PackageList packageList = PackageList();
  final formatter = new NumberFormat("###,###,##0", "en_US");
  bool isTab0 = true;
  bool isTab1 = false;

  String desc_1;
  double s_price;
  String product_id;
  String scaffoldproduct_id;
  String stk_code;
  String category_code;
  String brand_code;
  String att_name;

  AppState state;
  File croppedFileParam;
  File imageFile;
  String customerid;
  String selProdCatVal;
  List data;
  List<DropdownMenuItem<String>> ProdCatItem = [];
  bool isStatus = false;
  String isStatusDesc = 'Non Active';
  bool isFavItem = false;
  String isFavItemDesc = 'No';

  TextEditingController txt_desc_1 = TextEditingController();
  TextEditingController txt_s_price = TextEditingController();
  TextEditingController txt_product_id = TextEditingController();
  TextEditingController txt_stk_code = TextEditingController();
  TextEditingController txt_category_code = TextEditingController();
  TextEditingController txt_brand_code = TextEditingController();
  TextEditingController txt_att_name = TextEditingController();

  TabController _tabController;
  bool _AboutUsVisible = true;

  @override
  void initState() {
    super.initState();
    isFavItem = false;
    isStatus = false;
    desc_1 = '';
    brand_code = '';
    s_price = 0;
    //product_id = widget.ProductID;
    att_name = '-';
    getPackageList();
    GetPackageImageList();
    //MemberLogSet();
  }

  Future<String> getPackageList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> bodyParam = {
      'PackageId': widget.PackageId.toString(),
    };

    Response response = await post(
      //AppConstants.PackageGetUrl.toString(),
      //AppConstants.PackageGetUrl,
      Uri.parse(AppConstants.PackageGetUrl),
      body: bodyParam,
    );
    var memberMap = json.decode(response.body);
    print(memberMap.toString());
    if (memberMap['status'] == 'success') {
      setState(() {
        packageList = PackageList.fromJson(memberMap['data']);
      });
    }
  }

  Future<String> GetPackageImageList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('1111111');
    Map<String, dynamic> bodyParam = {
      'PackageId': widget.PackageId.toString(),
    };
    print('2222222');
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      Uri.parse(AppConstants.PackageAttGetUrl.toString()),
      body: bodyParam,
    );
    print('3333333');
    var memberMap = json.decode(response.body);
    print(memberMap);
    print('4444444');
    if (memberMap['status'] == 'success') {
      setState(() {
        packageAttList = PackageAttList.fromJson(memberMap['data']);
      });
    }
  }

  void showTabDet(int TabIndex) {
    print(TabIndex);

    setState(() {
      if (TabIndex == 0) {
        isTab0 = true;
        isTab1 = false;
      } else if (TabIndex == 1) {
        isTab0 = false;
        isTab1 = true;
      }
    });
  }

  Future<String> GetProductDet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ClientId = prefs.getString('ClientId');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    Map<String, dynamic> bodyParam = {
      'prod_id': product_id.toString(),
    };

    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      Uri.parse(AppConstants.ProductGetUrl.toString()),
      body: bodyParam,
    );
    var memberMap = json.decode(response.body);
    print(memberMap);

    if (memberMap['status'] == 'success') {
      setState(() {
        //customerList = CustomerList.fromJson(memberMap['data']);
        //  asdf

        desc_1 = memberMap['data'][0]['ProductDesc'];
        brand_code = memberMap['data'][0]['Brand'];
        s_price = memberMap['data'][0]['UP'];
        att_name = memberMap['data'][0]['AttName'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: header(context,
          isAppTitle: true,
          strTitle: widget.ProductName.toString(),
          isVisibleBackButton: true),
      */

      body: SafeArea(
        child: WillPopScope(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: Column(children: <Widget>[
                Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                0,
                                0,
                                0,
                              ),
                              child: Image.network(
                                //widget.AttName.toString(),
                                packageList.package[0].AttName.toString(),
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 5.0,
                      right: 0.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              //color: Colors.red,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              child: Center(
                                child: FaIcon(FontAwesomeIcons.arrowLeft,
                                    color: Colors.black, size: 35),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    //borderRadius: BorderRadius.circular(20),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 5,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ],
                  ),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: <Widget>[
                        TabBar(
                            indicatorColor: Colors.grey,
                            labelColor: Colors.blue[600],
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              Tab(
                                text: 'Details',
                                icon: FaIcon(
                                  FontAwesomeIcons.listAlt,
                                  color: Colors.blue[600],
                                  size: 20,
                                ),
                              ),
                              Tab(
                                text: 'Gallery',
                                icon: FaIcon(
                                  FontAwesomeIcons.images,
                                  color: Colors.blue[600],
                                  size: 20,
                                ),
                              ),
                            ],
                            onTap: (int index) {
                              showTabDet(index);
                            }),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: isTab0,
                  child: Expanded(
                    child: Container(
                      color: Colors.grey[200],
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 50,
                                  child: Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.listAlt,
                                      color: Colors.blue,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ClipRect(
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('Description',
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: AppConstants.tinyFontSize,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 50,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        //widget.ProductName.toString(),
                                        packageList.package[0].PackageName
                                            .toString(),
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize:
                                                AppConstants.tinyFontSize)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Divider(color: Colors.grey[300]),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 50,
                                  child: Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.tag,
                                      color: Colors.blue,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ClipRect(
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('Our Price',
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: AppConstants.tinyFontSize,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 50,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        //'RM ' + formatter.format(widget.UP),
                                        'RM 110.50',
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize:
                                                AppConstants.tinyFontSize)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Divider(color: Colors.grey[300]),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Divider(color: Colors.grey[300]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: isTab1,
                  child: Expanded(
                    child: Container(
                      color: Colors.grey[200],
                      //child: Text('isTab1'),
                      child: SingleChildScrollView(
                        child: GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: (packageAttList == null ||
                                    packageAttList.packageAtt == null ||
                                    packageAttList.packageAtt.length == 0)
                                ? 0
                                : packageAttList.packageAtt.length,
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.5,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 5, 5, 5),
                                        child: Container(
                                          height: 180.0,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    packageAttList
                                                        .packageAtt[index]
                                                        .AttName)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          onWillPop: () async => false,
        ),
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = new NumberFormat("###,###,##0.00", "en_US");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
