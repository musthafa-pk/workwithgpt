import 'package:chaavie_customer/utils/routes/routes_name.dart';
import 'package:chaavie_customer/views/Login/login_page.dart';
import 'package:chaavie_customer/views/address_book/add_address.dart';
import 'package:chaavie_customer/views/address_book/my_address_page.dart';
import 'package:chaavie_customer/views/address_book/recipient_address_page.dart';
import 'package:chaavie_customer/views/booking/booking_page1.dart';
import 'package:chaavie_customer/views/booking/chagptorder.dart';
import 'package:chaavie_customer/views/booking/chatgptslide.dart';
import 'package:chaavie_customer/views/booking/chatgptslideworkout.dart';
import 'package:chaavie_customer/views/first_page.dart';
import 'package:chaavie_customer/views/home_page.dart';
import 'package:chaavie_customer/views/profile/profile_page.dart';
import 'package:chaavie_customer/views/splash_screen/order_failed_splash.dart';
import 'package:chaavie_customer/views/splash_screen/order_placed_splash.dart';
import 'package:chaavie_customer/views/transactions_page.dart';
import 'package:chaavie_customer/views/wallet.dart';
import 'package:flutter/material.dart';

import '../../views/booking/booking_page2.dart';
import '../../views/booking/chatgptslideworkout21th.dart';
import '../utils.dart';
class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case RoutesName.first_page:
        return MaterialPageRoute(builder: (BuildContext context)=>const PageOne());

      case RoutesName.home_page:
        return MaterialPageRoute(builder: (BuildContext context)=>const HomePage());

      case RoutesName.profile_page:
        return MaterialPageRoute(builder: (BuildContext context)=> const Profile_Page());

      case RoutesName.myAddress:
        return MaterialPageRoute(builder: (BuildContext context)=>const MyAddressPage());

      case RoutesName.recipientAddress:
        return MaterialPageRoute(builder: (BuildContext context)=>const RecipientAddressPage());

      case RoutesName.transactions:
        return MaterialPageRoute(builder: (BuildContext context)=>const TransactionPage());

      case RoutesName.booking_page1:
        return MaterialPageRoute(builder: (BuildContext context)=>const BookingPage1());

      case RoutesName.booking_page2:
        return MaterialPageRoute(builder: (BuildContext context)=>const BookingPage2());

      case RoutesName.addAddress:
        return MaterialPageRoute(builder: (BuildContext context)=>const AddMyAddressPage());

      case RoutesName.wallet:
        return MaterialPageRoute(builder: (BuildContext context)=> Wallet());

      case RoutesName.orderPlacedSplash:
        return MaterialPageRoute(builder: (BuildContext context)=> OrderPlacedSplash());
        
      case RoutesName.chatgptslide:
        return MaterialPageRoute(builder: (BuildContext context)=> CarouselSlide21th());

      case RoutesName.chatgptslideworkout:
        return MaterialPageRoute(builder: (BuildContext context)=> CarouselSlideWorkout());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context)=> LoginScreen());

      case RoutesName.orderFailedSplash:
        return MaterialPageRoute(builder: (BuildContext context)=> Order_failed_splash());

      // case RoutesName.chatgptorder:
      //   return MaterialPageRoute(builder: (BuildContext context)=> OrderPlacingView());


      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(child: Text('No Routes Defined'),
            ),
          );
        }
        );
    }
  }
}