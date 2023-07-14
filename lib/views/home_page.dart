import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../res/app_colors.dart';
import '../res/components/logout.dart';
import '../res/components/support_chaavie.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [

            Positioned(
              top: 1.h,
              left: 0.w,
              right: 0.w,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:  [
                        const SupportChaavie(),
                        SizedBox(width: 3.w,),
                        const Logout(),

                      ],
                    ),

                    Row(
                      children:  [
                        InkWell(
                          onTap:(){
                            Navigator.pushNamed(context, RoutesName.profile_page);
                          },
                          child: const CircleAvatar(
                            backgroundColor: AppColors.buttonsColor,
                            backgroundImage:AssetImage('./assets/images/user-photo.png'),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 3.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(Utils.userName.toString(),style: TextStyle(fontSize: 18.sp),),
                              Text('${Utils.userLocarion},${Utils.userDistrict}',style: TextStyle(color: Colors.black38,fontSize: 16.sp),)
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Text(Utils.greeting().toString(),style:  TextStyle(fontSize: 19.sp,color:AppColors.buttonsColor),),

                  ],
                ),
              ),),


            Positioned(
              top: 25.h,
              left: 0.w,
              right: 0.w,
              bottom: 20.h,
              child:
              SizedBox(
                width: double.infinity,
                child: Center(child: Lottie.asset('assets/lottie/101270-logistics.json')),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
