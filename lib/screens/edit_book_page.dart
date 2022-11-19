import 'package:book_habits/utils/book_args.dart';
import 'package:book_habits/repository/book_repository.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:book_habits/widgets/custom_divider.dart';
import 'package:book_habits/widgets/custom_input_container.dart';
import 'package:book_habits/widgets/custom_slider.dart';
import 'package:book_habits/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class EditBookPage extends StatefulWidget {
  static const String id = '/edit_book_screen';

  const EditBookPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  BookRepository repository = BookRepository();
  double currentSliderValue = 0;

  final TextEditingController currentPageCountController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    BookArgument screenArgument =
        ModalRoute.of(context)!.settings.arguments as BookArgument;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Book'),
      ),
      body: SafeArea(
        child: CustomInputContainer(
          assetUrl: 'assets/images/bricks.jpg',
          height: height,
          width: width,
          containerSize: 0.60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(screenArgument: screenArgument),
              const SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: brickOrange,
                    width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        'Current Page Slider',
                        style: TextStyle(
                          color: warmBrown,
                          fontSize: 18,
                          fontFamily: 'Merienda',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: CustomDivider(),
                    ),
                    CustomSlider(
                      currentSliderValue: currentSliderValue,
                      screenArgument: screenArgument,
                      onChanged: (value) {
                        setState(() {
                          currentSliderValue = value!;
                        });
                      },
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          repository.editCurrentPage(
                            screenArgument.book,
                            currentSliderValue.round().toInt(),
                          );
                          Navigator.pop(context);
                        },
                        style: Theme.of(context).textButtonTheme.style,
                        child: const Text(
                          'Edit',
                          style: textButtonTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
