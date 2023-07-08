// import 'package:chaavie_customer/data/network/base_api_services.dart';
// import 'package:chaavie_customer/data/network/network_api_services.dart';
// import 'package:chaavie_customer/res/app_url.dart';
//
// import '../model/myAddress/AddressModel.dart';
//
// class AddressRepository{
//   BaseApiServices apiServices = NetworkApiServices();
//
//   Future<AddressModel>addressList()async{
//     try{
//       print('api calling is working');
//       dynamic response = await apiServices.getAPiResponse(AppUrl.viewAddress);
//       return response = AddressModel.fromJson(response);
//     }catch(e){
//       throw e;
//     }
//   }
//
// }