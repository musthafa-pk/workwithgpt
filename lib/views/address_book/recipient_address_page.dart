import 'dart:convert';

import 'package:chaavie_customer/model/myAddress/AddressModel.dart';
import 'package:chaavie_customer/utils/routes/routes_name.dart';
import 'package:chaavie_customer/view_model/address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../data/response/status.dart';
import '../../res/app_colors.dart';
import 'package:http/http.dart' as http;
import '../../utils/utils.dart';


class RecipientAddressPage extends StatefulWidget {
  const RecipientAddressPage({Key? key}) : super(key: key);

  @override
  State<RecipientAddressPage> createState() => _RecipientAddressPageState();
}

class _RecipientAddressPageState extends State<RecipientAddressPage> {
  int userId = 85;
  int? addressId;
  bool select_for_delete = false;

  List<AddressModel> entries = [];
  List<AddressModel> selectedAddresses = [];

  Future<List<AddressModel>> getAddressBookEntriesFrom(int userId) async {
    final url = Uri.parse('http://192.168.1.4:3000/addressbook/$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List<dynamic>;

        final fetchedEntries = jsonData
            .map((entry) => AddressModel.fromJson(entry as Map<String, dynamic>))
            .toList();

        return fetchedEntries;
      } else {
        throw Exception('API call failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error occurred during API call: $error');
    }
  }

  Future<void> deleteAddress(int id) async {
    var url = Uri.parse('http://192.168.1.4:3000/addressbook/$id');

    // Send the DELETE request
    var response = await http.delete(url);

    // Check the response status code
    if (response.statusCode == 200) {
      Utils.flushBarErrorMessage('Address deleted successfully.', context);
      print('Address with ID $id deleted successfully.');
    } else {
      print('Failed to delete address. Error: ${response.body}');
    }
  }


  @override
  void initState() {
    super.initState();
    getAddressBookEntriesFrom(userId).then((value) {
      setState(() {
        // entries = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.buttonsColor,
        ),
        height: 6.h,
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'RECIPIENT ADDRESS BOOK',
                        style: TextStyle(
                          color: Color.fromRGBO(1, 36, 76, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          deleteAddress(addressId!);
                          setState(() {});
                        },
                        child: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.addAddress);
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.add,
                          color: AppColors.buttonsColor,
                        ),
                        title: Text(
                          'Add new address',
                          style: TextStyle(color: AppColors.buttonsColor),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black12,
                    ),
                  ],
                ),
                FutureBuilder<List<AddressModel>>(
                  future: getAddressBookEntriesFrom(userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      final entries = snapshot.data!;
                      return ListView.builder(
                        itemCount: entries.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final entry = entries[index];
                          if (entry.category == 'To') {
                            final isSelected = addressId == entry.id; // Update the isSelected comparison

                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        addressId = null;
                                      } else {
                                        addressId = entry.id;
                                      }
                                    });
                                  },
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    leading: Icon(Icons.add_home, color: AppColors.buttonsColor),
                                    trailing: isSelected
                                        ? Icon(Icons.check_circle, color: AppColors.buttonsColor)
                                        : Icon(Icons.circle_sharp),
                                    title: Text(
                                      entry.addressLabel,
                                      style: TextStyle(color: AppColors.buttonsColor),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          entry.district,
                                          style: TextStyle(color: AppColors.buttonsColor),
                                        ),
                                        Text(
                                          'Pin: ${entry.address.pin}',
                                          style: TextStyle(color: AppColors.buttonsColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black12,
                                ),
                              ],
                            );
                          }
                          return SizedBox.shrink();
                        },
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('An error occurred while fetching data.');
                    }
                    return Text('Something went wrong.');
                  },
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}