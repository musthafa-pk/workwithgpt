import 'dart:convert';

import 'package:chaavie_customer/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../model/myAddress/AddressModel.dart';
import '../../res/app_colors.dart';
import 'package:http/http.dart' as http;

class RecipientAddressPage extends StatefulWidget {
  const RecipientAddressPage({Key? key}) : super(key: key);

  @override
  State<RecipientAddressPage> createState() => _RecipientAddressPageState();
}

class _RecipientAddressPageState extends State<RecipientAddressPage> {

  int userId = 85;
  String category = 'to';

  Future<List<AddressBookEntry>> getAddressBookEntriesTo(int userId) async {
    final url = Uri.parse('http://192.168.1.4:3000/addressbook/$userId');

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Text('RECIPIENT ADDRESS BOOK',style: TextStyle(
                        color: Color.fromRGBO(1, 36, 76, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      ),
                      InkWell(
                        onTap: (){},
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
                  future:getAddressBookEntriesTo(userId),
                  builder: (context,AsyncSnapshot snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    if(snapshot.hasData){
                      final entries = snapshot.data!;
                      return ListView.builder(
                        itemCount: entries.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final entry = entries[index];

                          if (entry.category != 'To') {
                            return SizedBox(); // Skip this entry if category is not 'To'
                          }

                          return Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.add_home, color: AppColors.buttonsColor),
                                trailing: InkWell(
                                  onTap: () {
                                    setState(() {
                                      // Perform any necessary operations on tap
                                    });
                                  },
                                  child: Icon(Icons.domain_verification_rounded, color: AppColors.buttonsColor),
                                ),
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
                                      'Pin: ${123}', // Update with the correct pin value
                                      style: TextStyle(color: AppColors.buttonsColor),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black12,
                              ),
                            ],
                          );
                        },
                      );

                    }
                    if(snapshot.hasError){
                      return Text('ON ERROR...');
                    }else{
                      return Text('Something error.....');
                    }
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
