import 'package:get/get.dart';
import 'package:hellochotu/controller/addlocation_controller.dart';
import 'package:hellochotu/controller/cart_controller.dart';
import 'package:hellochotu/controller/catdetails_controller.dart';
import 'package:hellochotu/controller/fav_controller.dart';
import 'package:hellochotu/controller/home_controller.dart';
import 'package:hellochotu/controller/login_controller.dart';
import 'package:hellochotu/controller/myorder_controller.dart';
import 'package:hellochotu/controller/notification_controller.dart';
import 'package:hellochotu/controller/productdetails_controller.dart';
import 'package:hellochotu/controller/search_controller.dart';
import 'package:hellochotu/controller/signup_controller.dart';
import 'package:hellochotu/controller/stordata_controller.dart';
import 'package:hellochotu/controller/subscribe_controller.dart';
import 'package:hellochotu/controller/subscription_controller.dart';
import 'package:hellochotu/controller/wallet_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => CatDetailsController());
  Get.lazyPut(() => AddLocationController());
  Get.lazyPut(() => PreScriptionControllre());
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => SignUpController());
  Get.lazyPut(() => HomePageController());
  Get.lazyPut(() => StoreDataContoller());
  Get.lazyPut(() => CartController());
  Get.lazyPut(() => ProductDetailsController());
  Get.lazyPut(() => FavController());
  Get.lazyPut(() => MyOrderController());
  Get.lazyPut(() => WalletController());
  Get.lazyPut(() => SearchController1());
  Get.lazyPut(() => NotificationController());
  Get.lazyPut(() => SubScibeController());
}
