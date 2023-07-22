import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../res/app_colors.dart';
import '../../res/components/Booking Screen Components/custom_dropdown.dart';
class CarouselSlideWorkout extends StatefulWidget {
  const CarouselSlideWorkout({Key? key}) : super(key: key);

  @override
  State<CarouselSlideWorkout> createState() => _CarouselSlideWorkoutState();
}

class _CarouselSlideWorkoutState extends State<CarouselSlideWorkout> {
  final List<List<String>> outerSliderData = [
    ['Item 1', 'Item 2', 'Item 3'],
    ['Item 4', 'Item 5', 'Item 6'],
    ['Item 7', 'Item 8', 'Item 9'],
  ];

  final List<List<String>> innerSliderData = [
    ['Inner 1', 'Inner 2', 'Inner 3'],
    ['Inner 4', 'Inner 5', 'Inner 6'],
    ['Inner 7', 'Inner 8', 'Inner 9'],
  ];

  CarouselController outerCarouselController = CarouselController();
  List<CarouselController> innerCarouselControllers = [];
  List<List<String>> selectedOptions = [];
  List<List<String>> selectedOptions2 = [];
  List<List<String>> selectedCounts = [];
  List<List<TextEditingController>> textControllers = [];
  List<List<String>> textValues = [];

  @override
  void initState() {
    super.initState();
    selectedOptions = List.generate(outerSliderData.length, (index) => []);
    selectedOptions2 = List.generate(outerSliderData.length, (index) => []);
    selectedCounts = List.generate(outerSliderData.length, (index) => []);
    textControllers = List.generate(
      outerSliderData.length,
          (outerIndex) => List.generate(
        innerSliderData[outerIndex].length,
            (innerIndex) => TextEditingController(),
      ),
    );
    textValues = List.generate(
      outerSliderData.length,
          (outerIndex) => List.generate(
        innerSliderData[outerIndex].length,
            (innerIndex) => '',
      ),
    );
    for (int i = 0; i < outerSliderData.length; i++) {
      innerCarouselControllers.add(CarouselController());
      selectedOptions[i] = List<String>.filled(
        innerSliderData[i].length,
        '',
        growable: true,
      );
      selectedOptions2[i] = List<String>.filled(
        innerSliderData[i].length,
        '',
        growable: true,
      );
      selectedCounts[i] = List<String>.filled(
        innerSliderData[i].length,
        '',
        growable: true,
      );
      List<TextEditingController> controllers = [];
      List<String> values = [];
      for (int j = 0; j < innerSliderData[i].length; j++) {
        controllers.add(TextEditingController());
        values.add('');
      }
      textControllers.add(controllers);
      textValues.add(values);
    }
  }

  @override
  void dispose() {
    for (List<TextEditingController> controllers in textControllers) {
      for (TextEditingController controller in controllers) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Shipment Details',
                style: TextStyle(
                  color: AppColors.buttonsColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ArgentumSans',
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.blue[50]),
                child: CarouselSlider.builder(
                  carouselController: outerCarouselController,
                  itemCount: outerSliderData.length,
                  options: CarouselOptions(
                    height: 700,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                    enlargeCenterPage: true,
                  ),
                  itemBuilder: (BuildContext context, int outerIndex, int _) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.buttonsColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                                right: 5,
                                top: 1,
                                bottom: 1,
                              ),
                              child: Text(
                                '${outerIndex + 1}'.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Drop Location'),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: AppColors.buttonsColor,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: CustomDropdown(
                              options: ['helloo', 'hai', 'how are you'],
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CarouselSlider.builder(
                            carouselController:
                            innerCarouselControllers[outerIndex],
                            itemCount: innerSliderData[outerIndex].length,
                            options: CarouselOptions(
                              height: 500,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1.0,
                              enlargeCenterPage: true,
                            ),
                            itemBuilder:
                                (BuildContext context, int innerIndex, int _) {
                              final List<String> options = [
                                'Carton',
                                'Bag/Sack',
                                'Other',
                              ];
                              final List<String> options2 = [
                                'Small',
                                'Medium',
                                'Large',
                              ];
                              final List<TextEditingController> controllers =
                              textControllers[outerIndex];
                              final List<String> values = textValues[outerIndex];
                              final String selectedOption = selectedOptions[outerIndex].length > innerIndex
                                  ? selectedOptions[outerIndex][innerIndex]
                                  : '';
                              final String selectedOption2 = selectedOptions2[outerIndex].length > innerIndex
                                  ? selectedOptions2[outerIndex][innerIndex]
                                  : '';
                              final String selectedCount = selectedCounts[outerIndex].length > innerIndex
                                  ? selectedCounts[outerIndex][innerIndex]
                                  : '';


                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          //slide index
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.buttonsColor,
                                              borderRadius:
                                              BorderRadius.circular(100),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 5,
                                                right: 5,
                                                top: 1,
                                                bottom: 1,
                                              ),
                                              child: Text(
                                                '${innerIndex + 1}'.toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Product Details',
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color: AppColors.buttonsColor,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(100),
                                            ),
                                            child: TextField(
                                              controller: controllers[innerIndex],
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Enter text',
                                                contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 16.0),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  values[innerIndex] = value;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          // Segmented button options in the inner carousel
                                          ToggleButtons(
                                            isSelected: options
                                                .map((option) =>
                                            option == selectedOption)
                                                .toList(),
                                            onPressed: (index) {
                                              setState(() {
                                                if (selectedOptions[outerIndex]
                                                    .length <= innerIndex) {
                                                  selectedOptions[outerIndex]
                                                      .add('');
                                                }
                                                selectedOptions[outerIndex]
                                                [innerIndex] =
                                                options[index];
                                              });
                                            },
                                            children: options
                                                .map((option) {
                                              final isSelected =
                                                  option == selectedOption;
                                              return Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4,
                                                    horizontal: 16),
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? Colors.green
                                                      : Colors.grey,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      100),
                                                ),
                                                child: Text(
                                                  option,
                                                  style: TextStyle(
                                                    color: isSelected
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              );
                                            })
                                                .toList(),
                                          ),
                                          if (selectedOption == 'Bag/Sack')
                                            ToggleButtons(
                                              isSelected: options2
                                                  .map((option2) =>
                                              option2 ==
                                                  selectedOption2)
                                                  .toList(),
                                              onPressed: (index) {
                                                setState(() {
                                                  if (selectedOptions2[
                                                  outerIndex]
                                                      .length <= innerIndex) {
                                                    selectedOptions2[outerIndex]
                                                        .add('');
                                                  }
                                                  selectedOptions2[outerIndex]
                                                  [innerIndex] =
                                                  options2[index];
                                                });
                                              },
                                              children: options2
                                                  .map((option2) {
                                                final isSelected =
                                                    option2 == selectedOption2;
                                                return Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 16),
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? Colors.green
                                                        : Colors.grey,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        100),
                                                  ),
                                                  child: Text(
                                                    option2,
                                                    style: TextStyle(
                                                      color: isSelected
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                );
                                              })
                                                  .toList(),
                                            ),
                                          if (selectedOption == 'Other')
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    labelText: 'Length',
                                                  ),
                                                  onChanged: (value) {
                                                    // Handle length text field value change
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    labelText: 'Width',
                                                  ),
                                                  onChanged: (value) {
                                                    // Handle width text field value change
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    labelText: 'Height',
                                                  ),
                                                  onChanged: (value) {
                                                    // Handle height text field value change
                                                  },
                                                ),
                                              ],
                                            ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextField(
                                            controller: controllers[innerIndex],
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Count',
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                values[innerIndex] = value;
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        50),
                                                    color: AppColors.buttonsColor,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 10,
                                                        right: 20,
                                                        top: 5,
                                                        bottom: 5),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.arrow_drop_up,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                        Text(
                                                          'Product',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        50),
                                                    color: Colors.red,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 10,
                                                        right: 20,
                                                        top: 5,
                                                        bottom: 5),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .arrow_drop_down_sharp,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                        Text(
                                                          'Product',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.add_location_alt,
                                color: Colors.blue,
                                size: 35,
                              ),
                              Icon(
                                Icons.wrong_location,
                                color: Colors.red,
                                size: 35,
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
