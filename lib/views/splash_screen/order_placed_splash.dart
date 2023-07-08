import 'dart:async';
import 'package:chaavie_customer/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class OrderPlacedSplash extends StatefulWidget {
  const OrderPlacedSplash({Key? key}) : super(key: key);

  @override
  State<OrderPlacedSplash> createState() => _OrderPlacedSplashState();
}

class _OrderPlacedSplashState extends State<OrderPlacedSplash> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4 ),
          () {
        setState(
              () {
            Navigator.pushNamed(context, RoutesName.first_page);
          },
        );
      },
    );
  }
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, // navigation bar color
        statusBarColor: Colors.white, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      sized: false,
      child: Scaffold(body:Center(child: Lottie.asset('assets/lottie/order-placed.json')),
      ),
    );
  }
}