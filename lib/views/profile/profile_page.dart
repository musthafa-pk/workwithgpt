import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../res/app_colors.dart';
import '../../utils/routes/routes_name.dart';
class Profile_Page extends StatefulWidget {
  const Profile_Page({Key? key}) : super(key: key);

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20,),

                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppColors.buttonsColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20,top: 10),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 105,
                                    width: 105,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(1, 36, 76, 1),
                                        borderRadius: BorderRadius.circular(100)
                                    ),
                                  ),
                                  Positioned(
                                      left: 80,
                                      child: Icon(Icons.star,color: Colors.yellow,size: 30,)),
                                  Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Icon(Icons.person,size: 100,color: Colors.white,))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20,top: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CUSTOMER NAME',style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Argentum Sans',
                                      fontSize: 18.sp
                                  ),),

                                  SizedBox(height: 5,),

                                  Text('COMPANY NAME',style: TextStyle(
                                      color: Colors.white
                                  ),),

                                  SizedBox(height: 5,),

                                  Row(
                                    children: [
                                      Icon(Icons.phone,color: Colors.white,),
                                      Text('+91 1234567890',style: TextStyle(
                                        color: Colors.white,
                                      ),),
                                    ],
                                  ),

                                  SizedBox(height: 5,),

                                  Text('emailofcust@gmail.com',style: TextStyle(
                                      color: Colors.white
                                  ),),

                                  SizedBox(height: 5,),


                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),


                    Positioned(
                      top:160,
                      left: 120,
                      child: Row(
                        children: [
                          Text('GSTIN:',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),),
                          Text('98AC765SD52HSD5',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),),
                        ],
                      ),
                    ),

                    Positioned(
                      top: 185,
                      right: 10,
                      child: InkWell(
                        onTap:(){
                          // Navigator.pushNamed(context, RoutesName.editprofile);
                        },
                        child: Row(
                          children: [
                            Text('Edit',style: TextStyle(
                                color: Colors.white
                            ),),
                            Icon(Icons.edit,color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),


                SizedBox(height: 30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.buttonsColor,width: 1,),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:[
                          Text('TRIPS',style: TextStyle(
                            fontFamily: 'Argentum Sans',
                            fontWeight: FontWeight.w500,
                            color: AppColors.buttonsColor,
                            fontSize: 14.sp,
                          ),),
                          Text('02',style: TextStyle(
                              color: AppColors.buttonsColor,
                              fontWeight: FontWeight.w600,fontSize: 25.sp
                          ),)
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, RoutesName.wallet);
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.buttonsColor,width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:[
                            Text('WALLET',style: TextStyle(
                              fontFamily: 'Argentum Sans',
                              fontWeight: FontWeight.w500,
                              color: AppColors.buttonsColor,
                              fontSize: 14.sp,
                            ),),
                            Text('₹',style: TextStyle(
                              fontFamily: 'Argentum Sans',
                              fontWeight: FontWeight.w500,
                              color: AppColors.buttonsColor,
                              fontSize: 14.sp,
                            ),),
                            Text('1234',style: TextStyle(
                                color: AppColors.buttonsColor,
                                fontWeight: FontWeight.w600,fontSize: 25.sp
                            ),)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.buttonsColor,width: 1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:[
                          Text('REWARDS',style: TextStyle(
                            fontFamily: 'Argentum Sans',
                            fontWeight: FontWeight.w500,
                            color: AppColors.buttonsColor,
                            fontSize: 14.sp,
                          ),),
                          Text('02',style: TextStyle(
                              color: AppColors.buttonsColor,
                              fontWeight: FontWeight.w600,fontSize: 25.sp
                          ),)
                        ],
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 50,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, RoutesName.myAddress);
                      },
                      child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1,color: AppColors.buttonsColor),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(child: Text('MY ADDRESS',style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.buttonsColor
                            ),)),
                          )),
                    ),

                    SizedBox(height: 30,),

                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, RoutesName.recipientAddress);
                      },
                      child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1,color: AppColors.buttonsColor),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(child: Text('RECIPIENT ADDRESS BOOK',style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.buttonsColor
                            ),)),
                          )),
                    ),

                    SizedBox(height: 30,),

                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, RoutesName.transactions);
                      },
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1,color: AppColors.buttonsColor),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(child: Text('TRANSACTIONS',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.buttonsColor,
                          ),)),
                        ),
                      ),
                    ),

                    SizedBox(height: 3.h,),

                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1,color: AppColors.buttonsColor),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: Text('CHANGE PASSWORD',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.buttonsColor,
                        ),)),
                      ),
                    ),
                    SizedBox(height: 3.h,)
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.buttonsColor,
          ),
          height: 5.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.booking_page1);
                },
                  child: SizedBox(child: Image.asset('./assets/images/book_icon.png'))),
              InkWell(
                onTap: (){},
                  child: Icon(Icons.support_agent,color: Colors.white,size: 40,))
            ],
          ),
        )
    );
  }
}
