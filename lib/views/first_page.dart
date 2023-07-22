import 'package:chaavie_customer/res/components/support_chaavie.dart';
import 'package:chaavie_customer/views/address_book/my_address_page.dart';
import 'package:chaavie_customer/views/booking/booking_page1.dart';
import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../res/app_colors.dart';
import 'home_page.dart';
class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavBar(
      actionButton: CurvedActionBar(
        onTab: (value){
          print(value);
        },
        activeIcon: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.buttonsColor,
            shape: BoxShape.circle,
          ),
          child: Image.asset('./assets/images/book_icon.png',scale:5),
        ),
        inActiveIcon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.buttonsColor,shape: BoxShape.circle,
            ),
            child: Image.asset('./assets/images/book_icon.png',scale:5)
        ),
      ),
      activeColor: Colors.white,
      navBarBackgroundColor: AppColors.buttonsColor,
      inActiveColor: Colors.white,
      appBarItems: [
        FABBottomAppBarItem(
          activeIcon: Icon(Icons.home,color: Colors.white,),
          inActiveIcon: Icon(Icons.home,color: Colors.white,),
          text: 'Home',
        ),
        FABBottomAppBarItem(
          activeIcon: Icon(Icons.support_agent,color: Colors.white,),
          inActiveIcon: Icon(Icons.support_agent,color: Colors.white,),
          text: 'Support',
        ),
      ],
      bodyItems: [
        HomePage(),
        SupportChaavie()
      ],
      actionBarView: BookingPage1(),
    );
  }
}
