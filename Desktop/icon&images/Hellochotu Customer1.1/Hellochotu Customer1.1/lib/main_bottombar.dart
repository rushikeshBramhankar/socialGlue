// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_element, prefer_is_empty, unused_local_variable, prefer_interpolation_to_compose_strings, avoid_print

import 'package:badges/badges.dart' as bg;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hellochotu/Api/data_store.dart';
import 'package:hellochotu/controller/catdetails_controller.dart';
import 'package:hellochotu/controller/home_controller.dart';
import 'package:hellochotu/model/fontfamily_model.dart';
import 'package:hellochotu/screen/about_screen.dart';
import 'package:hellochotu/screen/cart_screen.dart';
import 'package:hellochotu/screen/categorydetails_screen.dart';
import 'package:hellochotu/screen/home_screen.dart';
import 'package:hellochotu/screen/home_search.dart';
import 'package:hellochotu/screen/profile_screen.dart';
import 'package:hellochotu/screen/yourcart_screen.dart';
import 'package:hellochotu/utils/Colors.dart';

class MainBottomBarScreen extends StatefulWidget {
  const MainBottomBarScreen({super.key});

  @override
  State<MainBottomBarScreen> createState() => _MainBottomBarScreenState();
}

int selectMainIndex = 0;
final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class _MainBottomBarScreenState extends State<MainBottomBarScreen>
    with TickerProviderStateMixin {
  CatDetailsController catDetailsController = Get.find();
  HomePageController homePageController = Get.find();

  late TabController tabController;
  List<Widget> myChilders = [
    HomeScreen(),
    HomeSearchScreen(statusWiseSearch: true),
    // PreScriptionScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    if (getData.read("changeIndex") != null) {
      if (getData.read("changeIndex") != true) {
        selectMainIndex = 0;
        setState(() {});
        save("changeIndex", false);
      } else {
        if (homePageController.isback == "1") {
          selectMainIndex = 0;
        }
      }
    } else {
      selectMainIndex = 0;
    }
    // selectMainIndex = 0;
    tabController =
        TabController(length: 4, vsync: this, initialIndex: selectMainIndex);
    super.initState();
    tabController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CatDetailsController>(builder: (context) {
        return TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: TabController(
              length: 4, vsync: this, initialIndex: selectMainIndex),
          children: myChilders,
        );
      }),
      // body: Navigator(
      //   key: navKey,
      //   onGenerateRoute: (settings) {
      //     return MaterialPageRoute(
      //       builder: (context) {
      //         return TabBarView(
      //           physics: const NeverScrollableScrollPhysics(),
      //           controller: tabController,
      //           children: myChilders,
      //         );
      //       },
      //     );
      //   },
      // ),
      bottomNavigationBar: BottomAppBar(
        color: WhiteColor,
        child: GetBuilder<CatDetailsController>(builder: (context) {
          return TabBar(
            onTap: (index) {
              setState(() {
                selectMainIndex = index;
              });
            },
            indicator: UnderlineTabIndicator(
              insets: EdgeInsets.only(bottom: 52),
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            labelColor: Colors.blueAccent,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.grey,
            controller: TabController(
                length: 4, vsync: this, initialIndex: selectMainIndex),
            padding: const EdgeInsets.symmetric(vertical: 6),
            tabs: [
              Tab(
                child: Column(
                  children: [
                    selectMainIndex == 0
                        ? Image.asset(
                            "assets/storeBold.png",
                            scale: 25,
                            color: gradient.defoultColor,
                          )
                        : Image.asset(
                            "assets/store.png",
                            scale: 25,
                            color: BlackColor,
                          ),
                    SizedBox(height: 4),
                    Text(
                      "Home".tr,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: FontFamily.gilroyBold,
                        color: selectMainIndex == 0
                            ? gradient.defoultColor
                            : BlackColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    selectMainIndex == 1
                        ? Image.asset(
                            "assets/search_fill.png",
                            scale: 3,
                            color: gradient.defoultColor,
                          )
                        : Image.asset(
                            "assets/search-main.png",
                            scale: 3,
                            color: BlackColor,
                          ),
                    SizedBox(height: 2),
                    Text(
                      "Search".tr,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: FontFamily.gilroyBold,
                        color: selectMainIndex == 1
                            ? gradient.defoultColor
                            : BlackColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Tab(
                child: bg.Badge(
                  position: bg.BadgePosition.topEnd(end: -5, top: -8),
                  badgeAnimation: bg.BadgeAnimation.fade(),
                  badgeContent: Text(
                    catDetailsController.cartlength.length.toString(),
                    style: TextStyle(color: WhiteColor, fontSize: 10),
                  ),
                  badgeStyle: bg.BadgeStyle(
                    badgeColor: gradient.defoultColor,
                    elevation: 0,
                    shape: bg.BadgeShape.circle,
                  ),
                  showBadge: catDetailsController.cartlength.length == 0
                      ? false
                      : true,
                  child: Column(
                    children: [
                      selectMainIndex == 2
                          ? Image.asset(
                              "assets/shopping-bag-bold.png",
                              scale: 25,
                              color: gradient.defoultColor,
                            )
                          : Image.asset(
                              "assets/shopping-bag-outline.png",
                              scale: 25,
                              color: BlackColor,
                            ),
                      SizedBox(height: 4),
                      Text(
                        "Cart".tr,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: FontFamily.gilroyBold,
                          color: selectMainIndex == 2
                              ? gradient.defoultColor
                              : BlackColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    selectMainIndex == 3
                        ? Image.asset(
                            "assets/user1.png",
                            scale: 25,
                            color: gradient.defoultColor,
                          )
                        : Image.asset(
                            "assets/ic_user.png",
                            scale: 25,
                            color: BlackColor,
                          ),
                    SizedBox(height: 4),
                    Text(
                      "Profile".tr,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: FontFamily.gilroyBold,
                        color: selectMainIndex == 3
                            ? gradient.defoultColor
                            : BlackColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
