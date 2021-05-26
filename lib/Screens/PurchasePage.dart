//import 'package:apc_erp/Screens/ProductInsertPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
//import 'package:apc_erp/Api/ProductApi.dart';
//import 'package:apc_erp/Models/Products.dart';
//import 'package:apc_erp/Screens/OtherPage.dart';
//import 'package:apc_erp/Screens/ProductDetPage.dart';
//import 'package:apc_erp/Screens/ProductInsertPage.dart';
import 'package:apc_erp/Services/AppConstants.dart';

class PurchasePage extends StatefulWidget {
  static final String routeName = 'PurchasePageRoute';

  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final formatter = new NumberFormat("###,###,##0.00", "en_US");
  bool isProdListVisible = false;
  String selProdCatVal;
  List data;
  String CurrentMember;
  final _txtQty = TextEditingController();
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _message = '';

  List<String> _records;
  final _formKey = GlobalKey<FormState>();
  int TotalItemCnt;

  //OrderDetail orderDetail = OrderDetail();
  //List<OrderDetail> orderDetailList = [];
  //ProductList productList = ProductList();
  List<String> POSItem = [];
  List<int> POSQty = [];
  List<double> POSUP = [];
  List<double> POSTotal = [];
  //final dbHelper = DatabaseHelper.instance;
  int value = 0;

  int varItemCount;
  //double varSubTotal;
  double varDisc;
  double varTotal;

  /*
  void getProductListData() async {
    setState(() {
      isProdListVisible = false;
    });

    var productJson = await ProductAPI().getProductList(selProdCatVal);
    var productMap;
    print('aaaaa');
    print(json.decode(productJson)['data']);
    print('bbbbb');

    if (json.decode(productJson)['status'] == 'success') {
      setState(() {
        print('ccccc');

        isProdListVisible = true;
        productMap = json.decode(productJson);
        productMap = json.decode(productJson);
        productList = ProductList.fromJson(productMap['data']);
      });
    }
  }
*/

  Future<String> getProdCatList() async {
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ClientId = prefs.getString('ClientId');

    //String ClientId = AppConstants.clientId.toString();
    Map<String, dynamic> bodyParam = {
      'data_type': 'PRODUCT_CATEGORY',
      'client_id': ClientId.toString(),
    };

    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      Uri.parse(AppConstants.DissqlApiUrl.toString()),
      body: bodyParam,
    );

    setState(() {
      data = json.decode(response.body)['data'];
    });
    return 'Success';
  }

  void initState() {
    super.initState();
    //getProdCatList();

    isProdListVisible = false;
    TotalItemCnt = 0;
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  Widget ProdCatDropDown(List data) {
    if (data != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color: Colors.grey[500],
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: DropdownButton(
                  items: data.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(
                        //item['Name'],
                        item['item_name'],
                        style: TextStyle(fontSize: 14.0),
                      ),
                      value: item['item_val'].toString(),
                    );
                  }).toList(),
                  hint: Text(
                    "Please select Category",
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                  onChanged: (newVal) {
                    setState(() {
                      selProdCatVal = newVal;
                      print('Category:' + selProdCatVal.toString());
                    });
                  },
                  value: selProdCatVal,
                ),
              ),
            ),

            ////////

            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: MaterialButton(
                onPressed: () {
                  //Navigator.pushNamed(context, MyScreenOne.routeName);
                  //_login();
                },
                child: Text(
                  'Search',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: AppConstants.tinyFontSize),
                ),
                //color: Color(0xff461e1e),
                color: Color(0xff8D1735),
                //height: MediaQuery.of(context).size.height / 15,
                shape: RoundedRectangleBorder(
                  //borderRadius: BorderRadius.circular(AppConstants.regularCornerRadius),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            ////////
          ],
        ),
      );
    } else {
      return new Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Purchases',
          style: TextStyle(
              fontFamily: 'Montserrat', fontSize: AppConstants.smallFontSize),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('This is home page.'),
          ],
        ),
      ),

      /*
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black54,
        backgroundColor: Colors.yellow[600],
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, ProductReg.routeName);
        },
      ),
      */
    );
  }
}
