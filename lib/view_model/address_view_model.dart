// import 'package:chaavie_customer/data/response/api_responses.dart';
// import 'package:chaavie_customer/repository/address_repository.dart';
// import 'package:flutter/foundation.dart';
//
// import '../model/myAddress/AddressModel.dart';
//
// class AddressViewModel with ChangeNotifier{
//
//   final myRepository = AddressRepository();
//
//   ApiResponse<AddressModel> addressList = ApiResponse.loading();
//   setAddressList(ApiResponse<AddressModel> response){
//     addressList = response;
//     notifyListeners();
//   }
//
//
//   Future<void>fetchAddressListApi()async{
//     print('fetch address is working...');
//     setAddressList(ApiResponse.loading());
//     print('its loading...');
//
//     myRepository.addressList().then((value) {
//       setAddressList(ApiResponse.completed(value));
//       print('its completed...');
//     }).onError((error, stackTrace) {
//       print('on error');
//       setAddressList(ApiResponse.error(error.toString()));
//     });
//   }
//
//
// }