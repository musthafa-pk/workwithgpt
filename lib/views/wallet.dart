import 'package:chaavie_customer/res/app_colors.dart';
import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                  color: AppColors.buttonsColor,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.check_circle,color: Colors.white,),
                              Text(
                                'Chaavie Solutions',
                                style: TextStyle(
                                  fontFamily: 'ArgentumSans',
                                  color:Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50,),
                          Text(
                            '₹ 6969',
                            style: TextStyle(
                              fontFamily: 'ArgentumSans',
                              color:Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'NAME:',
                                    style: TextStyle(
                                      fontFamily: 'ArgentumSans',
                                      color:Colors.white60,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    'Musthafa',
                                    style: TextStyle(
                                      fontFamily: 'ArgentumSans',
                                      color:Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'CUSTOMER ID:',
                                    style: TextStyle(
                                      fontFamily: 'ArgentumSans',
                                      color:Colors.white60,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    '0000000001',
                                    style: TextStyle(
                                      fontFamily: 'ArgentumSans',
                                      color:Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}