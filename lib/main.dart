import 'package:chaavie_customer/utils/routes/routes.dart';
import 'package:chaavie_customer/utils/routes/routes_name.dart';
import 'package:chaavie_customer/view_model/address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context,orientation,deviceType) {
        return MaterialApp(
          title: 'Chaavie Customer App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Argentum Sans'
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesName.first_page,
          onGenerateRoute: Routes.generateRoute,
        );
      }
    );
  }
}
