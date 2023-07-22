import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
var apiurl;
var userNameController=TextEditingController();
var userId;
var user;

var a= 4.6;
dynamic b = 2;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {

  final _passwordController=TextEditingController();
  bool isLoading = false;

  int _value=1;
  bool _isObscure = true;
  bool navigateToPage = false;
  bool _isVisible = false;
  final _otpController=TextEditingController();


  @override
  void initState() {
    super.initState();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Color(0xfff05acff)),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 370,
                    width: MediaQuery.of(context).size.width,
                    child:Container(
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //       image: AssetImage('./assets/images/logistics1.png'),
                      //       fit: BoxFit.cover,
                      //   ),
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20.0),
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
                                CupertinoButton(child: Text(''),
                                    onPressed: (){

                                    })
                              ],
                            ),
                            const SizedBox(height: 10,),
                            // Row(
                            //   children: [
                            //     Image.asset('assets/images/logistics1.png',
                            //       scale: 2,color: Colors.blue,),
                            //   ],
                            // ),
                            const SizedBox(height: 100,),
                            const Text('Login',
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
                                navigateToPage = false;
                              });
                            },
                          ),
                          Text('Password'),
                          Radio(
                            value: 2,
                            groupValue: _value,
                            onChanged: (value){
                              setState(() {
                                _value= value as int ;
                                navigateToPage = true;
                              });
                              // if (navigateToPage) {
                              //   Navigator.push(context,
                              //       MaterialPageRoute(builder: (ctx)=>OtpLogin()));
                              // }
                            },
                          ),
                          Text('Login with otp'),
                        ],
                      ),
                    ],
                  ),
                  navigateToPage?
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
                  ):
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 20),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            TextField(
                              controller: userNameController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: 'User name',
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            TextField(
                              controller: _passwordController,
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
                                  hintText: 'password'
                              ),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(onPressed: (){
                              print(apiurl);
                              // Register.openurlReg();
                            },
                                child: const Text('forgot password?')),
                          ],
                        ),
                        ElevatedButton(onPressed: userNameController.text.length==0 ? null :() async {
                          setState(()  {
                            isLoading = true;
                            // loginPassword();
                            checkEmail();
                            usernameGet();
                          });
                          await Future.delayed(const Duration(seconds: 20));
                          setState(() {
                            isLoading = false;
                          });
                          print('pressed');
                        },
                          child:(isLoading)
                              ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Logging in',
                                style:TextStyle(
                                  fontFamily: 'ArgentumSans',
                                  color: Colors.white70,
                                ),),
                              SizedBox(width: 5,),
                              LoadingAnimationWidget.prograssiveDots(
                                color: Colors.white70,
                                size: 20,
                              ),
                            ],
                          )
                              : const Text('Login',style: TextStyle(fontSize: 20),),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(430, 40),
                            maximumSize:  Size(430, 40),
                          ),
                        ),
                        // ElevatedButton(
                        //   style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                        //   onPressed: () async {
                        //     setState(() {
                        //       isLoading = true;
                        //     });
                        //     await Future.delayed(const Duration(seconds: 5));
                        //     setState(() {
                        //       isLoading = false;
                        //     });
                        //   },
                        //   child: (isLoading)
                        //       ? const SizedBox(
                        //       width: 16,
                        //       height: 16,
                        //       child: CircularProgressIndicator(
                        //         color: Colors.white,
                        //         strokeWidth: 1.5,
                        //       ))
                        //       : const Text('Submit'),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('New here?'),
                            TextButton(onPressed: (){
                              // Register.openurlReg();
                            },
                              child: const Text('signup',style: TextStyle(decoration: TextDecoration.underline,),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

/////////////////////////////////////////////////////////////////////////////// EMAIL CHECK

  Future checkEmail() async {
//     var mail ='${AppUrl.apiUrl}/checkemail';
//     http.Response response = await http.put(Uri.parse(mail),body: {
//       'email':userNameController.text,
//     });
//     if (response.statusCode == 200) {
//       setState(() {
//         var email=jsonDecode(response.body);
//         print('mail===$email');
//         if(email==true){
//           print('email true');
//           //Fluttertoast.showToast(
// //               msg: "Logging in",
// //               toastLength: Toast.LENGTH_SHORT,
// //               gravity: ToastGravity.CENTER,
// //               timeInSecForIosWeb: 1,
// //               backgroundColor: Colors.black,
// //               textColor: Colors.white,
// //               fontSize: 16.0
// //           );
//
//         }else{
//           Fluttertoast.showToast(
//               msg: "Email incorrect",
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.CENTER,
//               timeInSecForIosWeb: 1,
//               backgroundColor: Colors.red,
//               textColor: Colors.white,
//               fontSize: 16.0
//           );
//         }
//       });
//     }
//   }
// ///////////////////////////////////////////////////////////////////////////////// PASSWORD CHECK
//
//   Future loginPassword() async {
//     var password ='${AppUrl.apiUrl}/loginpwd';
//     http.Response response = await http.post(Uri.parse(password),body: {
//       'email':'${userNameController.text.trim()}',
//       'password':'${_passwordController.text.trim()}',
//     });
//     if (response.statusCode == 200) {
//       setState(() {
//         var pass=jsonDecode(response.body);
//         print('pass===$pass');
//         print('${userNameController.text}');
//         if(pass==true){
//           // Fluttertoast.showToast(
//           //     msg: "Logging in",
//           //     toastLength: Toast.LENGTH_SHORT,
//           //     gravity: ToastGravity.CENTER,
//           //     timeInSecForIosWeb: 1,
//           //     backgroundColor: Color(0xfff05acff),
//           //     textColor: Colors.white,
//           //     fontSize: 16.0
//           // );
//
//           Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Home()));
//
//         }else{
//           Fluttertoast.showToast(
//               msg: "Password incorrect",
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.CENTER,
//               timeInSecForIosWeb: 1,
//               backgroundColor: Colors.red,
//               textColor: Colors.white,
//               fontSize: 16.0
//           );
//         }
//
//       });
//     }
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
    //     user=userDetail['name'];
    //     userId=userDetail['id'];
    //     print("user name === $userId");
    //   });
    // }
  }

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

  Future check() async {
  //   var otp=isOtp.toString();
  //   print('otpController====${_otpController.text}');
  //   print('otp====$otp');
  //   if(otp==_otpController.text){
  //     Fluttertoast.showToast(
  //         msg: "Success",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 16.0
  //     );
  //     Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Home()));
  //
  //   }else{
  //     Fluttertoast.showToast(
  //         msg: "OTP incorrect",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0
  //     );
  //   }
  }
}