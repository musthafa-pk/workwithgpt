import 'dart:convert';

import 'package:chaavie_customer/res/components/animated_toggle_button.dart';
import 'package:chaavie_customer/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../res/app_colors.dart';
import '../../res/app_url.dart';
import '../../res/components/Booking Screen Components/custom_dropdown.dart';
import '../../utils/utils.dart';
import 'package:http/http.dart' as http;

class AddMyAddressPage extends StatefulWidget {
  const AddMyAddressPage({Key? key}) : super(key: key);

  @override
  State<AddMyAddressPage> createState() => _AddMyAddressPageState();
}

class _AddMyAddressPageState extends State<AddMyAddressPage> {
  TextEditingController trade_name = TextEditingController();
  TextEditingController bldngno = TextEditingController();
  TextEditingController locality = TextEditingController();
  TextEditingController contact = TextEditingController();

  FocusNode trade_name_node = FocusNode();
  FocusNode bldngno_node = FocusNode();
  FocusNode locality_node = FocusNode();
  FocusNode contact_node = FocusNode();

  var pickupLatitude;
  var pickupLongitude;
  var pin;
  String? place;

  bool success = false;

  String selectedDistrict = 'Districts';
  String? selectedLocality = 'Localites';
  List<String> Districts = [];
  List<String> Localities = [];

  Future<List<String>> getDistricts() async {
    final url = Uri.parse('http://192.168.1.4:3000/orders/getdistricts');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        final districts = List<String>.from(jsonData['districts']);
        return districts;
      } else {
        print('API call failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }

  Future<List<String>> getLocalities() async {
    final url2 = Uri.parse('http://192.168.1.4:3000/orders/get_locality');

    try {
      final response = await http.post(url2, body: {
        'district': selectedDistrict!,
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        final locality = List<String>.from(jsonData['locality']);
        return locality;
      } else {
        print('API call failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }

  Future<void> createAddress() async {
    var url = Uri.parse('http://192.168.1.4:3000/addressbook/85');

    var body = jsonEncode({
      "address": {
        "building": "abcd",
        "place": "calicut",
        "pin": pin.toString(),
      },
      "district": selectedDistrict.toString(),
      "locality": selectedLocality.toString(),
      "address_label": trade_name.text,
      "contact": contact.text,
      "category": Utils.selectedCategory,
      "latitude": pickupLatitude.toString(),
      "longitude": pickupLongitude.toString(),
    });

    var response = await http.post(url, body: body, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
      success = true;
      Utils.flushBarErrorMessage('New Address added.', context);
      print('Post created successfully.');

      // Navigate back to the address page based on the category
      if (Utils.selectedCategory == 'From') {
        Navigator.pushReplacementNamed(context, RoutesName.myAddress);
      } else {
        Navigator.pushReplacementNamed(context, RoutesName.recipientAddress);
      }
    } else {
      success = false;
      Utils.flushBarErrorMessage('Failed.', context);
      print('Failed to create post.');
    }
  }

  Future<void> fetchDistricts() async {
    List<String> fetchedDistricts = await getDistricts();
    setState(() {
      Districts = fetchedDistricts;
    });
  }

  Future<void> fetchLocalities() async {
    List<String> fetchLocalites = await getLocalities();
    setState(() {
      Localities = fetchLocalites;
    });
  }

  @override
  void initState() {
    getDistricts();
    fetchDistricts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Add New Address',
                    style: TextStyle(
                      color: AppColors.buttonsColor,
                      fontSize: 24.sp,
                      fontFamily: 'ArgentumSans',
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Icon(Icons.keyboard_arrow_down_outlined, color: AppColors.buttonsColor, size: 28.sp),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Category',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          SizedBox(
                            width: 150,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: AppColors.buttonsColor),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        Utils.selectedCategory = 'From';
                                        print(' category is :${Utils.selectedCategory}');
                                      });
                                    },
                                    child: Container(
                                      width: 75,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                                        color: Utils.selectedCategory == 'From' ? AppColors.buttonsColor : Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            'From',
                                            style: TextStyle(
                                              color: Utils.selectedCategory == 'From' ? Colors.white : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        Utils.selectedCategory = 'To';
                                        print(' category is :${Utils.selectedCategory}');
                                      });
                                    },
                                    child: Container(
                                      width: 73,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                                        color: Utils.selectedCategory == 'From' ? Colors.white : AppColors.buttonsColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            'To',
                                            style: TextStyle(
                                              color: Utils.selectedCategory == 'To' ? Colors.white : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          Text(
                            'District',
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'ArgentumSans',
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(width: 1, color: AppColors.buttonsColor),
                            ),
                            child: CustomDropdown(
                              hintText: selectedDistrict.toString(),
                              options: Districts,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedDistrict = value ?? 'Districts';
                                  getLocalities();
                                  fetchLocalities();
                                  print('selected District:$selectedDistrict');
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          Text(
                            'Locality',
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'ArgentumSans',
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(width: 1, color: AppColors.buttonsColor),
                            ),
                            child: CustomDropdown(
                              hintText: selectedLocality.toString(),
                              options: Localities,
                              onChanged: (String? value) {
                                setState(() {
                                  getLocalities();
                                  selectedLocality = value ?? 'Localites';
                                  print('selectedLocality:$selectedLocality');
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Trade Name',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16.sp,
                      fontFamily: 'ArgentumSans',
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.buttonsColor),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return Utils.flushBarErrorMessage('Please enter Trade name', context);
                              }
                              return null;
                            },
                            controller: trade_name,
                            focusNode: trade_name_node,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            onFieldSubmitted: (value) {
                              Utils.fieldFocusChange(context, trade_name_node, bldngno_node);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Bldg No / Street Name',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16.sp,
                      fontFamily: 'ArgentumSans',
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.buttonsColor),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: TextFormField(
                          onTap: () async {
                            var place = await PlacesAutocomplete.show(
                              logo: Text(""),
                              context: context,
                              apiKey: AppUrl.gKey,
                              mode: Mode.overlay,
                              types: [],
                              strictbounds: false,
                              components: [
                                Component(Component.country, 'ind')
                              ],
                              onError: (err) {
                                print('error');
                              },
                            );
                            if (place != null) {
                              setState(() {
                                bldngno.text = place.description.toString();
                              });
                              final plist = GoogleMapsPlaces(
                                apiKey: AppUrl.gKey,
                                apiHeaders: await GoogleApiHeaders().getHeaders(),
                              );
                              String placeid = place.placeId ?? '0';
                              final detail = await plist.getDetailsByPlaceId(placeid);
                              final geometry = detail.result.geometry;
                              pickupLatitude = geometry?.location.lat;
                              pickupLongitude = geometry?.location.lng;
                              final addressComponents = detail.result.addressComponents;
                              for (var component in addressComponents) {
                                for (var type in component.types) {
                                  if (type == 'postal_code') {
                                    setState(() {
                                      pin = component.longName;
                                      print(pin);
                                    });
                                  }
                                }
                              }
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return Utils.flushBarErrorMessage('Please enter Building Number', context);
                            }
                            return null;
                          },
                          controller: bldngno,
                          focusNode: bldngno_node,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onFieldSubmitted: (value) {
                            Utils.fieldFocusChange(context, bldngno_node, locality_node);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Contact',
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'ArgentumSans',
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.buttonsColor),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return Utils.flushBarErrorMessage('Please fill contact field', context);
                              }
                              return null;
                            },
                            controller: contact,
                            focusNode: contact_node,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            try {
                              createAddress();
                              print(pin.toString());
                            } catch (e) {
                              throw e;
                            }
                          }
                        },
                        child: SizedBox(
                          width: 150,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.buttonsColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: SizedBox(
                              height: 50,
                              child: Lottie.asset('assets/lottie/lf30_editor_jlqta0sn.json'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
