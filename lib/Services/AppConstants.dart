import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//  sls.gold.alphaclick.com.my

class AppConstants {
  //static const String AndroidAPIKey = "AIzaSyD7fDd1gKzRReOu8q_unDymCBIhD6BkLMI";

  //static const String SharedUrl = 'https://EzApp.alphaclick.com.my/PHPFiles/';
  static const String SharedUrl = 'https://apec.myekad.com/PHPFiles/';

  static const String AppLogoUrl =
      'https://apec.myekad.com/AppImage/apec_logo.png';

  static Color AppColor = Color.fromARGB(255, 7, 121, 228);

  static const String appName = 'GEM';

  static String BannerImagesGetUrl = SharedUrl + 'BannerImagesGet.php';
  static String PackageAttGetUrl = SharedUrl + 'PackageAttGet.php';

  static String PackageGetUrl = SharedUrl + 'PackageGet.php';
  //  https://apec.myekad.com/PHPFiles/PackageGet.php

  static const String NotificationGetUrl =
      SharedUrl + 'getNotificationList.php';

  //static const String SharedUrl = 'https://EzApp.alphaclick.com.my/PHPFiles/';
  //  https://EzApp.alphaclick.com.my/PHPFiles/AdminProductCatReg

  static const String ShippingMethodGetUrl =
      SharedUrl + 'AdminShippingMethodGet.php';

  static const String ShippingMethodSetUrl =
      SharedUrl + 'AdminShippingMethodReg.php';

  static const String CustGetUrl = SharedUrl + 'AdminCustGet.php';

  static const String UploadOrderListApiUrl = SharedUrl + 'UploadOrderList.php';

  static const String CustInsertUrl = SharedUrl + 'AdminCustInsert.php';

  static const String VendorInsertUrl = SharedUrl + 'AdminVendorInsert.php';

  static const String VendorGetUrl = SharedUrl + 'AdminVendorGet.php';

  static const String DissqlApiUrl = SharedUrl + 'AdmingetDropDownDataList.php';

  static const String ProductCatGet = SharedUrl + 'AdminProductCatGet.php';

  static const String ProductCatRegUrl = SharedUrl + 'AdminProductCatReg.php';

  static const String getDissqlPackageList =
      SharedUrl + 'AdminGetDissqlPackageList.php';

  static const String DissqlGetUrl = SharedUrl + 'AdminDissqlGet.php';

  static const String DeliveryStatusGetUrl = SharedUrl + 'AdminDOStatusGet.php';

  static const String SalesTransMasterGetUrl =
      SharedUrl + 'AdminSalesTransMasterGet.php';

  //AdminSalesPymtDetGet.php
  static const String SalesPymtDetGetUrl =
      SharedUrl + 'AdminSalesPymtDetGet.php';

  static const String SalesTransDetGetUrl =
      SharedUrl + 'AdminSalesTransDetGet.php';

  static const String AdminSigninURL = SharedUrl + 'adminsignin.php';

  static const String ProductGetUrl = SharedUrl + 'AdminProductGet.php';

  static const String MemberListApiURL = SharedUrl + 'admingetMemberList.php';

  static const String submitReloadTransApiUrl =
      SharedUrl + 'AdminsubmitReloadTrans.php';

  //static const String MemberDetApiURL ='admingetMemberDet.php';

  static const String NotificationUpdateApi =
      SharedUrl + 'AdminNotificationReg.php';

  static const String AdminProductCatGetApi =
      SharedUrl + 'AdminProductCatGet.php';

  static const String NotificationRegApi = SharedUrl +
      'http://sls.gold.alphaclick.com.my/PHPFiles/NotificationReg.php';

  static const String MemberRegApi = SharedUrl + 'AdminMemberReg.php';

  static const String MembershipPaymentApiUrl =
      SharedUrl + 'AdminMembershipPayment.php';

  //static const String UploadOrderListApiUrl = SharedUrl + 'http://sls.gold.alphaclick.com.my/PHPFiles/UploadOrderList.php';

  static const String UpdateUserProfileApi =
      SharedUrl + 'AdminUpdateUserProfile.php';

  static const String AddUserProfileApi = SharedUrl + 'AdminAddUserProfile.php';

  static const String getStateListApiUrl = SharedUrl + 'AdminGetStateList.php';

  static const String getMemberDetApiUrl =
      SharedUrl + 'http://sls.gold.alphaclick.com.my/PHPFiles/getMemberDet.php';

  static const String getMasterSetupApiUrl =
      SharedUrl + 'AdminGetMasterSetupData.php';

  static const String UpdateMasterSetupApiUrl =
      SharedUrl + 'AdminUpdateMasterSetup.php';

  static const String SubmitTransApproval =
      SharedUrl + 'AdminSubmitTransApproval.php';

  static const String TransListAPIURL =
      SharedUrl + "http://sls.gold.alphaclick.com.my/PHPFiles/getTransList.php";

  static const String getUserListApiUrl = SharedUrl + "AdminGetUserList.php";

  static const String TransDetListAPIURL =
      SharedUrl + "http://sls.gold.alphaclick.com.my/PHPFiles/getTransDet.php";

  //static const String getSKURegAPIUrl =
  static const String ProductInsertUrl = SharedUrl + 'AdminProductInsert.php';

  static const String ReceiptUrl1 =
      SharedUrl + 'https://halijahjewels.alphaclick.com.my/Receipt1.aspx';
  static const String ReceiptUrl2 =
      SharedUrl + 'https://halijahjewels.alphaclick.com.my/Receipt2.aspx';
  //'https://halijahjewels.alphaclick.com.my/Receipt.aspx?Type=1&id=e3cbba8883fe746c6e35783c9404b4bc0c7ee9eb';

  static const String ReceiptDetGet = SharedUrl + 'AdminTransDetGet.php';

  static const String getProdUpdateAPIUrl = SharedUrl + 'adminUpdateSKU.php';

  static const String StoreUpdateApiUrl = SharedUrl + 'AdminStoreUpdate.php';
  //  SharedUrl + 'AdminStoreUpdate.php';

  static const String getSalesStatistic =
      SharedUrl + 'admingetslsstatistic.php';
  static const String getSalesCollectionByPackageApiUrl =
      SharedUrl + 'adminGetSlsCollectionByPackage.php';

  static String DeviceType;

  //static double tinyFontSize = (DeviceType == 'Tablet') ? 15 : 10;
  //static double smallFontSize = (DeviceType == 'Tablet') ? 20 : 15;
  //static double regularFontSize = (DeviceType == 'Tablet') ? 25 : 20;
  //static double largeFontSize = (DeviceType == 'Tablet') ? 35 : 25;

  //static double tinyFontSize = (DeviceType == 'Tablet') ? 20 : 15;
  static double tinyFontSize = (DeviceType == 'Tablet') ? 20 : 15;
  static double smallFontSize = (DeviceType == 'Tablet') ? 25 : 20;
  static double regularFontSize = (DeviceType == 'Tablet') ? 30 : 25;
  static double largeFontSize = (DeviceType == 'Tablet') ? 40 : 35;

  /*
  static const double tinyFontSize = 15.0;
  static const double smallFontSize = 20.0;
  static const double regularFontSize = 25.0;
  static const double largeFontSize = 35.0;
  */

  static const double regularCornerRadius = 10.0;
  static const String clientId = '8888';
  static const double tinyPadding = 10.0;
  static const double smallPadding = 25.0;
  static const double mediumPadding = 50.0;
  static const double largePadding = 75.0;
  static const double appBarHeight = 50;
  static Color messageYellow = Color.fromARGB(255, 245, 215, 66);
  static Color messageBlue = Color.fromARGB(255, 66, 173, 245);
  static Color buttonColorBlueAccent = Colors.blueAccent;
  //static User currentUser;

  static Map<String, String> months = {
    "01": "January",
    "02": "February",
    "03": "March",
    "04": "April",
    "05": "May",
    "06": "June",
    "07": "July",
    "08": "August",
    "09": "September",
    "10": "October",
    "11": "November",
    "12": "December",
  };

  static Map<int, int> daysInMonths = {
    1: 31,
    2: (DateTime.now().year % 4 == 0) ? 29 : 28,
    3: 31,
    4: 30,
    5: 31,
    6: 30,
    7: 31,
    8: 31,
    9: 30,
    10: 31,
    11: 30,
    12: 31
  };

  void initState() {
    //super.initState();
    DeviceType = getDeviceType();
  }

  String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'SmartPhone' : 'Tablet';
  }

  //String regularFontSizeCusom() {
  double regularFontSizeCustom() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 13 : 63;
    //static double regularFontSize = (DeviceType == 'Tablet') ? 25 : 20;
  }

  String getDeviceWidth() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide.toString();
  }

//  SharedPreferences prefs = await SharedPreferences.getInstance();
}
