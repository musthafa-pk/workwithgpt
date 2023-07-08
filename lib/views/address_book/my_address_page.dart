import 'dart:convert';

import 'package:chaavie_customer/model/myAddress/AddressModel.dart';
import 'package:chaavie_customer/utils/routes/routes_name.dart';
import 'package:chaavie_customer/view_model/address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/response/status.dart';
import '../../res/app_colors.dart';
import 'package:http/http.dart' as http;
import '../../utils/utils.dart';



class MyAddressPage extends StatefulWidget {
  const MyAddressPage({Key? key}) : super(key: key);

  @override
  State<MyAddressPage> createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {

int userId = 85;
int? addressId;
bool select_for_delete = false;

List<AddressBookEntry> entries = [];
List<AddressBookEntry> selectedAddresses = [];


Future<List<AddressBookEntry>> getAddressBookEntriesFrom(int userId) async {
  final url = Uri.parse('http://192.168.190.1:3000/addressbook/$userId');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;

      final fetchedEntries = jsonData.map((entry) => AddressBookEntry(
        id: entry['id'],
        addressLabel: entry['address_label'],
        category: entry['category'],
        contact: entry['contact'],
        district: entry['district'],
        latitude: double.parse(entry['latitude']),
        longitude: double.parse(entry['longitude']),
        locality: entry['locality'],
        userId: entry['user_id'],
      )).toList();

      return fetchedEntries;
    } else {
      throw Exception('API call failed with status code: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error occurred during API call: $error');
  }
}

Future<void> deleteAddress(int id) async {
  var url = Uri.parse('http://192.168.190.1:3000/addressbook/$id');

  // Send the DELETE request
  var response = await http.delete(url);

  // Check the response status code
  if (response.statusCode == 200) {
    print('Address with ID $id deleted successfully.');
  } else {
    print('Failed to delete address. Error: ${response.body}');
  }
}





@override
  void initState() {
    super.initState();
    getAddressBookEntriesFrom(userId);
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
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
                              Text('MY ADDRESS BOOK',style: TextStyle(
                                color: Color.fromRGBO(1, 36, 76, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              ),
                              InkWell(
                                onTap: (){
                                  deleteAddress(addressId!);
                                  setState(() {
                                  });
                                  return Utils.flushBarErrorMessage('Address Removed Successfully..', context);
                                },
                                  child: Icon(Icons.delete,color: Colors.red,))
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, RoutesName.addAddress);
                              },
                              child: ListTile(
                                leading: Icon(Icons.add,color:AppColors.buttonsColor,),
                                title: Text('Add new address',style: TextStyle(
                                    color: AppColors.buttonsColor
                                ),),
                              ),
                            ),
                            Divider(
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        FutureBuilder(
                          future: getAddressBookEntriesFrom(userId),
                          builder: (context,AsyncSnapshot snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting){
                              print(entries.length);
                              return Center(child: CircularProgressIndicator(),);
                            }
                            if(snapshot.hasData){
                              final entries = snapshot.data!;
                              return ListView.builder(
                                  itemCount:entries.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context,index) {
                                    final entry = entries[index];
                                    if(entry.category == 'From'){
                                      return Column(
                                        children: [
                                          // Container(
                                          //   height: 100,
                                          //   decoration: BoxDecoration(
                                          //     color: Colors.blue[50],
                                          //   ),
                                          //   child: Column(
                                          //     children: [
                                          //       Row(
                                          //         children: [
                                          //         Column(
                                          //           children: [
                                          //             Padding(
                                          //               padding: const EdgeInsets.only(top: 30,left: 15,),
                                          //               child: Icon(Icons.home,color: AppColors.buttonsColor,size: 30,),
                                          //             )
                                          //           ],
                                          //         ),
                                          //         SizedBox(width: 20,),
                                          //         Column(
                                          //           children: [
                                          //             Text(entry.addressLabel,style: TextStyle(
                                          //                 color: AppColors.buttonsColor
                                          //             ),),
                                          //           ],
                                          //         ),
                                          //           Column(
                                          //             children: [
                                          //               Icon(Icons.circle,color: Colors.grey,),
                                          //               Icon(Icons.delete,color: Colors.red,)
                                          //             ],
                                          //           )
                                          //       ],)
                                          //     ],
                                          //   ),
                                          // ),
                                          InkWell(
                                            onTap:(){
                                              setState(() {
                                                //condtion for if above 3 addresses not seen add button,

                                              });
                                              // print(addressSelect);
                                            },
                                            child: ListTile(
                                              tileColor:select_for_delete == true? Colors.blue[50]:Colors.white,
                                              leading: Icon(Icons.add_home,color: AppColors.buttonsColor),
                                              trailing:
                                              InkWell(
                                                  onTap:(){
                                                    setState(() {
                                                      print('selectedAddresses = ${selectedAddresses}');
                                                      print('entry = ${entry}');
                                                      if(selectedAddresses.contains(entry)){
                                                        selectedAddresses.remove(entry);
                                                      }else{
                                                        selectedAddresses.add(entry);
                                                        addressId = entry.id;
                                                        print('deleet id = $addressId');
                                                      }
                                                      print('selected:$selectedAddresses');
                                                    });
                                                  },

                                                  child:selectedAddresses.contains(entry)? Icon(Icons.check_circle,color: AppColors.buttonsColor,):Icon(Icons.circle)),
                                              title: Text(entry.addressLabel,style: TextStyle(
                                                  color: AppColors.buttonsColor
                                              ),),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(entry.district, style: TextStyle(
                                                    color: AppColors.buttonsColor,
                                                  ),),
                                                  Text('Pin:$entry.pin',style: TextStyle(
                                                    color: AppColors.buttonsColor,
                                                  ),),
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

                                  }
                              );
                            }
                            if(snapshot.hasError){
                              return Text('on error');
                            }

                            else{
                              return Text('Something error...');
                            }

                          }

                        ),
                      ],
                    ),
                  ),
                ),
              ),);

          }
}
