import 'package:book_habits/repository/book_repository.dart';
import 'package:book_habits/utils/constants.dart';

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
        title: const Text('Statistics'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/paper.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                  chartRadius: 200,
                  legendOptions: const LegendOptions(
                    legendPosition: LegendPosition.bottom,
                    legendTextStyle: TextStyle(
                      fontSize: 16.0,
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
    );
  }
}
