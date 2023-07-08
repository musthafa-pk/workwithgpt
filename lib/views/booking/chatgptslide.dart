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

class CarouselSlide extends StatefulWidget {
  const CarouselSlide({Key? key}) : super(key: key);

  @override
  State<CarouselSlide> createState() => _CarouselSlideState();
}

class _CarouselSlideState extends State<CarouselSlide> {
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
  List<dynamic> filteredItems = [];
  List<Map<String, dynamic>> mainSlides = [
    {
      'id': 1,
      'segmentedValue': 'Carton',
      'sizeValue': 'Small',
      'subSlides': [
        {
          'id': 1,
          'segmentedValue': 'Carton',
          'sizeValue': 'Small',
          'length': '',
          'width': '',
          'height': '',
          'count': '',
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
        'subSlides': [
          {
            'id': 1,
            'segmentedValue': 'Carton',
            'sizeValue': 'Small',
            'length': '',
            'width': '',
            'height': '',
            'count': '',
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
      });
    });
  }

  void removeSubSlide(int mainSlideIndex, int subSlideId) {
    setState(() {
      mainSlides[mainSlideIndex]['subSlides']
          .removeWhere((subSlide) => subSlide['id'] == subSlideId);
    });
  }
  // TextEditingController length = TextEditingController();
  // TextEditingController width = TextEditingController();
  // TextEditingController height = TextEditingController();
  // TextEditingController count = TextEditingController();

  List<TextEditingController> lengthControllers = [];
  List<TextEditingController> widthControllers = [];
  List<TextEditingController> heightControllers = [];
  List<TextEditingController> countControllers = [];

  FocusNode lengthNode = FocusNode();
  FocusNode widthNode = FocusNode();
  FocusNode heightNode = FocusNode();
  FocusNode countNode = FocusNode();

  bool small = false;
  bool medium = false;
  bool large = false;
  bool extralarge = false;

  final _formKey = GlobalKey<FormState>();
  int userId = 85;

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
  void initState() {
    // TODO: implement initState
    fetchAddressBookDetails(userId).then((fetchedAddressDetails) {
      final List<dynamic> allItems = fetchedAddressDetails != null ? json.decode(fetchedAddressDetails) as List<dynamic> : [];
      filteredItems = allItems.where((value) => value['category'].toString().toLowerCase() == 'To').toList();
      print('its worrrrrrrrkin........');
      setState(() {
        // Update the state to trigger a rebuild
      });
    }).catchError((error) {
      // Handle any errors that occur during the fetch operation
      print('Error occurred during address book fetch: $error');
    });
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
                  lengthControllers.clear();
                  widthControllers.clear();
                  heightControllers.clear();
                  countControllers.clear();

                  for (int i = 0; i < mainSlide['subSlides'].length; i++) {
                    lengthControllers.add(TextEditingController());
                    widthControllers.add(TextEditingController());
                    heightControllers.add(TextEditingController());
                    countControllers.add(TextEditingController());

                    final subSlide = mainSlide['subSlides'][i];
                    lengthControllers[i].text = subSlide['length'];
                    widthControllers[i].text = subSlide['width'];
                    heightControllers[i].text = subSlide['height'];
                    countControllers[i].text = subSlide['count'];
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
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 3.0,
                                          right: 3.0,
                                          top: 1,
                                          bottom: 1),
                                      child: Text(
                                        '${mainIndex + 1}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              'Pick Drop',
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(100),
                            //     border: Border.all(width: 1,color: AppColors.buttonsColor)
                            //   ),
                            //   child: CustomDropdown(
                            //     onChanged: (value) {
                            //       setState(() {
                            //         print(mainSlide['dropdownValue']);
                            //       });
                            //     },
                            //     options: ['a','b','c'],
                            //   ),
                            // ),
                            SizedBox(
                              height: 10,
                            ),

                            // Container(
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(25),
                            //     border:Border.all(width: 1,color: AppColors.buttonsColor),
                            //   ),
                            //   child:CustomDropdown(
                            //     hintText: Utils.selectedFromAddress.toString(),
                            //     options: filteredItems
                            //         .map((value) => value['address_label'].toString())
                            //         .toList(),
                            //     onChanged: (value) {
                            //       final selectedAddress = filteredItems.firstWhere((item) => item['address_label'].toString() == value);
                            //       setState(() {
                            //         Utils.selectedFromAddress = selectedAddress;
                            //         Utils.selectedTradeName = selectedAddress['address_label'].toString();
                            //         Utils.selectedPin = selectedAddress['address']['pin'].toString();
                            //         Utils.selectedLatitude = double.parse(selectedAddress['latitude'].toString());
                            //         Utils.selectedLongitude = double.parse(selectedAddress['longitude'].toString());
                            //         Utils.selectedDistrict = selectedAddress['district'].toString();
                            //         Utils.selectedLocality = selectedAddress['locality'].toString();
                            //         print(Utils.selectedFromAddress.toString());
                            //       });
                            //     },
                            //   ),
                            //
                            //
                            // ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: AppColors.buttonsColor),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: DropdownButton<String>(
                                    value: mainSlide['dropdownValue'],
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        mainSlide['dropdownValue'] = newValue!;
                                      });
                                    },
                                    underline: Container(),
                                    isExpanded: true,
                                    alignment: Alignment.centerRight,
                                    items: [
                                      DropdownMenuItem(
                                        value: 'Option 1',
                                        child: Text('Option ONe'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Option 2',
                                        child: Text('Option Two'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Option 3',
                                        child: Text('Option Three'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.0),

                            CarouselSlider.builder(
                              itemCount: mainSlide['subSlides'].length,
                              itemBuilder: (context, subIndex, realIndex) {
                                final subSlide =
                                    mainSlide['subSlides'][subIndex];
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.black12),
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
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors.buttonsColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3.0,
                                                          right: 3.0,
                                                          top: 2,
                                                          bottom: 2),
                                                  child: Text(
                                                    '${subIndex + 1}',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 16.0,
                                        ),
                                        Text(
                                          'Type',
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          // width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                width: 1,
                                                color: AppColors.buttonsColor),
                                          ),
                                          child: ToggleButtons(
                                            selectedColor: Colors.white,
                                            color: Colors.black,
                                            fillColor: AppColors.buttonsColor,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20)),
                                            constraints: BoxConstraints(
                                              minWidth: 110,
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
                                              subSlide['segmentedValue'] ==
                                                  'Carton',
                                              subSlide['segmentedValue'] ==
                                                  'Bag/Sack',
                                              subSlide['segmentedValue'] ==
                                                  'Other',
                                            ],
                                            onPressed: (int newIndex) {
                                              setState(() {
                                                if (newIndex == 0) {
                                                  subSlide['segmentedValue'] =
                                                      'Carton';
                                                } else if (newIndex == 1) {
                                                  subSlide['segmentedValue'] =
                                                      'Bag/Sack';
                                                } else {
                                                  subSlide['segmentedValue'] =
                                                      'Other';
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        if (subSlide['segmentedValue'] ==
                                            'Carton') ...[
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        subSlide['sizeValue'] =
                                                            'S';
                                                        small = true;
                                                        medium = false;
                                                        large = false;
                                                        extralarge = false;
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: small == false
                                                              ? Color.fromRGBO(
                                                                  10, 8, 100, 1)
                                                              : AppColors
                                                                  .buttonsColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                          child: Image.asset(
                                                              './assets/images/smallman.png')),
                                                    ),
                                                  ),
                                                  small == true
                                                      ? Text(
                                                          'Small',
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
                                                        subSlide['sizeValue'] =
                                                            'M';
                                                        small = false;
                                                        medium = true;
                                                        large = false;
                                                        extralarge = false;
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: medium == false
                                                              ? Color.fromRGBO(
                                                                  10, 8, 100, 1)
                                                              : AppColors
                                                                  .buttonsColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                          child: Image.asset(
                                                              './assets/images/mediumman.png')),
                                                    ),
                                                  ),
                                                  medium == true
                                                      ? Text(
                                                          'Medium',
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
                                                        subSlide['sizeValue'] =
                                                            'L';
                                                        small = false;
                                                        medium = false;
                                                        large = true;
                                                        extralarge = false;
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: large == false
                                                              ? Color.fromRGBO(
                                                                  10, 8, 100, 1)
                                                              : AppColors
                                                                  .buttonsColor,
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
                                                  large == true
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
                                                        subSlide['sizeValue'] =
                                                            'XL';
                                                        small = false;
                                                        medium = false;
                                                        large = false;
                                                        extralarge = true;
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: extralarge ==
                                                                  false
                                                              ? Color.fromRGBO(
                                                                  10, 8, 100, 1)
                                                              : AppColors
                                                                  .buttonsColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                          child: Image.asset(
                                                              './assets/images/extralarge man.png')),
                                                    ),
                                                  ),
                                                  extralarge == true
                                                      ? Text(
                                                          'X Large',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      : Text(''),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                        if (subSlide['segmentedValue'] ==
                                            'Other') ...[
                                          SizedBox(height: 16.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    'Length',
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
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
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
                                                              lengthControllers[
                                                                  subIndex],
                                                          focusNode: lengthNode,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: 'Length',
                                                          ),
                                                          onFieldSubmitted:
                                                              (value) {
                                                            setState(() {
                                                              print(value);
                                                              subSlide[
                                                                      'length'] =
                                                                  lengthControllers[
                                                                          subIndex]
                                                                      .text;
                                                              Utils.fieldFocusChange(
                                                                  context,
                                                                  lengthNode,
                                                                  widthNode);
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
                                                    'Width',
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
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
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
                                                              widthControllers[
                                                                  subIndex],
                                                          focusNode: widthNode,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: 'width',
                                                          ),
                                                          onFieldSubmitted:
                                                              (value) {
                                                            setState(() {
                                                              subSlide[
                                                                      'width'] =
                                                                  widthControllers[
                                                                          subIndex]
                                                                      .text;
                                                              Utils.fieldFocusChange(
                                                                  context,
                                                                  widthNode,
                                                                  heightNode);
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
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
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
                                                          focusNode: heightNode,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: 'height',
                                                          ),
                                                          onFieldSubmitted:
                                                              (value) {
                                                            setState(() {
                                                              subSlide[
                                                                      'height'] =
                                                                  heightControllers[
                                                                          subIndex]
                                                                      .text;
                                                              Utils.fieldFocusChange(
                                                                  context,
                                                                  heightNode,
                                                                  countNode);
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
                                        if (subSlide['segmentedValue'] ==
                                            'Bag/Sack') ...[
                                          SizedBox(height: 16.0),
                                          Text(
                                            'Size',
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            // width:MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        AppColors.buttonsColor),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: ToggleButtons(
                                              selectedColor: Colors.white,
                                              color: Colors.black,
                                              fillColor: AppColors.buttonsColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20)),
                                              constraints: BoxConstraints(
                                                minWidth: 110,
                                                minHeight: 50,
                                              ),
                                              children: [
                                                Text('Small'),
                                                Text('Medium'),
                                                Text('Large'),
                                              ],
                                              isSelected: [
                                                subSlide['sizeValue'] ==
                                                    'Small',
                                                subSlide['sizeValue'] ==
                                                    'Medium',
                                                subSlide['sizeValue'] ==
                                                    'Large',
                                              ],
                                              onPressed: (int newSizeIndex) {
                                                setState(() {
                                                  if (newSizeIndex == 0) {
                                                    subSlide['sizeValue'] =
                                                        'Small';
                                                  } else if (newSizeIndex ==
                                                      1) {
                                                    subSlide['sizeValue'] =
                                                        'Medium';
                                                  } else {
                                                    subSlide['sizeValue'] =
                                                        'Large';
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                if (subSlide['sizeValue'] ==
                                                    'Small') ...[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      SizedBox(
                                                          height: 100,
                                                          child: Image.asset(
                                                              './assets/images/sack.png')),
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
                                                if (subSlide['sizeValue'] ==
                                                    'Medium') ...[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      SizedBox(
                                                          height: 100,
                                                          child: Image.asset(
                                                              './assets/images/sack.png')),
                                                      Text(
                                                        '25 Kg',
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
                                                if (subSlide['sizeValue'] ==
                                                    'Large') ...[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      SizedBox(
                                                          height: 100,
                                                          child: Image.asset(
                                                              './assets/images/sack.png')),
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
                                                ]
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
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppColors
                                                          .buttonsColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: 'count',
                                                    ),
                                                    controller:
                                                        countControllers[
                                                            subIndex],
                                                    focusNode: countNode,
                                                    onFieldSubmitted: (value) {
                                                      setState(() {
                                                        subSlide['count'] =
                                                            countControllers[
                                                                    subIndex]
                                                                .text;
                                                        Utils.fieldFocusChange(
                                                            context,
                                                            countNode,
                                                            lengthNode);
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        FutureBuilder(
                                          future: Utils.getIndividualCost(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                  '${snapshot.error} occurred',
                                                ),
                                              );
                                            } else if (snapshot.hasData) {
                                              final data = snapshot.data
                                                  as Map<String, dynamic>;
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Price: ₹',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${data['cost'].toString()}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Price: ₹',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Text(
                                                    '0',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                addSubSlide(mainIndex);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.0)),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.0)),
                                              ),
                                              onPressed: () {
                                                removeSubSlide(
                                                    mainIndex, subSlide['id']);
                                              },
                                              child: Text('Delete'),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16.0),
                                      ],
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
                                          style: TextStyle(
                                              color: AppColors.buttonsColor),
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
                  height: 800.0,
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
                    color: _currentMainSlideIndex == slideIndex
                        ? Colors.blue
                        : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            InkWell(
              onTap: () {
                showAlertDialog(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: AppColors.buttonsColor),
                    borderRadius: BorderRadius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Calculate Price',
                    style: TextStyle(
                      color: AppColors.buttonsColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
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
              fontSize: 15,),
          ),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xfff05acff),
            minimumSize: const Size(120, 40),
            maximumSize: const Size(120, 40),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40))),
        onPressed:(){
          Utils.createOrder(Order(
              from: Utils.selectedFromAddress.toString(),
              date: Utils.selectedDate.toString(),
              user: 'Musthafa',
              payment: 'from App',
              shipment:[
                Shipment(
                  to: Utils.todistrictSelected.toString(),
                  cost:1000 ,
                  products: [
                    Product(
                      product: 'book',
                      type: 'carton',
                      size: 'S',
                      count: 2,
                    ),
                    Product(
                        product: 'rice',
                        type: 'sack',
                        size: 'M',
                        count: 3),
                  ],
                ),
                Shipment(
                    to: Utils.selectedDropAddress.toString(),
                    cost: 2000,
                    products: [
                      Product(
                        product: 'Cement',
                        type: 'sack',
                        size: "S",
                        count: 3,
                      ),
                    ]
                )
              ]));
          Navigator.pushNamed(context, RoutesName.orderPlacedSplash);

          void resetButtonClicked() {
            setState(() {
              // clear other variables
            });
          }
          resetButtonClicked();
        }
    );
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height*0.45,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.blue[50],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow:[
            BoxShadow(
              blurRadius: 20,
              color: Colors.blue.shade100,
            ) ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              const Text(
                "Total Price",
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black38),
              ),
              const SizedBox(height: 5,),
              totalPrice==null? const CircularProgressIndicator() :
              // Text("₹${totalPrice==null? '0':totalPrice.toStringAsFixed(0)}"
              Text('0'
                  ,style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10,),
              Text('Please note that this amount is based on the inputs provided during the booking process, '
                  'it might be revised in case of significant variations',
                  textAlign: TextAlign.center,
                  style:AppStyles.stylesdrop,
                // TextStyle(fontWeight: FontWeight.bold,color: Colors.black38,fontSize: 14)
              )
              ,const SizedBox(height: 20,)
              , const Text('Booking Advance',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black38)),
              const SizedBox(height: 5,),
              bookingAdvance==null? const CircularProgressIndicator() :
              // Text("₹${bookingAdvance.toStringAsFixed(0)}",
              Text('0',
                  style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.blue)),
              const SizedBox(height: 10,),
              Text('This is non-refundable, however can be adjusted in case of date changes',
                  textAlign: TextAlign.center,
                  style: AppStyles.stylesdrop
                // TextStyle(fontWeight: FontWeight.bold,color: Colors.black38,fontSize: 14)
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
