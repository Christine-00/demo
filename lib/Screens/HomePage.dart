//import 'package:apc_erp/Screens/ProductInsertPage.dart';
import 'package:apc_erp/Models/BannerImages.dart';
import 'package:apc_erp/Models/Package.dart';
import 'package:apc_erp/Screens/PackageDetPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

class HomePage extends StatefulWidget {
  static final String routeName = 'HomePageRoute';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String UserDisplayName = '';
  PackageList packageList = PackageList();
  bool IsBannerImage = true;
  List<String> images = [];

  BannerImagesList bannerImagesList = BannerImagesList();
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
      Uri.parse(AppConstants.DissqlApiUrl),
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

    //SharedPreferences prefs = await SharedPreferences.getInstance();

    //UserDisplayName = prefs.getString('UserDisplayName').toString();

    getPackageList();
    getBannerImagesList();
    isProdListVisible = false;
    TotalItemCnt = 0;
  }

  Future<String> getPackageList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> bodyParam = {
      'client_id': '-',
    };

    Response response = await post(
      Uri.parse(AppConstants.PackageGetUrl),
      // AppConstants.PackageGetUrl.toString(),
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

  Future<String> getBannerImagesList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> bodyParam = {
      'client_id': '-',
    };

    Response response = await post(
      Uri.parse(AppConstants.BannerImagesGetUrl.toString()),
      body: bodyParam,
    );
    var memberMap = json.decode(response.body);
    print('aaaaaaa');
    if (memberMap['status'] == 'success') {
      setState(() {
        bannerImagesList = BannerImagesList.fromJson(memberMap['data']);
        for (var i = 0; i < bannerImagesList.bannerImages.length; i++) {
          images.add(bannerImagesList.bannerImages[i].AttName.toString());
        }
        IsBannerImage = true;
      });
    }
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
          'Ayer Itam, Penang, Malaysia',
          style: TextStyle(
              fontFamily: 'Montserrat', fontSize: AppConstants.tinyFontSize),
        ),
        centerTitle: true,
        leading: FlatButton(
            onPressed: () {
              //Navigator.push(context, CupertinoPageRoute(builder: (context) => ProductListPage()));
            },
            child: FaIcon(
              FontAwesomeIcons.mapMarker,
              size: 20,
              color: Colors.white,
            )
            /*
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
          */
            ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //Text(UserDisplayName),
              Container(
                child: Visibility(
                    //visible: IsBannerImage,
                    visible: true,
                    child: CarouselSlider.builder(
                      itemCount: (bannerImagesList == null ||
                              bannerImagesList.bannerImages == null ||
                              bannerImagesList.bannerImages.length == 0)
                          ? 0
                          : bannerImagesList.bannerImages.length,
                      options: CarouselOptions(
                        autoPlay: true,
                        //aspectRatio: 2,
                        aspectRatio: 1.5,
                        enlargeCenterPage: false,
                        initialPage: 2,
                        viewportFraction: 1,
                      ),
                      //itemBuilder: (context, index) {
                      itemBuilder: (ctx, index, realIdx) {
                        return Container(
                          child: Center(
                              child: Image.network(
                            images[index],
                            fit: BoxFit.cover,
                          )),
                        );
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Text(
                              'Upcoming Plan',
                              style: TextStyle(
                                  fontSize: AppConstants.smallFontSize),
                            )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            0,
                            10,
                            0,
                            10,
                          ),
                          child: Container(
                            height: 1,
                            color: Colors.grey[400],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(child: Text('Escape Penang,')),
                            Text('20-May-2021'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            0,
                            5,
                            0,
                            5,
                          ),
                          child: Container(
                            height: 1,
                            //color: Colors.grey[400],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(child: Text('Escape Penang,')),
                            Text('20-May-2021'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  //color: Colors.grey[400],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Explore Top Places',
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: AppConstants.tinyFontSize,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                /*
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProductListByCatPage(
                                      cat_code: 'cat_1',
                                      cat_name: Cat1Caption.toString());
                                }));
                                */
                              },
                              child: Text(
                                'View More >>',
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppConstants.tinyFontSize + 2,
                                  fontFamily: 'Montserrat',
                                  color: Colors.blue[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: (packageList == null ||
                                  packageList.package == null ||
                                  packageList.package.length == 0)
                              ? 0
                              : packageList.package.length,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                            //crossAxisCount: 1,
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if (index + 1 == packageList.package.length) {
                                  /*
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return PromotionListPage();
                                      }));
                                  */
                                } else {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return PackageDetPage(
                                        PackageId: packageList
                                            .package[index].PackageId
                                            .toString());
                                  }));
                                }
                              },
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: Container(
                                      height: 200.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(packageList
                                                .package[index].AttName
                                                .toString())),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    //visible: (index + 1 == packageList.package.length && packageList.package.length >= 5) ? true : false,
                                    visible: false,
                                    child: Positioned(
                                      bottom: 0,
                                      top: 0,
                                      left: 0.0,
                                      right: 0.0,
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                            10,
                                            10,
                                            10,
                                            10,
                                          ),
                                          child: Container(
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[900],
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                  3,
                                                  3,
                                                  3,
                                                  3,
                                                ),
                                                child: Center(
                                                  child: AutoSizeText(
                                                    'View More',
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: AppConstants
                                                            .smallFontSize),
                                                    minFontSize: AppConstants
                                                            .smallFontSize -
                                                        8,
                                                    stepGranularity: 1.0,
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    //visible: (index + 1 == packageList.package.length && packageList.package.length >= 5) ? true : false,
                                    visible: true,
                                    child: Positioned(
                                      bottom: 0,
                                      top: 70,
                                      left: 0.0,
                                      right: 0.0,
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                            5,
                                            5,
                                            5,
                                            5,
                                          ),
                                          child: Container(
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[900],
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  //topLeft: Radius.circular(10),
                                                  //topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                  3,
                                                  3,
                                                  3,
                                                  3,
                                                ),
                                                child: Center(
                                                  child: AutoSizeText(
                                                    packageList.package[index]
                                                        .PackageName
                                                        .toString(),
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: AppConstants
                                                            .smallFontSize),
                                                    minFontSize: AppConstants
                                                            .smallFontSize -
                                                        8,
                                                    stepGranularity: 1.0,
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    //visible: (index + 1 == packageList.package.length && packageList.package.length >= 5) ? true : false,
                                    visible: true,
                                    child: Positioned(
                                      //bottom: 0,
                                      top: 0,
                                      //left: 0.0,
                                      right: 0.0,
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                            5,
                                            5,
                                            5,
                                            5,
                                          ),
                                          child: Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[900],
                                                //color: Colors.blueAccent[900],
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  //topLeft: Radius.circular(10),
                                                  //topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                  3,
                                                  3,
                                                  3,
                                                  3,
                                                ),
                                                child: Center(
                                                  child: AutoSizeText(
                                                    '0.7 km',
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: AppConstants
                                                            .tinyFontSize),
                                                    minFontSize: AppConstants
                                                        .tinyFontSize,
                                                    stepGranularity: 1.0,
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  //color: Colors.grey[400],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'On Going Promotions',
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: AppConstants.tinyFontSize,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                /*
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProductListByCatPage(
                                      cat_code: 'cat_1',
                                      cat_name: Cat1Caption.toString());
                                }));
                                */
                              },
                              child: Text(
                                'View More >>',
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppConstants.tinyFontSize + 2,
                                  fontFamily: 'Montserrat',
                                  color: Colors.blue[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: (packageList == null ||
                                  packageList.package == null ||
                                  packageList.package.length == 0)
                              ? 0
                              : packageList.package.length,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                            //crossAxisCount: 1,
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if (index + 1 == packageList.package.length) {
                                  /*
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return PromotionListPage();
                                      }));
                                  */
                                } else {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return PackageDetPage(
                                        PackageId: packageList
                                            .package[index].PackageId
                                            .toString());
                                  }));
                                }
                              },
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: Container(
                                      height: 200.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(packageList
                                                .package[index].AttName
                                                .toString())),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    //visible: (index + 1 == packageList.package.length && packageList.package.length >= 5) ? true : false,
                                    visible: false,
                                    child: Positioned(
                                      bottom: 0,
                                      top: 0,
                                      left: 0.0,
                                      right: 0.0,
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                            10,
                                            10,
                                            10,
                                            10,
                                          ),
                                          child: Container(
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[900],
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                  3,
                                                  3,
                                                  3,
                                                  3,
                                                ),
                                                child: Center(
                                                  child: AutoSizeText(
                                                    'View More',
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: AppConstants
                                                            .smallFontSize),
                                                    minFontSize: AppConstants
                                                            .smallFontSize -
                                                        8,
                                                    stepGranularity: 1.0,
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    //visible: (index + 1 == packageList.package.length && packageList.package.length >= 5) ? true : false,
                                    visible: true,
                                    child: Positioned(
                                      bottom: 0,
                                      top: 70,
                                      left: 0.0,
                                      right: 0.0,
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                            5,
                                            5,
                                            5,
                                            5,
                                          ),
                                          child: Container(
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[900],
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  //topLeft: Radius.circular(10),
                                                  //topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                  3,
                                                  3,
                                                  3,
                                                  3,
                                                ),
                                                child: Center(
                                                  child: AutoSizeText(
                                                    packageList.package[index]
                                                        .PackageName
                                                        .toString(),
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: AppConstants
                                                            .smallFontSize),
                                                    minFontSize: AppConstants
                                                            .smallFontSize -
                                                        8,
                                                    stepGranularity: 1.0,
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    //visible: (index + 1 == packageList.package.length && packageList.package.length >= 5) ? true : false,
                                    visible: true,
                                    child: Positioned(
                                      //bottom: 0,
                                      top: 0,
                                      //left: 0.0,
                                      right: 0.0,
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                            5,
                                            5,
                                            5,
                                            5,
                                          ),
                                          child: Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[900],
                                                //color: Colors.blueAccent[900],
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  //topLeft: Radius.circular(10),
                                                  //topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                  3,
                                                  3,
                                                  3,
                                                  3,
                                                ),
                                                child: Center(
                                                  child: AutoSizeText(
                                                    '0.7 km',
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: AppConstants
                                                            .tinyFontSize),
                                                    minFontSize: AppConstants
                                                        .tinyFontSize,
                                                    stepGranularity: 1.0,
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
