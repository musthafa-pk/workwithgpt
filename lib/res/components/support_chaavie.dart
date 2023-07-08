import 'package:flutter/material.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:open_mail_app/open_mail_app.dart';

import '../../utils/utils.dart';
import '../app_colors.dart';
class SupportChaavie extends StatelessWidget {
  const SupportChaavie({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  InkWell(
      onTap: (){
        supportChaavie(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: const Icon(Icons.support_agent,color:AppColors.buttonsColor),
      ),
    );
  }


  Future<void> supportChaavie(context){
    return Dialogs.materialDialog(
        msg: 'support chaavie team',
        msgAlign: TextAlign.center,
        msgStyle: const TextStyle(fontSize: 12,),
        title: 'Help and feedback',titleStyle:const TextStyle(
      color: AppColors.buttonsColor,
      fontSize: 16,
    ),
        context: context,
        actions: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Utils.makephonecall();
                  },
                  child: Container(
                    height: 50,
                    decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      border:Border.all(color:AppColors.buttonsColor),
                    ),
                    child: const Icon(
                      Icons.phone,
                      color: AppColors.buttonsColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColors.buttonsColor),
                        bottom: BorderSide(color: AppColors.buttonsColor),
                      ),
                    ),
                    height: 50,
                    child:  const Icon(
                      Icons.access_time,
                      color: AppColors.buttonsColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              Expanded(
                child: InkWell(
                  onTap: ()async {
                    var result = await OpenMailApp.openMailApp();
                    if(!result.didOpen && !result.canOpen){
                      Utils.showNoMailAppsDialog(context);
                    }else if(!result.didOpen && result.canOpen){
                      showDialog(context: context,
                          builder: (_){
                            return MailAppPickerDialog(mailApps: result.options);
                          });
                    }

                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border:Border.all(color:AppColors.buttonsColor),
                    ),
                    child: const Icon(
                      Icons.email_outlined,
                      color: AppColors.buttonsColor,
                    ),
                  ),
                ),),
            ],
          ),
        ]);
  }
}