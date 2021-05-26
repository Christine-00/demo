import 'package:apc_erp/Screens/FavouritePage.dart';
import 'package:apc_erp/Screens/NotificationPage.dart';
import 'package:apc_erp/Screens/ProfilePage.dart';
import 'package:apc_erp/Screens/PurchasePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:apc_erp/Screens/HomePage.dart';
//import 'package:apc_erp/Screens/ProductListPage.dart';
//import 'package:apc_erp/Screens/PromotionListPage.dart';
//import 'package:apc_erp/Screens/VoucherPage.dart';
//import 'package:apc_erp/Screens/settingPage.dart';
//import 'package:apc_erp/Screens/StoreListFragment.dart';
//import 'package:apc_erp/Screens/NotificationListFragment.dart';
//import 'package:apc_erp/Screens/MyAccountPage.dart';

import 'package:flutter/widgets.dart';

//import 'package:sls_b/Screens/Qr.dart';

class LandingPage extends StatefulWidget {
  //final String catBreed;
  //final String catId;
  final String ModuleName;

  static final String routeName = 'landingPageRoute';

  //LandingPage({this.catBreed, this.catId});
  LandingPage({this.ModuleName});
  @override
  _LandingPageState createState() => _LandingPageState();
}

class TabScreen extends StatelessWidget {
  final Color color;
  TabScreen(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        color: Colors.amber[600],
        width: 48.0,
        height: 48.0,
      ),
    );
  }
}

class _LandingPageState extends State<LandingPage> {
  int getPageIndex = 0;
  PageController pageController;
  bool isSignedIn = false;

  String ModuleName;

  @override
  void initState() {
    super.initState();
    //pageController = PageController();
    //pageController = PageController(initialPage: 4);

    //this.getPageIndex = 4;
    //pageController = PageController(initialPage: 4);
    print('widget value is ' + widget.ModuleName.toString());

    if (widget.ModuleName == 'MY_ACCOUNTS') {
      pageController = PageController(initialPage: 4);
      this.getPageIndex = 4;
    } else if (widget.ModuleName == 'VOUCHERS') {
      pageController = PageController(initialPage: 3);
      this.getPageIndex = 3;
    } else if (widget.ModuleName == 'NOTIFICATION') {
      pageController = PageController(initialPage: 2);
      this.getPageIndex = 2;
    } else if (widget.ModuleName == 'STORE') {
      pageController = PageController(initialPage: 1);
      this.getPageIndex = 1;
    } else {
      //pageController = PageController(initialPage: 4);
      pageController = PageController(initialPage: 0);
      this.getPageIndex = 0;
    }
  }

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  whenPageChanged(int pageIndex) {
    setState(() {
      this.getPageIndex = pageIndex;
    });
  }

  onTapChangePage(int pageIndex) {
    setState(() {
      pageController.animateToPage(pageIndex,
          duration: Duration(milliseconds: 400), curve: Curves.bounceInOut);
      //print(pageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: Scaffold(
          body: PageView(
            children: <Widget>[
              new HomePage(),
              new PurchasePage(),
              new FavouritePage(),
              new NotificationPage(),
              new ProfilePage(),
            ],
            controller: pageController,
            onPageChanged: whenPageChanged,
            physics: NeverScrollableScrollPhysics(),
          ),
          bottomNavigationBar: CupertinoTabBar(
            currentIndex: getPageIndex,
            onTap: onTapChangePage,
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,

            //selectedItemColor: Colors.amber[800],
            //backgroundColor: Theme.of(context).accentColor,
            items: [
              BottomNavigationBarItem(
                //icon: Icon(Icons.home, color: Color.fromARGB(255, 0, 0, 0)),
                icon: FaIcon(
                  FontAwesomeIcons.home,
                  color: Colors.grey,
                  size: 20,
                ),
                title: Text(
                  'Home',
                  textScaleFactor: 1.0,
                ),
              ),
              BottomNavigationBarItem(
                //icon: Icon(Icons.gps_fixed, color: Color.fromARGB(255, 0, 0, 0)),
                icon: FaIcon(
                  FontAwesomeIcons.shoppingBag,
                  color: Colors.grey,
                  size: 20,
                ),
                title: Text(
                  'Purchases',
                  textScaleFactor: 1.0,
                ),
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.heart,
                  color: Colors.grey,
                  size: 20,
                ),
                title: Text(
                  'Favourites',
                  textScaleFactor: 1.0,
                ),
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.bell,
                  color: Colors.grey,
                  size: 20,
                ),
                title: Text(
                  'Notifications',
                  textScaleFactor: 1.0,
                ),
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  //FontAwesomeIcons.cogs,
                  FontAwesomeIcons.user,
                  color: Colors.grey,
                  size: 20,
                ),
                //title: Text("Promotions"),
                title: Text(
                  'Profile',
                  textScaleFactor: 1.0,
                ),
              ),
            ],
          ),
        ),
        onWillPop: () async => false);
  }
}
