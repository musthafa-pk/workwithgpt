import 'dart:async';
import 'package:chaavie_customer/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class Order_failed_splash extends StatefulWidget {
  const Order_failed_splash({Key? key}) : super(key: key);

  @override
  State<Order_failed_splash> createState() => _Order_failed_splashState();
}

class _Order_failed_splashState extends State<Order_failed_splash> {
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
      child: Text('Order Failed...!',style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 22
      ),
      ),
    );
  }
}