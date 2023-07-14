import 'package:flutter/material.dart';

class Support_page extends StatefulWidget {
  const Support_page({Key? key}) : super(key: key);

  @override
  State<Support_page> createState() => _Support_pageState();
}

class _Support_pageState extends State<Support_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text('support chaavie...'),
            )
          ],
        ),
      ),
    );
  }
}
