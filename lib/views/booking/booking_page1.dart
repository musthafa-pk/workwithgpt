import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../res/app_colors.dart';
import '../../res/components/Booking Screen Components/custom_dropdown.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import 'package:http/http.dart' as http;

class BookingPage1 extends StatefulWidget {
  const BookingPage1({Key? key}) : super(key: key);

  @override
  State<BookingPage1> createState() => _BookingPage1State();
}

class _BookingPage1State extends State<BookingPage1> {

  int userId = 85;

  List<String> items = ['chaavie Solutions','A ONE','BLUE STAR'];
  String? selectedOptions='';

  String? selectedDate='';
  bool s_1 = false;
  bool s_2 = false;
  bool s_3 = false;
  bool s_4 = false;
  bool s_5 = false;
  bool s_6 = false;
  bool s_7 = false;
  bool s_8 = false;

  String? selectedTime = '';
  bool time1= false;
  bool time2= false;
  bool time3= false;



  Future<String?> fetchAddressBookDetails(int userId) async {
    print('this function called...');
    final url = Uri.parse('http://192.168.1.4:3000/addressbook/$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('success....');
        final jsonData = json.encode(response.body);
        // final addressBookDetails = jsonData as String?;
        final addressBookDetails = response.body as String;
        print (addressBookDetails);
        print('working...');
        return addressBookDetails;
      } else {
        throw Exception('Failed to fetch address book details. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error occurred during address book fetch: $error');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child:FutureBuilder<String?>(
            future: fetchAddressBookDetails(userId),
            builder: (context,snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              if(snapshot.hasData){
                final fetchedAddressDetails = snapshot.data;
                final List<dynamic> items = fetchedAddressDetails != null ? json.decode(fetchedAddressDetails) as List<dynamic> : [];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Location Details',style: TextStyle(
                                color: AppColors.buttonsColor,
                                fontFamily: 'ArgentumSans',
                                fontSize: 24.sp,
                              ),),
                              SizedBox(height: 1.h,),
                              Icon(Icons.keyboard_arrow_down,color: AppColors.buttonsColor,),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Pickup Location',style: TextStyle(
                              color: AppColors.buttonsColor,
                              fontSize: 18.sp
                          ),),
                        ],
                      ),
                      SizedBox(height: 1.h,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border:Border.all(width: 1,color: AppColors.buttonsColor),
                        ),
                        child:CustomDropdown(
                          hintText: Utils.selectedFromAddress.toString(),
                          options: items
                              .where((value) => value['category'].toString().toLowerCase() == 'from')
                              .map((value) => value['address_label'].toString())
                              .toList(),
                          onChanged: (value) {
                            final selectedAddress = items.firstWhere((item) => item['address_label'].toString() == value);
                            setState(() {
                              Utils.selectedFromAddress = selectedAddress;
                              Utils.selectedTradeName = selectedAddress['address_label'].toString();
                              Utils.selectedPin = selectedAddress['address']['pin'].toString();
                              Utils.selectedLatitude = double.parse(selectedAddress['latitude'].toString());
                              Utils.selectedLongitude = double.parse(selectedAddress['longitude'].toString());
                              Utils.selectedDistrict = selectedAddress['district'].toString();
                              Utils.selectedLocality = selectedAddress['locality'].toString();
                              print(Utils.selectedFromAddress.toString());
                            });
                          },
                        ),


                      ),
                      SizedBox(height: 4.h,),
                      // Text('Pickup Date',style: TextStyle(
                      //     color: AppColors.buttonsColor,
                      //     fontSize: 18.sp),),
                      // SizedBox(height: 2.h,),
                      // Row(
                      //   children: [
                      //     Container(
                      //         decoration:BoxDecoration(
                      //           border: Border.all(width:1,color: AppColors.buttonsColor),
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         child: Row(
                      //           children: [
                      //             Padding(
                      //               padding: const EdgeInsets.only(left: 10.0,right: 5,top: 2,bottom: 2),
                      //               child: InkWell(
                      //                 onTap: (){
                      //                   setState(() {
                      //                     s_1=true;
                      //                     s_2=false;
                      //                     s_3=false;
                      //                     s_4=false;
                      //                     s_5=false;
                      //                     s_6=false;
                      //                     s_7=false;
                      //                     s_8=false;
                      //                   });
                      //                 },
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                     border:Border.all(width: 1,color: AppColors.buttonsColor),
                      //                     color: s_1 == true?AppColors.buttonsColor: Color.fromRGBO(217, 217, 217, 1),
                      //                   ),
                      //                   child: Column(
                      //                     children: [
                      //                       Text('today',style: TextStyle(
                      //                           color: s_1 == true ?Colors.white: AppColors.buttonsColor,
                      //                           fontFamily: 'ArgentumSans'
                      //                       ),),
                      //                       Text('25',style:TextStyle(
                      //                         color:s_1 == true? Colors.white:AppColors.buttonsColor,
                      //                       )),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(right: 5,top: 2,bottom: 2),
                      //               child: InkWell(
                      //                 onTap: (){
                      //                   setState(() {
                      //                     s_1=false;
                      //                     s_2=true;
                      //                     s_3=false;
                      //                     s_4=false;
                      //                     s_5=false;
                      //                     s_6=false;
                      //                     s_7=false;
                      //                     s_8=false;
                      //                   });
                      //                 },
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                     color:s_2 == true?AppColors.buttonsColor: Color.fromRGBO(217, 217, 217, 1),
                      //                     border:Border.all(width:1,color:AppColors.buttonsColor),
                      //                   ),
                      //                   child: Column(
                      //                     children: [
                      //                       Text('today',style: TextStyle(color:s_2 == true?Colors.white: AppColors.buttonsColor),),
                      //                       Text('26',style: TextStyle(color:s_2 == true?Colors.white: AppColors.buttonsColor),),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(right: 5,top: 2,bottom: 2),
                      //               child: InkWell(
                      //                 onTap: (){
                      //                   setState(() {
                      //                     s_1=false;
                      //                     s_2=false;
                      //                     s_3=true;
                      //                     s_4=false;
                      //                     s_5=false;
                      //                     s_6=false;
                      //                     s_7=false;
                      //                     s_8=false;
                      //                   });
                      //                 },
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                       color:s_3==true?AppColors.buttonsColor: Color.fromRGBO(217, 217, 217, 1),
                      //                       border:Border.all(width: 1,color:AppColors.buttonsColor)
                      //                   ),
                      //                   child: Column(
                      //                     children: [
                      //                       Text('today',style: TextStyle(color:s_3 ==true?Colors.white: AppColors.buttonsColor),),
                      //                       Text('27',style: TextStyle(color: s_3 ==true?Colors.white:AppColors.buttonsColor),),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(right: 5,top: 2,bottom: 2),
                      //               child: InkWell(
                      //                 onTap: (){
                      //                   setState(() {
                      //                     s_1=false;
                      //                     s_2=false;
                      //                     s_3=false;
                      //                     s_4=true;
                      //                     s_5=false;
                      //                     s_6=false;
                      //                     s_7=false;
                      //                     s_8=false;
                      //                   });
                      //                 },
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                       color: s_4== true? AppColors.buttonsColor:Color.fromRGBO(217, 217, 217, 1),
                      //                       border: Border.all(width: 1,color: AppColors.buttonsColor)
                      //                   ),
                      //                   child: Column(
                      //                     children: [
                      //                       Text('today',style: TextStyle(color: s_4 == true?Colors.white: AppColors.buttonsColor),),
                      //                       Text('28',style: TextStyle(color:  s_4 == true?Colors.white:AppColors.buttonsColor),),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(right: 5,bottom: 2,top: 2),
                      //               child: InkWell(
                      //                 onTap: (){
                      //                   setState(() {
                      //                     s_1=false;
                      //                     s_2=false;
                      //                     s_3=false;
                      //                     s_4=false;
                      //                     s_5=true;
                      //                     s_6=false;
                      //                     s_7=false;
                      //                     s_8=false;
                      //                   });
                      //                 },
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                       color:s_5==true?AppColors.buttonsColor: Color.fromRGBO(217, 217, 217, 1),
                      //                       border: Border.all(width: 1,color: AppColors.buttonsColor)
                      //                   ),
                      //                   child: Column(
                      //                     children: [
                      //                       Text('today',style: TextStyle(color:s_5 == true?Colors.white: AppColors.buttonsColor),),
                      //                       Text('29',style: TextStyle(color: s_5 == true?Colors.white:AppColors.buttonsColor),),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(right: 5),
                      //               child: InkWell(
                      //                 onTap: (){
                      //                   setState(() {
                      //                     s_1=false;
                      //                     s_2=false;
                      //                     s_3=false;
                      //                     s_4=false;
                      //                     s_5=false;
                      //                     s_6=false;
                      //                     s_7=true;
                      //                     s_8=false;
                      //                   });
                      //                 },
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                       color:s_7 == true?AppColors.buttonsColor: Color.fromRGBO(217, 217, 217, 1),
                      //                       border: Border.all(width: 1,color: AppColors.buttonsColor)
                      //                   ),
                      //                   child: Column(
                      //                     children: [
                      //                       Text('today',style: TextStyle(color:s_7 == true?Colors.white: AppColors.buttonsColor),),
                      //                       Text('30',style: TextStyle(color:s_7 == true?Colors.white: AppColors.buttonsColor),),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(right: 5),
                      //               child: InkWell(
                      //                 onTap: (){
                      //                   setState(() {
                      //                     s_1=false;
                      //                     s_2=false;
                      //                     s_3=false;
                      //                     s_4=false;
                      //                     s_5=false;
                      //                     s_6=false;
                      //                     s_7=false;
                      //                     s_8=true;
                      //                   });
                      //                 },
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                       color:s_8 == true?AppColors.buttonsColor: Color.fromRGBO(217, 217, 217, 1),
                      //                       border: Border.all(width: 1,color: AppColors.buttonsColor)
                      //                   ),
                      //                   child: Column(
                      //                     children: [
                      //                       Text('today',style: TextStyle(color:s_8 == true?Colors.white: AppColors.buttonsColor),),
                      //                       Text('31',style: TextStyle(color:s_8 == true?Colors.white: AppColors.buttonsColor),),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         )
                      //     ),
                      //     InkWell(
                      //         onTap: (){
                      //           Utils.date(showDatePicker(context: context,
                      //               initialDate: DateTime.now(),
                      //               firstDate: DateTime.now(),
                      //               lastDate: DateTime.now()) as BuildContext,context);
                      //         },
                      //         child: Icon(Icons.calendar_month,color: AppColors.buttonsColor,size: 50,))
                      //   ],
                      // ),

                      Text('Pickup Date',style: TextStyle(
                          color: AppColors.buttonsColor,
                          fontSize: 18.sp),),
                      SizedBox(height: 2.h,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                                decoration:BoxDecoration(
                                  border: Border.all(width:1,color: AppColors.buttonsColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 5,top: 2,bottom: 2),
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              s_1=true;
                                              s_2=false;
                                              s_3=false;
                                              s_4=false;
                                              s_5=false;
                                              s_6=false;
                                              s_7=false;
                                              s_8=false;
                                              Utils.selectedDate = DateTime.now().toString();
                                              print(Utils.selectedDate);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border:Border.all(width: 1,color: AppColors.buttonsColor),
                                              color: s_1 == true?AppColors.buttonsColor: Colors.white,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                              child: Column(
                                                children: [
                                                  Text(DateFormat('MMMM').format(DateTime.now().add(Duration(days:1))),style: TextStyle(
                                                      color: s_1 == true ?Colors.white: AppColors.buttonsColor,
                                                      fontFamily: 'ArgentumSans'
                                                  ),),
                                                  Text(DateTime.now().day.toString(),style:TextStyle(
                                                    color:s_1 == true? Colors.white:AppColors.buttonsColor,
                                                  )),
                                                  Text('Today',style:TextStyle(
                                                    color:s_1 == true? Colors.white:AppColors.buttonsColor,
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5,top: 2,bottom: 2),
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              s_1=false;
                                              s_2=true;
                                              s_3=false;
                                              s_4=false;
                                              s_5=false;
                                              s_6=false;
                                              s_7=false;
                                              s_8=false;
                                              Utils.selectedDate = DateFormat('dd-MM-y').format(DateTime.now().add(Duration(days: 1))).toString();
                                              print(Utils.selectedDate);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:s_2 == true?AppColors.buttonsColor: Colors.white,
                                              border:Border.all(width:1,color:AppColors.buttonsColor),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                              child: Column(
                                                children: [
                                                  Text(DateFormat('MMMM').format(DateTime.now().add(Duration(days:1))),style: TextStyle(
                                                      color: s_2 == true ?Colors.white: AppColors.buttonsColor,
                                                      fontFamily: 'ArgentumSans'
                                                  ),),
                                                  Text(DateFormat('d').format(DateTime.now().add(Duration(days: 1))).toString(),style: TextStyle(color:s_2 == true?Colors.white: AppColors.buttonsColor),),
                                                  Text(DateFormat('EE').format(DateTime.now().add(Duration(days: 1))).toString(),style: TextStyle(color:s_2 == true?Colors.white: AppColors.buttonsColor),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5,top: 2,bottom: 2),
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              s_1=false;
                                              s_2=false;
                                              s_3=true;
                                              s_4=false;
                                              s_5=false;
                                              s_6=false;
                                              s_7=false;
                                              s_8=false;
                                              Utils.selectedDate = DateFormat('dd-MM-y').format(DateTime.now().add(Duration(days: 2))).toString();
                                              print(Utils.selectedDate);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:s_3==true?AppColors.buttonsColor: Colors.white,
                                                border:Border.all(width: 1,color:AppColors.buttonsColor)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                              child: Column(
                                                children: [
                                                  Text(DateFormat('MMMM').format(DateTime.now().add(Duration(days:1))),style: TextStyle(
                                                      color: s_3 == true ?Colors.white: AppColors.buttonsColor,
                                                      fontFamily: 'ArgentumSans'
                                                  ),),
                                                  Text(DateFormat('d').format(DateTime.now().add(Duration(days: 2))).toString(),style: TextStyle(color: s_3 ==true?Colors.white:AppColors.buttonsColor),),
                                                  Text(DateFormat('EE').format(DateTime.now().add(Duration(days: 2))).toString(),style: TextStyle(color:s_3 ==true?Colors.white: AppColors.buttonsColor),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5,top: 2,bottom: 2),
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              s_1=false;
                                              s_2=false;
                                              s_3=false;
                                              s_4=true;
                                              s_5=false;
                                              s_6=false;
                                              s_7=false;
                                              s_8=false;
                                              Utils.selectedDate = DateFormat('dd-MM-y').format(DateTime.now().add(Duration(days: 2))).toString();
                                              print(Utils.selectedDate);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: s_4== true? AppColors.buttonsColor:Colors.white,
                                                border: Border.all(width: 1,color: AppColors.buttonsColor)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                              child: Column(
                                                children: [
                                                  Text(DateFormat('MMMM').format(DateTime.now().add(Duration(days:1))),style: TextStyle(
                                                      color: s_4 == true ?Colors.white: AppColors.buttonsColor,
                                                      fontFamily: 'ArgentumSans'
                                                  ),),
                                                  Text(DateFormat('d').format(DateTime.now().add(Duration(days: 3))).toString(),style: TextStyle(color:  s_4 == true?Colors.white:AppColors.buttonsColor),),
                                                  Text(DateFormat('EE').format(DateTime.now().add(Duration(days: 3))).toString(),style: TextStyle(color: s_4 == true?Colors.white: AppColors.buttonsColor),),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5,bottom: 2,top: 2),
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              s_1=false;
                                              s_2=false;
                                              s_3=false;
                                              s_4=false;
                                              s_5=true;
                                              s_6=false;
                                              s_7=false;
                                              s_8=false;
                                              Utils.selectedDate = DateFormat('dd-MM-y').format(DateTime.now().add(Duration(days: 4))).toString();
                                              print(Utils.selectedDate);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:s_5==true?AppColors.buttonsColor: Colors.white,
                                                border: Border.all(width: 1,color: AppColors.buttonsColor)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                              child: Column(
                                                children: [
                                                  Text(DateFormat('MMMM').format(DateTime.now().add(Duration(days:1))),style: TextStyle(
                                                      color: s_5 == true ?Colors.white: AppColors.buttonsColor,
                                                      fontFamily: 'ArgentumSans'
                                                  ),),
                                                  Text(DateFormat('d').format(DateTime.now().add(Duration(days: 4))).toString(),style: TextStyle(color: s_5 == true?Colors.white:AppColors.buttonsColor),),
                                                  Text(DateFormat('EEEE').format(DateTime.now().add(Duration(days: 4))).toString(),style: TextStyle(color:s_5 == true?Colors.white: AppColors.buttonsColor),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              s_1=false;
                                              s_2=false;
                                              s_3=false;
                                              s_4=false;
                                              s_5=false;
                                              s_6=false;
                                              s_7=true;
                                              s_8=false;
                                              Utils.selectedDate = DateFormat('dd-MM-y').format(DateTime.now().add(Duration(days: 5))).toString();
                                              print(Utils.selectedDate);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:s_7 == true?AppColors.buttonsColor: Colors.white,
                                                border: Border.all(width: 1,color: AppColors.buttonsColor)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                              child: Column(
                                                children: [
                                                  Text(DateFormat('MMMM').format(DateTime.now().add(Duration(days:6))),style: TextStyle(
                                                      color: s_7 == true ?Colors.white: AppColors.buttonsColor,
                                                      fontFamily: 'ArgentumSans'
                                                  ),),
                                                  Text(DateFormat('d').format(DateTime.now().add(Duration(days: 5))).toString(),style: TextStyle(color:s_7 == true?Colors.white: AppColors.buttonsColor),),
                                                  Text(DateFormat('EE').format(DateTime.now().add(Duration(days: 5))).toString(),style: TextStyle(color:s_7 == true?Colors.white: AppColors.buttonsColor),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              s_1=false;
                                              s_2=false;
                                              s_3=false;
                                              s_4=false;
                                              s_5=false;
                                              s_6=false;
                                              s_7=false;
                                              s_8=true;
                                              Utils.selectedDate = DateFormat('dd-MM-y').format(DateTime.now().add(Duration(days: 6))).toString();
                                              print(Utils.selectedDate);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:s_8 == true?AppColors.buttonsColor: Colors.white,
                                                border: Border.all(width: 1,color: AppColors.buttonsColor)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                              child: Column(
                                                children: [
                                                  Text(DateFormat('MMMM').format(DateTime.now().add(Duration(days:6 ))),style: TextStyle(
                                                      color: s_8 == true ?Colors.white: AppColors.buttonsColor,
                                                      fontFamily: 'ArgentumSans'
                                                  ),),
                                                  Text(DateFormat('d').format(DateTime.now().add(Duration(days: 6))).toString(),style: TextStyle(color:s_8 == true?Colors.white: AppColors.buttonsColor),),
                                                  Text(DateFormat('EE').format(DateTime.now().add(Duration(days: 6))).toString(),style: TextStyle(color:s_8 == true?Colors.white: AppColors.buttonsColor),),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),

                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: (){
                                Utils.date(showDatePicker(context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100)) as BuildContext,context);
                              },
                              child: Icon(Icons.calendar_month,color: AppColors.buttonsColor,size: 50,)),
                        ],
                      ),

                      Text('Pickup Time',style:TextStyle(
                        color: AppColors.buttonsColor,
                        fontSize: 18.sp,
                      )),
                      SizedBox(height: 2.h,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1,color: AppColors.buttonsColor),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    time1=true;
                                    time2=false;
                                    time3=false;
                                    if(time1== true){
                                      setState(() {
                                        Utils.selectedTime = '09:00AM 12:00PM';
                                        print(Utils.selectedTime);
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: time1==true? AppColors.buttonsColor:Colors.white,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomLeft: Radius.circular(25))
                                  ),
                                  child: Column(
                                    children: [
                                      Text('09:00 AM',style: TextStyle(color: time1==true?Colors.white:AppColors.buttonsColor),),
                                      Text('12:00 PM',style: TextStyle(color: time1==true?Colors.white:AppColors.buttonsColor)),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    time1=false;
                                    time2=true;
                                    time3=false;
                                    setState(() {
                                      if(time2==true){
                                        setState(() {
                                          Utils.selectedTime = '12:00PM 03:00PM';
                                          print(Utils.selectedTime);
                                        });
                                      }
                                    });
                                  });
                                },
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color:time2==true? AppColors.buttonsColor:Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Text('12:00 PM',style: TextStyle(color: time2==true?Colors.white:AppColors.buttonsColor)),
                                      Text('03:00 PM',style: TextStyle(color: time2==true?Colors.white:AppColors.buttonsColor)),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    time1=false;
                                    time2=false;
                                    time3=true;
                                    if(time3 == true){
                                      setState(() {
                                        Utils.selectedTime = "03:00PM 06:00PM";
                                        print(Utils.selectedTime);
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: time3==true? AppColors.buttonsColor:Colors.white,
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(25),bottomRight: Radius.circular(25))
                                  ),
                                  child: Column(
                                    children: [
                                      Text('03:00 PM',style: TextStyle(color: time3==true?Colors.white:AppColors.buttonsColor)),
                                      Text('06:00 PM',style: TextStyle(color: time3==true?Colors.white:AppColors.buttonsColor)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h,),
                      SizedBox(height: 10.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, RoutesName.chatgptslide);
                            },
                            child: Container(
                              width:150,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: AppColors.buttonsColor,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0,right: 20),
                                child: SizedBox(
                                  child: Lottie.asset('assets/lottie/lf30_editor_jlqta0sn.json'),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
              if(snapshot.hasError){
                return Text('Failed to fetch data...');
              }
              return Text('something went wrong....');
            }
          ),
        ),
      ),
    );
  }
}
