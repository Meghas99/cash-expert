import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moneymanagement/Graph/all_grap.dart';
import 'package:moneymanagement/models/categorised_model.dart';

import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IncomeGraph extends StatefulWidget {
  const IncomeGraph({super.key});

  @override
  State<IncomeGraph> createState() => _IncomeGraphState();
}

class _IncomeGraphState extends State<IncomeGraph> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: overViewGraphNotifier,
          builder: (BuildContext context, List<TransactionModel> newList,
              Widget? child) {
            var allIncome = newList
                .where((element) => element.type == CategoryType.income)
                .toList();
            List<CategorisedModel> categorisedList = [];
            for (var element in allIncome) {
              bool categoryExists = false;
              for (var item in categorisedList) {
                if (item.category == element.category) {
                  categoryExists = true;
                  item.amount = item.amount + element.amount;
                }
              }
              if (categoryExists == false) {
                categorisedList
                    .add(CategorisedModel(element.amount, element.category));
              }
            }
            log(allIncome.toString());
            return overViewGraphNotifier.value.isEmpty
                ? SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Center(child: Text('no data'))
                          Center(
                            child: Lottie.network(
                                'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                          )
                        ],
                      ),
                    ),
                  )
                : SfCircularChart(
                    series: <CircularSeries>[
                      PieSeries<CategorisedModel, String>(
                        dataSource: categorisedList,
                        xValueMapper: (CategorisedModel incomeData, _) =>
                            incomeData.category.name,
                        yValueMapper: (CategorisedModel incomeData, _) =>
                            incomeData.amount,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                      )
                    ],
                    legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.scroll,
                      shouldAlwaysShowScrollbar: true,
                      alignment: ChartAlignment.center,
                    ),

                    // primaryXAxis: CategoryAxis(),
                  );
          },
        ),
      ),
    );
  }
}
