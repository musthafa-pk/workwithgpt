import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../app_colors.dart';
class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {

    return  InkWell(
      onTap: (){
        Dialogs.materialDialog(
            msgAlign:TextAlign.center,
            msg: 'Are you sure you want to exit ?',
            title: "Logout",
            titleStyle: const TextStyle(
              color: Colors.black,
            ),
            msgStyle: const TextStyle(
              color: Colors.black45,

            ),
            color: Colors.white,
            context: context,
            actions: [
              IconsOutlineButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'Cancel',
                iconData: Icons.cancel_outlined,
                textStyle: const TextStyle(
                  color: Colors.grey,
                ),
                iconColor: Colors.grey,
              ),
              IconsButton(
                onPressed: () => exit(0),
                text: 'Exit',
                iconData: Icons.logout,
                color:AppColors.buttonsColor,
                textStyle: const TextStyle(
                    color:AppColors.titleWhiteColor
                ),
                iconColor: Colors.white,
              ),
            ]);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.titleWhiteColor,
        ),
        child: const Icon(Icons.logout,color: AppColors.buttonsColor,),
      ),
    );
  }
}