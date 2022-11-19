import 'package:book_habits/repository/book_repository.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:book_habits/widgets/custom_container_with_image.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class StatisticScreen extends StatefulWidget {
  static const id = 'statistic_screen';
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  BookRepository repository = BookRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statistics',
          style: listTileTextStyle,
        ),
      ),
      body: CustomContainerWithImage(
        assetUrl: 'assets/images/paper.jpg',
        opacity: 1.0,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Your statistics since ${repository.getFirstCreationDate()}',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'You have ${repository.getBookCount().toString()} book since today',
                  ),
                  Text(
                    'You read ${repository.getTotalPage().toString()} page',
                  ),
                  const SizedBox(
                    width: 200,
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.black,
                    ),
                  ),
                  PieChart(
                    dataMap: repository.getChartInfo(),
                    colorList: colorList,
                    chartLegendSpacing: 5,
                    chartRadius: 150,
                    legendOptions: const LegendOptions(
                      legendShape: BoxShape.rectangle,
                      legendPosition: LegendPosition.bottom,
                      showLegends: true,
                      legendTextStyle: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      decimalPlaces: 0,
                      chartValueStyle: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
