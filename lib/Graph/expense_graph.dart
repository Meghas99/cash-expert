import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moneymanagement/Graph/all_grap.dart';

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
        body: ValueListenableBuilder(
          valueListenable: overViewGraphNotifier,
          builder: (BuildContext context, List<TransactionModel> newList,
              Widget? child) {
            var allIncome = newList
                .where((element) => element.type == CategoryType.expense)
                .toList();
            return overViewGraphNotifier.value.isEmpty
                ? SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Lottie.network(
                                'https://assets5.lottiefiles.com/packages/lf20_rdjfuniz.json'),
                          )
                        ],
                      ),
                    ),
                  )
                : SfCircularChart(
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
                      PieSeries<TransactionModel, String>(
                          dataSource: allIncome,
                          xValueMapper: (TransactionModel expenseDate, _) =>
                              expenseDate.category.name,
                          yValueMapper: (TransactionModel expenseDate, _) =>
                              expenseDate.amount,
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            labelIntersectAction: LabelIntersectAction.none,
                            textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          enableTooltip: true)
                    ],
                    legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.scroll,
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