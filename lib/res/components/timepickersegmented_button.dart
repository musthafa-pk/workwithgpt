import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class CustomSegmentedButton extends StatefulWidget {
  final List<String> segments;
  final ValueChanged<int> onValueChanged;

  CustomSegmentedButton({
    required this.segments,
    required this.onValueChanged,
  });

  @override
  _CustomSegmentedButtonState createState() => _CustomSegmentedButtonState();
}

class _CustomSegmentedButtonState extends State<CustomSegmentedButton> {
  int _selectedSegment = 0;

  @override
  void initState() {
    super.initState();

    // Get the current system time
    final currentTime = DateTime.now();

    // Set the default selected time based on the system time
    if (currentTime.isBefore(Utils.parseTime('12:00 PM'))) {
      Utils.selectedTime = '09:00 AM - 12:00 PM';
      _selectedSegment = 0;
    } else if (currentTime.isBefore(Utils.parseTime('03:00 PM'))) {
      Utils.selectedTime = '12:00 PM - 03:00 PM';
      _selectedSegment = 1;
    } else {
      Utils.selectedTime = '03:00 PM - 06:00 PM';
      _selectedSegment = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Row(
        children: widget.segments.map((segment) {
          int index = widget.segments.indexOf(segment);
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSegment = index;
                });
                widget.onValueChanged(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: _selectedSegment == index ? Colors.blue : Colors.white,
                ),
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0,top: 10,bottom: 10),
                    child: Text(
                      segment,
                      style: TextStyle(
                        color: _selectedSegment == index ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}