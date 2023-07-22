import 'dart:convert';
import 'package:chaavie_customer/res/app_colors.dart';
import 'package:chaavie_customer/res/app_styles.dart';
import 'package:chaavie_customer/res/components/Booking%20Screen%20Components/custom_dropdown.dart';
import 'package:chaavie_customer/utils/routes/routes_name.dart';
import 'package:chaavie_customer/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

import '../../model/order/order_model.dart';

class CarouselSlide21th extends StatefulWidget {
  const CarouselSlide21th({Key? key}) : super(key: key);

  @override
  State<CarouselSlide21th> createState() => _CarouselSlide21thState();
}

class _CarouselSlide21thState extends State<CarouselSlide21th> {
  @override
  Widget build(BuildContext context) {
    return CarouselSegmentedButtonPage();
  }
}

class CarouselSegmentedButtonPage extends StatefulWidget {
  @override
  _CarouselSegmentedButtonPageState createState() =>
      _CarouselSegmentedButtonPageState();
}

class _CarouselSegmentedButtonPageState
    extends State<CarouselSegmentedButtonPage> {
  int totalPrice = 0;
  int bookingAdvance = 0;
  dynamic data;

  final PageController _pageController = PageController();

  List<Map<String, dynamic>> mainSlides = [
    {
      'id': 1,
      'segmentedValue': 'Carton',
      'sizeValue': 'Small',
      'from': '',
      'district': '',
      'locality': '',
      'latitude': '',
      'longitude': '',
      'to': '',
      'total_cost': '',
      'subSlides': [
        {
          'id': 1,
          'segmentedValue': 'Carton',
          'sizeValue': 'Small',
          'length': '',
          'width': '',
          'height': '',
          'count': '',
          'product': '',
          'price': 0,
          'priceBycount': 0,
        },
      ],
    },
  ];

  int _currentMainSlideIndex = 0;
  int _currentSubSlideIndex = 0;

  void addMainSlide() {
    if (mainSlides.length >= 5) {
      return;
    }
    int id = mainSlides.isNotEmpty ? mainSlides.last['id'] + 1 : 1;
    setState(() {
      mainSlides.add({
        'id': id,
        'dropdownValue': 'Option 1',
        'segmentedValue': 'Carton',
        'sizeValue': 'Small',
        'from': '',
        'district': '',
        'locality': '',
        'latitude': '',
        'longitude': '',
        'to': '',
        'to_locality': '',
        'to_district': '',
        'to_latitude': '',
        'to_longitude': '',
        'total_cost': '',
        'subSlides': [
          {
            'id': 1,
            'segmentedValue': 'Carton',
            'sizeValue': 'Small',
            'length': '',
            'width': '',
            'height': '',
            'count': '',
            'product': '',
            'price': 0,
            'priceBycount': 0,
          },
        ],
      });
    });
  }

  void removeMainSlide(int id) {
    if (mainSlides.length <= 1) return;
    setState(() {
      mainSlides.removeWhere((slide) => slide['id'] == id);
    });
  }

  void addSubSlide(int mainSlideIndex) {
    int subSlideId = mainSlides[mainSlideIndex]['subSlides'].isNotEmpty
        ? mainSlides[mainSlideIndex]['subSlides'].last['id'] + 1
        : 1;
    setState(() {
      mainSlides[mainSlideIndex]['subSlides'].add({
        'id': subSlideId,
        'dropdownValue': 'Option 1',
        'segmentedValue': 'Carton',
        'sizeValue': 'Small',
        'length': '',
        'width': '',
        'height': '',
        'count': '',
        'product': '',
        'price': 0,
        'piceBycount': 0,
      });
    });
  }

  void removeSubSlide(int mainSlideIndex, int subSlideId) {
    setState(() {
      mainSlides[mainSlideIndex]['subSlides']
          .removeWhere((subSlide) => subSlide['id'] == subSlideId);
    });
  }

  Future<void> updateprice()async {
    setState(() {
      Utils.totalPrice = Utils.priceByItem * int.parse(countControllers.toString());
      print(Utils.totalPrice);
    });
  }
  //
  // void updatetotalprice(){
  //   // int? totalPrice = 0;
  //   // for(var mainSlide in mainSlides){
  //   //   for(var subSlide in mainSlide['subSlide']){
  //   //    totalPrice = (totalPrice! + int.parse(subSlide['priceBycount']));
  //   //   }
  //   // }
  // }
  //
  // void updatePriceBySizeAndCount(Map<String,dynamic> subSlide){
  //
  //   print('worked...');
  //   int price =0;
  //   if(subSlide['sizedValue'] == 'S'){
  //     Utils.getIndividualCost(subSlide['sizedValue']);
  //     price = Utils.priceByItem * int.parse(subSlide['count']);
  //     print(price);
  //   }else if(subSlide['sizedValue'] == 'M'){
  //     Utils.getIndividualCost(subSlide['sizedValue']);
  //     price = Utils.priceByItem * int.parse(subSlide['count']);
  //   }else if(subSlide['sizedValue'] == 'L'){
  //     Utils.getIndividualCost(subSlide['sizedValue']);
  //     price = Utils.priceByItem * int.parse(subSlide['count']);
  //   }else if(subSlide['sizedValue'] == 'XL'){
  //     Utils.getIndividualCost(subSlide['sizedValue']);
  //     price = Utils.priceByItem * int.parse(subSlide['count']);
  //     print('its final$price}');
  //   }
  //   subSlide['priceBycount'] = price;
  // }



  // TextEditingController length = TextEditingController();
  // TextEditingController width = TextEditingController();
  // TextEditingController height = TextEditingController();
  // TextEditingController count = TextEditingController();

  List<TextEditingController> productControllers = [];
  List<TextEditingController> lengthControllers = [];
  List<TextEditingController> widthControllers = [];
  List<TextEditingController> heightControllers = [];
  List<TextEditingController> countControllers = [];


  FocusNode productNode = FocusNode();
  FocusNode lengthNode = FocusNode();
  FocusNode widthNode = FocusNode();
  FocusNode heightNode = FocusNode();
  FocusNode countNode = FocusNode();

  bool small = false;
  bool medium = false;
  bool large = false;
  bool extralarge = false;

  final _formKey = GlobalKey<FormState>();

  Future<String?> fetchAddressBook(int userId) async {
    final url = Uri.parse('http://192.168.1.4:3000/addressbook/$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final addressBookDetails = response.body as String;
        return addressBookDetails;
      } else {
        throw Exception(
            'Failed to fetch address book details. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error occurred during address book fetch: $error');
    }
  }

  Future<String?> fetchAddressBookDetails(int userId) async {
    final url = Uri.parse('http://192.168.1.4:3000/addressbook/$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.encode(response.body);
        // final addressBookDetails = jsonData as String?;
        final addressBookDetails = response.body as String;

        return addressBookDetails;
      } else {
        throw Exception(
            'Failed to fetch address book details. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error occurred during address book fetch: $error');
    }
  }

  Future<void> getIndividualCost() async {
    final url = Uri.parse('http://192.168.1.4:3000/orders/get_individual_cost');
    print(Utils.selectedLatitude);

    // Create the request body
    final body = jsonEncode({
      "size": "M",
      "from": {
        "district": Utils.FromAddress[0]['district'].toLowerCase(),
        "locality": Utils.selectedLocality,
        "latitude": Utils.selectedLatitude,
        "longitude": Utils.selectedLongitude,
      },
      "to": {
        "district": Utils.ToAddress[0]['district'].toLowerCase(),
        "locality": Utils.ToAddress[0]['locality'].toLowerCase(),
        "latitude": Utils.selectedDropLatitude,
        "longitude": Utils.selectedDropLongitude,
      }
    });

    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      // Handle the response
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Process the response data here
        // print(responseData);
        Utils.priceByItem = responseData['cost'];
        print('this is value...${Utils.priceByItem}');
        return responseData['cost'];
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void initState() {
    // TODO: implement initStat
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Shipment Details',
                    style: TextStyle(
                      color: AppColors.buttonsColor,
                      fontSize: 22,
                      fontFamily: 'ArgentumSans',
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    color: AppColors.buttonsColor,
                    size: 50,
                  )
                ],
              ),
            ),
            Expanded(
              child: CarouselSlider.builder(
                itemCount: mainSlides.length,
                itemBuilder: (context, mainIndex, realIndex) {
                  final mainSlide = mainSlides[mainIndex];

                  productControllers.clear();
                  lengthControllers.clear();
                  widthControllers.clear();
                  heightControllers.clear();
                  countControllers.clear();

                  for (int i = 0; i < mainSlide['subSlides'].length; i++) {
                    productControllers.add(TextEditingController());
                    lengthControllers.add(TextEditingController());
                    widthControllers.add(TextEditingController());
                    heightControllers.add(TextEditingController());
                    countControllers.add(TextEditingController());

                    final subSlide = mainSlide['subSlides'][i];
                    lengthControllers[i].text = subSlide['length'];
                    widthControllers[i].text = subSlide['width'];
                    heightControllers[i].text = subSlide['height'];
                    countControllers[i].text = subSlide['count'];
                    productControllers[i].text = subSlide['product'];

                  }

                  return SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.buttonsColor,
                                        borderRadius: BorderRadius.circular(100)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 3.0, right: 3.0, top: 1, bottom: 1),
                                      child: Text('${mainIndex + 1}', style: TextStyle(color: Colors.white),),))
                              ],
                            ),
                            SizedBox(height: 16.0,),
                            Text('Drop Location', style: TextStyle(color: Colors.black54,),),
                            SizedBox(height: 10.0,),
                            SizedBox(height: 10,),

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    width: 1, color: AppColors.buttonsColor),
                              ),
                              child: FutureBuilder(
                                  future: fetchAddressBook(Utils.userId),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final addressBookDetails = json.decode(snapshot.data!) as List<dynamic>;
                                      final filteredItems = addressBookDetails.where((item) => item['category'] == 'To').toList();
                                      return CustomDropdown(
                                        hintText:'pick an address',
                                        options: filteredItems.map((value) => value['address_label'].toString()).toList(),
                                        onChanged: (value) {
                                          final selectedAddress = filteredItems.firstWhere((item) => item['address_label'].toString() == value);
                                          mainSlide['to'] = filteredItems.firstWhere((item) => item['address_label'].toString() == value);
                                          Utils.ToAddress.add(selectedAddress);
                                          print('To Address${mainSlide['to']['address_label']}');
                                          setState(() {
                                            Utils.selectedDropLatitude = double.parse(selectedAddress['latitude']);
                                            Utils.selectedDropLongitude = double.parse(selectedAddress['longitude']);
                                            // Utils.orderdetails.add({
                                            //   'from': Utils.FromAddress[0]['address_label'],
                                            //   'date': Utils.selectedDate,
                                            //   'user': 'deepak',
                                            //   'payement': Utils.payement,
                                            //   'shipment': Utils.shipmentList,
                                            // });
                                          });
                                          print(Utils.orderdetails);
                                        },
                                      );
                                    }
                                    if (snapshot.hasError) {
                                      return Text(snapshot.error.toString());
                                    }
                                    return Text('Something wrong...');
                                  }),
                            ),

                            SizedBox(height: 16.0),

                            CarouselSlider.builder(
                              itemCount: mainSlide['subSlides'].length,
                              itemBuilder: (context, subIndex, realIndex) {
                                final subSlide = mainSlide['subSlides'][subIndex];
                                return SingleChildScrollView(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: Colors.black12),
                                    ),
                                    padding: EdgeInsets.all(16.0),
                                    child: Form(
                                      // key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 10,),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColors.buttonsColor,
                                                      borderRadius:
                                                      BorderRadius.circular(100)),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.only(left: 3.0, right: 3.0, top: 2, bottom: 2),
                                                    child: Text('${subIndex + 1}', style: TextStyle(color: Colors.white),),
                                                  ))
                                            ],
                                          ),
                                          Text('Product Details', style: TextStyle(color: Colors.black54),),
                                          SizedBox(height: 10,),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                border: Border.all(width: 1, color: AppColors.buttonsColor)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: TextFormField(
                                                controller: productControllers[subIndex],
                                                focusNode: productNode,
                                                onFieldSubmitted: (value) {
                                                  setState(() {
                                                    subSlide['product'] = productControllers[subIndex].text;
                                                    print('To Address :${mainSlide['to']['address_label']}');
                                                    print('product details :${subSlide['product']}');
                                                  });
                                                  Utils.fieldFocusChange(context, productNode, lengthNode);
                                                },
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Product Details'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16.0,),
                                          Text('Type', style: TextStyle(color: Colors.black54),),
                                          SizedBox(height: 10.0,),
                                          Container(
                                            // width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(100),
                                              border: Border.all(width: 1, color: AppColors.buttonsColor),
                                            ),
                                            child: ToggleButtons(
                                              selectedColor: Colors.white,
                                              color: Colors.black,
                                              fillColor: AppColors.buttonsColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                  bottomRight: Radius.circular(20)),
                                              constraints: BoxConstraints(
                                                minWidth: MediaQuery.of(context).size.width / 3.6,
                                                minHeight: 50,
                                              ),
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text('Carton'),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text('Bag/Sack'),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text('Other'),
                                                  ],
                                                ),
                                              ],
                                              renderBorder: false,
                                              isSelected: [
                                                subSlide['segmentedValue'] == 'Carton',
                                                subSlide['segmentedValue'] == 'Bag/Sack',
                                                subSlide['segmentedValue'] == 'Other',
                                              ],
                                              onPressed: (int newIndex) {
                                                setState(() {
                                                  if (newIndex == 0) {
                                                    subSlide['segmentedValue'] = 'Carton';
                                                    print('selected type:${subSlide['segmentedValue']}');
                                                  } else if (newIndex == 1) {
                                                    subSlide['segmentedValue'] = 'Bag/Sack';
                                                    print('selected type:${subSlide['segmentedValue']}');
                                                  } else {
                                                    subSlide['segmentedValue'] = 'Other';
                                                    print('selected type:${subSlide['segmentedValue']}');
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          if (subSlide['segmentedValue'] == 'Carton') ...[
                                            SizedBox(height: 10.0,),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          subSlide['sizedValue'] = 'S';
                                                          print('selected carton size : ${subSlide['sizedValue']}');
                                                          small = true;
                                                          medium = false;
                                                          large = false;
                                                          extralarge = false;
                                                          Utils.selected = 'S';
                                                          Utils.selectedSize = subSlide['sizedValue'];
                                                          Utils.getIndividualCost(subSlide['sizedValue']);
                                                          updateprice();
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: subSlide['sizedValue'] == 'S' ? AppColors.buttonsColor : Color.fromRGBO(10, 8, 100, 1),
                                                            borderRadius: BorderRadius.circular(15)),
                                                        child: SizedBox(
                                                            height: 80,
                                                            width: 80,
                                                            child: Image.asset(
                                                                './assets/images/smallman.png')),
                                                      ),
                                                    ),
                                                    subSlide['sizedValue'] == 'S' ?
                                                    Text('Small', style: TextStyle(fontWeight: FontWeight.bold),) : Text(''),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          subSlide['sizedValue'] = 'M';
                                                          print('selected carton size : ${subSlide['sizedValue']}');
                                                          small = false;
                                                          medium = true;
                                                          large = false;
                                                          extralarge = false;
                                                          Utils.getIndividualCost(subSlide['sizedValue']);
                                                          // updateprice();
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: subSlide['sizedValue'] == 'M' ? AppColors.buttonsColor : Color.fromRGBO(10, 8, 100, 1),
                                                            borderRadius: BorderRadius.circular(15)),
                                                        child: SizedBox(
                                                            height: 80,
                                                            width: 80,
                                                            child: Image.asset('./assets/images/mediumman.png')),
                                                      ),
                                                    ),
                                                    subSlide['sizedValue'] == 'M' ? Text('Medium', style: TextStyle(fontWeight: FontWeight.bold),) : Text(''),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          subSlide['sizedValue'] = 'L';
                                                          print('selected carton size : ${subSlide['sizedValue']}');
                                                          small = false;
                                                          medium = false;
                                                          large = true;
                                                          extralarge = false;
                                                          Utils.selectedSize = subSlide['sizeValue'];
                                                          Utils.getIndividualCost(subSlide['sizedValue']);
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: subSlide[
                                                            'sizedValue'] == 'L'
                                                                ? AppColors
                                                                .buttonsColor
                                                                : Color
                                                                .fromRGBO(
                                                                10,
                                                                8,
                                                                100,
                                                                1),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                15)),
                                                        child: SizedBox(
                                                            height: 80,
                                                            width: 80,
                                                            child: Image.asset(
                                                                './assets/images/largeman.png')),
                                                      ),
                                                    ),
                                                    subSlide['sizedValue'] == 'L'
                                                        ? Text(
                                                      'Large',
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                    )
                                                        : Text(''),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          subSlide['sizedValue'] = 'XL';
                                                          print('selected carton size : ${subSlide['sizedValue']}');

                                                          small = false;
                                                          medium = false;
                                                          large = false;
                                                          extralarge = true;
                                                          Utils.selectedSize = subSlide['sizeValue'];
                                                          subSlide['price'] = Utils.priceByItem.toString();
                                                          Utils.getIndividualCost(subSlide['sizedValue']);
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: subSlide['sizedValue'] == 'XL'
                                                                ? AppColors.buttonsColor : Color.fromRGBO(10, 8, 100, 1),
                                                            borderRadius: BorderRadius.circular(15)),
                                                        child: SizedBox(
                                                            height: 80,
                                                            width: 80,
                                                            child: Image.asset('./assets/images/extralarge man.png')),
                                                      ),
                                                    ),
                                                    subSlide['sizedValue'] == 'XL'
                                                        ? Text('X Large',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold),
                                                    )
                                                        : Text(''),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                          if (subSlide['segmentedValue'] == 'Other') ...[
                                            SizedBox(height: 16.0),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text('Length',
                                                      style: TextStyle(
                                                          color: Colors.black54),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    SizedBox(
                                                      width: 100,
                                                      height: 40,
                                                      child: Container(
                                                        decoration:
                                                        BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              100),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: AppColors.buttonsColor),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 10.0),
                                                          child: TextFormField(
                                                            controller:
                                                            lengthControllers[
                                                            subIndex],
                                                            focusNode:
                                                            lengthNode,
                                                            decoration:
                                                            InputDecoration(
                                                              border:
                                                              InputBorder
                                                                  .none,
                                                              hintText:
                                                              'Length',
                                                            ),
                                                            onFieldSubmitted:
                                                                (value) {
                                                              setState(() {
                                                                print(value);
                                                                subSlide['length'] = lengthControllers[subIndex].text;
                                                                Utils.fieldFocusChange(context, lengthNode, widthNode);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text('Width', style: TextStyle(color: Colors.black54),),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    SizedBox(
                                                      width: 100,
                                                      height: 40,
                                                      child: Container(
                                                        decoration:
                                                        BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              100),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: AppColors
                                                                  .buttonsColor),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.only(left: 10.0),
                                                          child: TextFormField(
                                                            controller:
                                                            widthControllers[
                                                            subIndex],
                                                            focusNode:
                                                            widthNode,
                                                            decoration:
                                                            InputDecoration(
                                                              border: InputBorder.none,
                                                              hintText: 'width',
                                                            ),
                                                            onFieldSubmitted: (value) {
                                                              setState(() {
                                                                subSlide['width'] = widthControllers[subIndex].text;
                                                                Utils.fieldFocusChange(context, widthNode, heightNode);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Height',
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black54),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    SizedBox(
                                                      width: 100,
                                                      height: 40,
                                                      child: Container(
                                                        decoration:
                                                        BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              100),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: AppColors
                                                                  .buttonsColor),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 10.0),
                                                          child: TextFormField(
                                                            controller:
                                                            heightControllers[
                                                            subIndex],
                                                            focusNode:
                                                            heightNode,
                                                            decoration:
                                                            InputDecoration(
                                                              border:
                                                              InputBorder
                                                                  .none,
                                                              hintText:
                                                              'height',
                                                            ),
                                                            onFieldSubmitted:
                                                                (value) {
                                                              setState(() {
                                                                subSlide['height'] = heightControllers[subIndex].text;
                                                                Utils.fieldFocusChange(context, heightNode, countNode);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                          if (subSlide['segmentedValue'] == 'Bag/Sack') ...[
                                            SizedBox(height: 16.0),
                                            Text('Size', style: TextStyle(color: Colors.black54),),
                                            SizedBox(height: 10.0,),
                                            Container(
                                              // width:MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppColors
                                                          .buttonsColor),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      100)),
                                              child: ToggleButtons(
                                                selectedColor: Colors.white,
                                                color: Colors.black,
                                                fillColor:
                                                AppColors.buttonsColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft:
                                                  Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                  bottomRight:
                                                  Radius.circular(20),
                                                ),
                                                constraints: BoxConstraints(
                                                  minWidth:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                      3.6,
                                                  minHeight: 50,
                                                ),
                                                children: [
                                                  Text('Small'),
                                                  Text('Medium'),
                                                  Text('Large'),
                                                ],
                                                isSelected: [
                                                  subSlide['sizedValue'] == 'S',
                                                  subSlide['sizedValue'] == 'M',
                                                  subSlide['sizedValue'] == 'L',
                                                ],
                                                onPressed: (int newSizeIndex) {
                                                  setState(() {
                                                    if (newSizeIndex == 0) {
                                                      subSlide['sizedValue'] = 'S';
                                                      print('selected size of bag/sack :${subSlide['sizedValue']}');

                                                    } else if (newSizeIndex == 1) {
                                                      subSlide['sizedValue'] = 'M';
                                                      print('selected size of bag/sack :${subSlide['sizedValue']}');

                                                    } else {
                                                      subSlide['sizedValue'] = 'L';
                                                      print('selected size of bag/sack :${subSlide['sizedValue']}');

                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                children: [
                                                  if (subSlide['sizedValue'] == 'S') ...[
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        SizedBox(
                                                            height: 100,
                                                            child: Image.asset('./assets/images/sack.png')),
                                                        Text(
                                                          '10 Kg',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .buttonsColor,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 22,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                  if (subSlide['sizedValue'] == 'M') ...[
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceAround,
                                                      children: [
                                                        SizedBox(
                                                            height: 100,
                                                            child: Image.asset('./assets/images/sack.png')),
                                                        Text(
                                                          '25 Kg',
                                                          style: TextStyle(
                                                            color: AppColors.buttonsColor,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 22,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                  if (subSlide['sizedValue'] == 'L') ...[
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                      children: [
                                                        SizedBox(
                                                            height: 100,
                                                            child: Image.asset('./assets/images/sack.png')),
                                                        Text(
                                                          '50 Kg',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .buttonsColor,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 22,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ],
                                              ),
                                            )
                                          ],
                                          SizedBox(height: 16.0),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Count',
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              SizedBox(
                                                width: 100,
                                                height: 40,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(width: 1, color: AppColors.buttonsColor),
                                                    borderRadius: BorderRadius.circular(100),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 10.0),
                                                    child: TextFormField(
                                                      keyboardType:
                                                      TextInputType.number,
                                                      decoration:
                                                      InputDecoration(
                                                        border:
                                                        InputBorder.none,
                                                        hintText: 'count',
                                                      ),
                                                      controller: countControllers[subIndex],
                                                      focusNode: countNode,
                                                      onChanged:(value){
                                                        setState(() {
                                                          subSlide['count'] = countControllers[subIndex].text;
                                                          subSlide['count'] = value;
                                                        });
                                                      },
                                                      onFieldSubmitted: (value) {
                                                        subSlide['count'] = countControllers[subIndex].text;
                                                        print('count is :${subSlide['count']}');
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.0,),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Price: ₹',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                subSlide['priceBycount'] == null ? '0' : subSlide['priceBycount'].toString(),
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.0,),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  addSubSlide(mainIndex);
                                                  // Utils.productList.add({
                                                  //   'product': subSlide['product'],
                                                  //   'type': subSlide['segmentedValue'],
                                                  //   'size': subSlide['sizedValue'],
                                                  //   'count': subSlide['count'],
                                                  // });
                                                  // print('product list');
                                                  // print(Utils.productList);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.green,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(100.0)),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.add,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                    Text('Add Item'),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.red,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(100.0)),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    if (subSlide.length <=1)
                                                      removeSubSlide(mainIndex, subSlide['id']);
                                                    subSlide['cost'] = 0;
                                                    Utils.pricebyCount = 0;
                                                  });
                                                },
                                                child: Text('Delete'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                height: 500.0,
                                enlargeCenterPage: true,
                                autoPlay: false,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: false,
                                autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                                viewportFraction: 1.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentSubSlideIndex = index;
                                  });
                                },
                              ),
                            ),

                            SizedBox(height: 16.0),



                            SizedBox(height: 16.0),

                            SizedBox(height: 16.0),
                            //total price
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     Text('Total Price: ₹',
                            //       style: TextStyle(
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: 18,
                            //       ),
                            //     ),
                            //     Text(
                            //       mainSlide['total_cost'].toString(),
                            //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: 10.0,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // ElevatedButton(
                                //   style:ElevatedButton.styleFrom(
                                //     primary:Colors.blue,
                                //     shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(100.0)
                                //     ),
                                //   ),
                                //   onPressed: addMainSlide,
                                //   child: Text('Add Destination'),
                                // ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      addMainSlide();
                                      Utils.shipmentList.add({
                                        'to': Utils.ToAddress[mainIndex]['address_label'],
                                        'cost': Utils.priceByItem,
                                      });
                                      print('shipmentList');
                                      print(Utils.shipmentList);
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.blue),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Add Destination',
                                          style: TextStyle(color: AppColors.buttonsColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (mainSlide.length <= 1) {
                                        return;
                                      }
                                      removeMainSlide(mainSlide['id']);
                                      Utils.shipmentList.removeAt(mainIndex);
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Delete Destination',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // ElevatedButton(
                                //   onPressed: () {
                                //     if(mainSlide.length<=1){
                                //       return;
                                //     }
                                //     removeMainSlide(mainSlide['id']);
                                //   },
                                //   style:ElevatedButton.styleFrom(
                                //     primary:Colors.red,
                                //     shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(100.0)
                                //     ),
                                //   ),
                                //   child: Text('Delete Destination'),
                                // ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 900.0,
                  scrollPhysics: AlwaysScrollableScrollPhysics(),
                  enlargeCenterPage: true,
                  autoPlay: false,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: false,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentMainSlideIndex = index;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: mainSlides.map((slide) {
                int slideIndex = mainSlides.indexOf(slide);
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentMainSlideIndex == slideIndex ? Colors.blue : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),

            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Column(
            //     children: [
            //       Container(
            //         width: MediaQuery.of(context).size.width,
            //         child: Table(
            //           columnWidths: {
            //             0: const FlexColumnWidth(4),
            //             1: const FlexColumnWidth(2 ),
            //
            //           },
            //           border: TableBorder.all(color: Colors.black,width: 0.5,
            //               borderRadius: BorderRadius.circular(10)),
            //           children: [
            //             TableRow(
            //               children: [
            //                 const Padding(
            //                   padding: EdgeInsets.all(8.0),
            //                   child: Center(child:  Text(
            //                     'Total Destination',
            //                     style:TextStyle(
            //                       fontFamily: 'ArgentumSans',
            //                       color: Colors.black54,
            //                     ),
            //                   ),),
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Center(child: Text(
            //                     '1',
            //                     style:const TextStyle(
            //                       fontFamily: 'ArgentumSans',
            //                       color: Colors.black54,
            //                     ),
            //                   )),
            //                 ),
            //               ],),
            //
            //             TableRow(
            //               children: [
            //                 const Padding(
            //                   padding: EdgeInsets.all(8.0),
            //                   child: Center(child:  Text(
            //                     'Total Weight',
            //                     style:TextStyle(
            //                       fontFamily: 'ArgentumSans',
            //                       color: Colors.black54,
            //                     ),
            //                   ),),
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Center(child: Text(
            //                     '0',
            //                     style:const TextStyle(
            //                       fontFamily: 'ArgentumSans',
            //                       color: Colors.black54,
            //                     ),
            //                   )),
            //                 ),
            //               ],),
            //             TableRow(
            //               children: [
            //                 const Padding(
            //                   padding: EdgeInsets.all(8.0),
            //                   child: Center(
            //                       child: Text('Chargeable Weight',
            //                         style:TextStyle(
            //                           fontFamily: 'ArgentumSans',
            //                           color: Colors.white,
            //                           // (0XFFF01244C),
            //                         ),)),
            //                 ),
            //
            //                 Padding(
            //                   padding: EdgeInsets.all(8.0),
            //                   child: Center(child: Text('50.00',
            //                     // Text('${chargeableWeight == null
            //                     //     ? '50' : chargeableWeight.toStringAsFixed(
            //                     //     2)} kg',
            //                     style:const TextStyle(
            //                       fontFamily: 'ArgentumSans',
            //                       color: Colors.white,
            //                       // (0XFFF01244C),
            //                     ),),),
            //                 ),
            //               ],
            //               decoration: const BoxDecoration(color: Color(0xfff05acff),
            //                 borderRadius:BorderRadius.only(
            //                   bottomLeft:Radius.circular(10),
            //                   bottomRight: Radius.circular(10),
            //                 ),
            //               ),),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            InkWell(
              onTap: () {
                showAlertDialog(context);
                print(Utils.orderdetails);

                void findtotalprcie(){
                  for(int i=0;i<=mainSlides.length;i++){
                    setState(() {
                      Utils.totalPrice  = (Utils.totalPrice! + int.parse(mainSlides[i]['total_cost'].toString()))!;
                      print(Utils.totalPrice);
                    });
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: AppColors.buttonsColor),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Calculate Price',
                    style: TextStyle(color: AppColors.buttonsColor,),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0,),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = ElevatedButton(
        child: Container(
          width: 300,
          height: 100,
          alignment: Alignment.center,
          child: const Text(
            'Place Order',
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xfff05acff),
            minimumSize: const Size(120, 40),
            maximumSize: const Size(120, 40),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40))),
        onPressed: () {
          // Utils.createOrder(Order(
          //     from: Utils.selectedFromAddress.toString(),
          //     date: Utils.selectedDate.toString(),
          //     user: 'Musthafa',
          //     payment: 'from App',
          //     shipment:[
          //       Shipment(
          //         to: Utils.todistrictSelected.toString(),
          //         cost:Utils.priceByItem ,
          //         products: [
          //           Product(
          //             product: 'book',
          //             type: 'carton',
          //             size: 'S',
          //             count: 2,
          //           ),
          //           Product(
          //               product: 'rice',
          //               type: 'sack',
          //               size: 'M',
          //               count: 3),
          //         ],
          //       ),
          //       Shipment(
          //           to: Utils.selectedDropAddress.toString(),
          //           cost: Utils.priceByItem,
          //           products: [
          //             Product(
          //               product: 'Cement',
          //               type: 'sack',
          //               size: "S",
          //               count: 3,
          //             ),
          //           ]
          //       )
          //     ]));
          Utils.placeOrder();


          Navigator.pushNamed(context, RoutesName.orderPlacedSplash);

          void resetButtonClicked() {
            setState(() {
              // clear other variables
            });
          }

          resetButtonClicked();
        });
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.blue[50],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.blue.shade100,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Total Price",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black38),
              ),
              const SizedBox(
                height: 5,
              ),
              totalPrice == null
                  ? const CircularProgressIndicator()
                  :
              // Text("₹${totalPrice==null? '0':totalPrice.toStringAsFixed(0)}"
              Text(Utils.totalPrice.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Text(
                  'Please note that this amount is based on the inputs provided during the booking process, '
                      'it might be revised in case of significant variations',
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(fontWeight: FontWeight.bold,color: Colors.black38,fontSize: 14)
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Booking Advance',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black38)),
              const SizedBox(
                height: 5,
              ),
              bookingAdvance == null
                  ? const CircularProgressIndicator()
                  :
              // Text("₹${bookingAdvance.toStringAsFixed(0)}",
              Text('0',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
              const SizedBox(
                height: 10,
              ),
              Text(
                  'This is non-refundable, however can be adjusted in case of date changes',
                  textAlign: TextAlign.center,
                  style:TextStyle(fontWeight: FontWeight.bold,color: Colors.black38,fontSize: 14)
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            cancelButton,
          ],
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
