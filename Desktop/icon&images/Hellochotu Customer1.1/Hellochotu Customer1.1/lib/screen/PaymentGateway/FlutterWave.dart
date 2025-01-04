// // ignore_for_file: prefer_final_fields, unused_field, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, unnecessary_string_interpolations, await_only_futures, avoid_print, prefer_const_constructors, avoid_unnecessary_containers, file_names
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hellochotu/Api/config.dart';
// import 'package:hellochotu/controller/cart_controller.dart';
// import 'package:hellochotu/model/fontfamily_model.dart';
// import 'package:hellochotu/utils/Custom_widget.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class Flutterwave extends StatefulWidget {
//   final String? email;
//   final String? totalAmount;
//
//   const Flutterwave({this.email, this.totalAmount});
//
//   @override
//   State<Flutterwave> createState() => _FlutterwaveState();
// }
//
// class _FlutterwaveState extends State<Flutterwave> {
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   late WebViewController _controller;
//   var progress;
//   String? accessToken;
//   String? payerID;
//   bool isLoading = true;
//   CartController cartController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     if (_scaffoldKey.currentState == null) {
//       return WillPopScope(
//         onWillPop: () {
//           cartController.setOrderLoadingOff();
//           return Future.value(true);
//         },
//         child: Scaffold(
//           body: SafeArea(
//             child: Stack(
//               children: [
//                 WebView(
//                   initialUrl:
//                              "${Config.paymentBaseUrl + "flutterwave/index.php?amt=${widget.totalAmount}&email=${widget.email}"}",
//                   javascriptMode: JavascriptMode.unrestricted,
//                   navigationDelegate: (NavigationRequest request) async {
//                     final uri = Uri.parse(request.url);
//                     if (uri.queryParameters["status"] == null) {
//                       accessToken = uri.queryParameters["token"];
//                     } else {
//                       if (uri.queryParameters["status"] == "successful") {
//                         payerID = await uri.queryParameters["transaction_id"];
//                         Get.back(result: payerID);
//                       } else {
//                         cartController.setOrderLoadingOff();
//                         Get.back();
//                         showToastMessage("${uri.queryParameters["status"]}");
//                       }
//                     }
//                     return NavigationDecision.navigate;
//                   },
//                   gestureNavigationEnabled: true,
//                   onWebViewCreated: (controller) {
//                     _controller = controller;
//                   },
//                   onPageFinished: (finish) {
//                     setState(() async {
//                       isLoading = false;
//                     });
//                   },
//                   onProgress: (val) {
//                     progress = val;
//                     setState(() {});
//                   },
//                 ),
//                 isLoading
//                     ? Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               child: CircularProgressIndicator(
//                                 color: gradient.defoultColor,
//                               ),
//                             ),
//                             SizedBox(height: Get.height * 0.02),
//                             SizedBox(
//                               width: Get.width * 0.80,
//                               child: Text(
//                                 'Please don`t press back until the transaction is complete'
//                                     .tr,
//                                 maxLines: 2,
//                                 textAlign: TextAlign.center,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                     letterSpacing: 0.5),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     : Stack(),
//               ],
//             ),
//           ),
//         ),
//       );
//     } else {
//       return Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () => Get.back(),
//           ),
//           backgroundColor: Colors.black12,
//           elevation: 0.0,
//         ),
//         body: Center(
//           child: Container(
//             child: CircularProgressIndicator(
//               color: gradient.defoultColor,
//             ),
//           ),
//         ),
//       );
//     }
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../Api/config.dart';
import '../../controller/cart_controller.dart';
import '../../utils/Custom_widget.dart';

class Flutterwave extends StatefulWidget {
  final String? email;
  final String? totalAmount;
  const Flutterwave({super.key, this.email, this.totalAmount});

  @override
  State<Flutterwave> createState() => _FlutterwaveState();
}

class _FlutterwaveState extends State<Flutterwave> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late WebViewController _controller;
  var progress;
  String? accessToken;
  String? payerID;
  bool isLoading = true;
  CartController cartController = Get.find();

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (finish) {
            setState(() async {
              isLoading = false;
            });
          },
          onProgress: (val) {
            progress = val;
            setState(() {});
          },
          onNavigationRequest: (NavigationRequest request) async {
            final uri = Uri.parse(request.url);
            if (uri.queryParameters["status"] == null) {
              accessToken = uri.queryParameters["token"];
            } else {
              if (uri.queryParameters["status"] == "successful") {
                payerID = await uri.queryParameters["transaction_id"];
                Get.back(result: payerID);
              } else {
                cartController.setOrderLoadingOff();
                Get.back();
                showToastMessage("${uri.queryParameters["status"]}");
              }
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(
          "${Config.paymentBaseUrl + "flutterwave/index.php?amt=${widget.totalAmount}&email=${widget.email}"}"));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
