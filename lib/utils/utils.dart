import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:chaavie_customer/model/myAddress/AddressModel.dart';
import 'package:chaavie_customer/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';

import '../model/order/order_model.dart';
import '../res/app_colors.dart';
import '../res/app_url.dart';
import 'package:http/http.dart' as http;
class Utils{
  //user details
  static String? userName = 'CHAAVIE';
  static int userId = 85;
  static String? userEmail = 'chaavi@gmail.com';
  static String? phoneNumber = '1234567890';
  static String? Profile_imageUrl;
  static String? walletamount = '1234';
  static String? userLocarion = 'Location';
  static String? userDistrict = 'District';
  static String? payement = 'from app';

  // address realated varioubles
  static String? selectedTradeName;
  static String? selectedPin;
  static double? selectedLatitude;
  static double? selectedLongitude;
  static String? selectedDistrict;
  static String? selectedLocality;

  static String? selectedDropTradeName;
  static String? selectedDropPin;
  static double? selectedDropLatitude;
  static double? selectedDropLongitude;
  static String? selectedDropDistrict;
  static String? selectedDropLocality;

  static TextEditingController count = TextEditingController();
  // varioubles
  static String? selectedCategory = 'To';
  static String? selectedFromAddress = 'Pick an address';
  static String? selectedDropAddress = ' pick an address';
  static String? selectedDate;
  static String? selectedTime;

  static String? todistrictSelected;
  static double? coast = 1000;

  static String? product = 'book';
  static String? type = 'carton';
  static String? size = 'S';

  //booking status
  static bool Booking_success = false;
  static bool Booking_failed = false;

  //////
  static int? price;
  static int? bookingAdvance;
  static int? totalPrice;
  static int? maintotalPrice;
  static var pricebyCount;

  static int priceByItem = 0;

  static double advancePrice = 0;
  static double balanceAmout = 0;

  static String? selectedType;
  static String? selectedSize;

  static String? selected;
  static List<Map<String,dynamic>> FromAddress =[];
  static List<Map<String,dynamic>> ToAddress = [];
  static List<Map<String,dynamic>> orderdetails = [];
  static List<Map<String,dynamic>> shipmentList = [];
  static List<Map<String,dynamic>> productList = [];



  static List<AddressModel> selectedMyAddress =[];







//greetings
  static greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning !';
    }
    if (hour < 17) {
      return 'Good Afternoon !';
    }
    return 'Good Evening !';
  }

  //PARSE TIME


  static DateTime parseTime(String time) {
    final parts = time.split(' ');
    final hourMinute = parts[0].split(':');
    final int hour = int.parse(hourMinute[0]);
    final int minute = int.parse(hourMinute[1].substring(0, 2));

    int adjustedHour = hour;
    if (parts[1] == 'PM' && hour < 12) {
      adjustedHour += 12;
    }

    return DateTime(0, 0, 0, adjustedHour, minute);
  }

  // next field focused in textField
  static fieldFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode nextFocus,){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // toast message
  static toastMessage(String message){
    Fluttertoast.showToast(msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );}

  //flushbar
  static flushBarErrorMessage(String message , BuildContext context){
    showFlushbar(context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeOut,
        positionOffset: 20,
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(20),
        icon: const Icon(Icons.error ,size: 28,color: Colors.white,),
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        backgroundColor: AppColors.buttonsColor,
        messageColor: Colors.white,
        duration: const Duration(seconds: 3),
      )..show(context),
    );}

  //snackbar
  static snackBar(String message , BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text(message))
    );
  }
  //googlemap
  static googleMap(BuildContext context,controller)async{

    String googleKey = AppUrl.gKey;

    var place = await PlacesAutocomplete.show(
        logo: const Text(''),
        context: context,
        apiKey: googleKey,
        mode: Mode.overlay,
        types: [],
        strictbounds: false,
        components: [
        ],
        onError: (err){
        }
    );

    if(place != null){
      controller.text = place.description.toString();

      final plist = GoogleMapsPlaces(apiKey:googleKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );

      String placeId = place.placeId ?? "0";
      final detail = await plist.getDetailsByPlaceId(placeId);
      final geometry = detail.result?.geometry!;
      var originLatitude = geometry?.location.lat;
      var originLongitude = geometry?.location.lng;
    }
  }

  //make phonecall
  static makephonecall()async{
    const phone_number = '09180867 30010';
    bool? res =  await FlutterPhoneDirectCaller.callNumber(phone_number);
  }

  //mail app
  static void showNoMailAppsDialog(BuildContext context){
    showDialog(context: context,
        builder: (context){
          return AlertDialog(
              title: Text('Open Mail App'),
              content: Text('No Mail Apps Installed'),
              actions:<Widget>[
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('OK'))
              ]
          );
        });
  }

  //date picker
  static date(BuildContext context,controller)async{
    var hour = DateTime.now().hour;

    if (hour <= 11) {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100));

      if (pickedDate != null) {
        String formattedDate = DateFormat('MM-dd-yyyy')
            .format(pickedDate);
        controller.text =
            formattedDate;
      } else {}
    } else {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now().add(
              const Duration(days: 1)),
          firstDate: DateTime.now().add(
              const Duration(days: 1)),
          lastDate: DateTime(2100));

      if (pickedDate != null) {
        String formattedDate = DateFormat('MM-dd-yyyy')
            .format(pickedDate);

        controller.text =
            formattedDate;
      } else {}
    }
  }

  //getindividual cost
  static Future<void> getIndividualCost(String size) async {
    final url = Uri.parse('http://192.168.1.4:3000/orders/get_individual_cost');
    // print('size is :${size}');
    // print('district is :${Utils.FromAddress[0]['district']}'.toLowerCase());
    // print('locality is :${Utils.selectedLocality}');
    // print('latitude1 is :${Utils.selectedLatitude}');
    // print('longitude1 is :${Utils.selectedLongitude}');
    // print('to district is :${Utils.ToAddress[0]['district']}'.toLowerCase());
    // print('to locality is :${Utils.ToAddress[0]['locality']}'.toLowerCase());
    // print('to latitude is :${Utils.selectedDropLatitude}');
    // print('to longitude is :${Utils.selectedDropLongitude}');
    // Create the request body
    final body = jsonEncode({
      "size": size,
      "from": {
        "district": Utils.FromAddress[0]['district'].toString().toLowerCase(),
        "locality": Utils.FromAddress[0]['locality'].toString().toLowerCase(),
        "latitude": Utils.selectedLatitude,
        "longitude": Utils.selectedLongitude,
      },
      "to": {
        "district": Utils.ToAddress[0]['district'].toString().toLowerCase(),
        "locality": Utils.ToAddress[0]['locality'].toString().toLowerCase(),
        "latitude": Utils.selectedDropLatitude,
        "longitude":Utils.selectedDropLongitude,
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
        Utils.priceByItem = responseData['cost'];
        // Utils.pricebyCount = (int.parse(Utils.count as String )* int.parse(Utils.priceByItem as String));
        print(Utils.pricebyCount);
        return responseData['cost'];
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  //place order

  static Future<void> createOrder() async {
    final url = Uri.parse('http://192.168.1.4:3000/orders');

    try {
      final response = await http.post(url,
          body: {
            "from": "CLT SHOP",
            "date": "2023-07-15",
            "user": "deepak",
            "payment": "from app",
            "shipment": [
              {
                "to": "VLK SHOP",
                "cost": 0,
                "products": [
                  {
                    "product": "pineapple",
                    "type": "Carton",
                    "size": "S",
                    "count": 2
                  }

                ]
              }

            ]
          },
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 201) {
        print('Order created successfully');
        // Navigator.pushNamed(context, RoutesName.orderPlacedSplash);
      } else {
        print('Failed to create order. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating order: $e');
    }
  }

  //find total Price
  static getTotalPrice(){
    totalPrice = 1000;
    print('total price is:');
  }

  //find advance price
static getAdvancePrice(){
    print('advance price is:');
    advancePrice = ((totalPrice! * 50)/100) as double;
    balanceAmout = (totalPrice! - advancePrice!);
    print(advancePrice);
    print(balanceAmout);
}
//place order
  static Future<void> placeOrder() async {
    final url = Uri.parse('http://192.168.1.4:3000/orders');

    // Create the shipment list with the desired structure
    final shipmentList = Utils.shipmentList.map((shipment) {
      return {
        'from': shipment['from'],
        'to': shipment['to'],
        'cost': shipment['cost'],
        'products': Utils.productList,
      };
    }).toList();

    // Create the order details map
    final orderDetails = {
      'date': Utils.selectedDate,
      'user': 'deepak',
      'payment': Utils.payement,
      'shipment': shipmentList,
    };

    Utils.orderdetails.add(orderDetails);
    print(Utils.orderdetails[0]);
    try {
      final response = await http.post(
        url,
        body: json.encode(Utils.orderdetails[0]), // Convert to JSON string
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Utils.Booking_success = true;
        print('Order created successfully');
        // Navigator.pushNamed(context, RoutesName.orderPlacedSplash);
      } else {
        print('Failed to create order. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating order: $e');
    }
  }
}