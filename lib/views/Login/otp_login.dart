import 'package:chaavie_customer/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_page.dart';
var isOtp;
var apiurl;
var mapurl;
var key1;
var key2;
var userName;




class OtpLogin extends StatefulWidget {
  const OtpLogin({Key? key}) : super(key: key);

  @override
  State<OtpLogin> createState() => _OtpLoginState();
}
class _OtpLoginState extends State<OtpLogin> {
  @override
  void dispose() {
    _userController.dispose();
    super.dispose();
  }

  @override
  int _value=2;
  bool _isObscure = true;
  bool navigateToPage = false;
  bool _isVisible = false;

  final _otpController=TextEditingController();
  final _userController=TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 370,
              width: MediaQuery.of(context).size.width,
              child:Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/shape.png')
                        ,fit: BoxFit.cover
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          Text(
                            'Welcome\nback',
                            style:TextStyle(
                              fontFamily: 'ArgentumSans',
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Image.asset('assets/images/Group 1.png',
                            scale: 2,color: Colors.white,),
                        ],
                      ),
                      SizedBox(height: 100,),
                      Text('Login',
                        style:TextStyle(
                          fontFamily: 'ArgentumSans',
                          color: Color(0XFFF05ACFF),
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 1,
                      groupValue: _value,
                      activeColor:Color(0XFFF05ACFF),
                      onChanged: (value){
                        setState(() {
                          _value= value as int ;
                          navigateToPage = true;
                        });
                        if (navigateToPage) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (ctx)=>LoginScreen()));
                        }
                      },
                    ),
                    Text('Password'),
                    Radio(
                      value: 2,
                      groupValue: _value,
                      onChanged: (value){
                        setState(() {
                          _value= value as int ;
                        });
                      },
                    ),
                    Text('Login with otp'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    children: [
                      TextField(
                        controller: userNameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'User name',
                        ),
                      ),
                      if(_isVisible)
                        TextField(
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          obscureText: _isObscure,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(onPressed: (){
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }, icon: Icon(_isObscure?Icons.visibility:Icons.visibility_off)),
                              hintText: 'OTP'
                          ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: (){

                          },
                              child: const Text('forgot password?')),
                        ],
                      ),
                      if(!_isVisible)
                        ElevatedButton(onPressed: userNameController.text.length==0 ? null : (){
                          generateOtp();
                          setState(() {
                            _isVisible=!_isVisible;
                          });
                        },
                          child: Text('Generate OTP',style: TextStyle(fontSize: 20),),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(430, 40),
                            maximumSize:  Size(430, 40),
                          ),
                        ),
                      ElevatedButton(onPressed: _otpController.text.length==0 ? null : (){
                        setState(() {
                          check();
                          usernameGet();
                        });
                      },
                        child: const Text('Enter OTP',style: TextStyle(fontSize: 20),),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(430, 40),
                          maximumSize:  Size(430, 40),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('New here?'),
                          TextButton(onPressed: (){},
                              child: const Text('signup')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

///////////////////////////////////////////////////////////////////////////////  OTP GENERATE AND SEND TO EMAIL

  Future generateOtp() async {
    // var otpGenerate ='${AppUrl.apiUrl}/generateotp';
    // http.Response response = await http.get(Uri.parse(otpGenerate));
    // if (response.statusCode == 200) {
    //   setState(() {
    //     var otp=jsonDecode(response.body);
    //     isOtp=otp;
    //     print(isOtp);
    //   });
    //   var otpSent ='${AppUrl.apiUrl}/sendotp';
    //   http.Response respons = await http.post(Uri.parse(otpSent),body:{
    //     'email':userNameController.text.trim(),
    //     'otp':isOtp.toString(),
    //   });
    //   if (respons.statusCode == 200) {
    //     print(respons.statusCode);
    //     setState(() {
    //       var otp=jsonDecode(respons.body);
    //       print('otpIs====$isOtp');
    //     });
    //   }
    // }
  }
////////////////////////////////////////////////////////////////////////////////////////////////////// CHECK OTP

  Future check() async {
    var otp=isOtp.toString();
    print('otpController====${_otpController.text}');
    print('otp====$otp');
    if(otp==_otpController.text){
      Fluttertoast.showToast(
          msg: "Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>HomePage()));

    }else{
      Fluttertoast.showToast(
          msg: "OTP incorrect",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  Future usernameGet() async {
    // var username = '${AppUrl.apiUrl}/username';
    // http.Response resp = await http.put(Uri.parse(username),
    //     body: {
    //       "email":userNameController.text,
    //     }
    // );
    // if (resp.statusCode == 200) {
    //   setState(() {
    //     var userDetail = jsonDecode(resp.body);
    //     userName=userDetail['name'];
    //     userId=userDetail['id'];
    //     print("user name === $userName");
    //   });
    // }
  }

}