import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moneymanagement/Graph/all_grap.dart';
import 'package:moneymanagement/models/categorised_model.dart';

import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExpenseGraph extends StatefulWidget {
  const ExpenseGraph({super.key});

  @override
  State<ExpenseGraph> createState() => _ExpenseGraphState();
}

class _ExpenseGraphState extends State<ExpenseGraph> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
        body: ValueListenableBuilder(
          valueListenable: overViewGraphNotifier,
          builder: (BuildContext context, List<TransactionModel> newList,
              Widget? child) {
            var allIncome = newList
                .where((element) => element.type == CategoryType.expense)
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
            return overViewGraphNotifier.value.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'no data is available!!',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 3, 183, 30)),
                        ),
                      ),
                    ],
                  )
                : SfCircularChart(
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
                      PieSeries<CategorisedModel, String>(
                          dataSource: categorisedList,
                          xValueMapper: (CategorisedModel expenseDate, _) =>
                              expenseDate.category.name,
                          yValueMapper: (CategorisedModel expenseDate, _) =>
                              expenseDate.amount,
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                          ),
                          enableTooltip: true)
                    ],
                    legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.scroll,
                      shouldAlwaysShowScrollbar: true,
                      alignment: ChartAlignment.center,
                    ),
                    //primaryXAxis: CategoryAxis(),
                  );
          },
        ),
      ),
    );
  }
}
