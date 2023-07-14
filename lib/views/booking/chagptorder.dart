// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
// class OrderPlacingView extends StatefulWidget {
//   @override
//   _OrderPlacingViewState createState() => _OrderPlacingViewState();
// }
//
// class _OrderPlacingViewState extends State<OrderPlacingView> {
//   List<String> locations = ['Location 1', 'Location 2', 'Location 3'];
//   int selectedLocationIndex = 0;
//
//   List<Map<String, dynamic>> subSlides = [
//     {
//       'title': 'Product 1',
//       'description': 'This is product 1',
//     },
//     {
//       'title': 'Product 2',
//       'description': 'This is product 2',
//     },
//     {
//       'title': 'Product 3',
//       'description': 'This is product 3',
//     },
//   ];
//   int selectedSubSlideIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Placing View'),
//       ),
//       body: Column(
//         children: [
//           CarouselSlider(
//             options: CarouselOptions(
//               onPageChanged: (index, reason) {
//                 setState(() {
//                   selectedLocationIndex = index;
//                   selectedSubSlideIndex = 0;
//                 });
//               },
//             ),
//             items: locations.map((location) {
//               return Container(
//                 margin: EdgeInsets.all(8.0),
//                 child: Text(
//                   location,
//                   style: TextStyle(fontSize: 20),
//                 ),
//               );
//             }).toList(),
//           ),
//           CarouselSlider(
//             options: CarouselOptions(
//               onPageChanged: (index, reason) {
//                 setState(() {
//                   selectedSubSlideIndex = index;
//                 });
//               },
//             ),
//             items: subSlides.map((slide) {
//               return Container(
//                 margin: EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       slide['title'],
//                       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       slide['description'],
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
