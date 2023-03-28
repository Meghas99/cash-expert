import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:moneymanagement/db/transaction/transaction_db.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

ValueNotifier<List<TransactionModel>> overViewGraphNotifier =
    ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class AllGraph extends StatefulWidget {
  const AllGraph({super.key});

  @override
  State<AllGraph> createState() => _AllGraphState();
}

class _AllGraphState extends State<AllGraph> {
  late TooltipBehavior _tooltipBehavior;
  final rupeeFormat = NumberFormat.currency(locale: 'en_IN', symbol: '@');

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      //  format: 'Income : ₹${incomeTotal.value}'
      //       'Income : ₹${expenseTotal.value}',
      enable: true,
    );

    overViewGraphNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;
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
            // Map graph_name = {'Map key': 'good', 'amount': 100};
            Map incomeMap = {'name': 'Income', "amount": incomeTotal.value};
            Map expenseMap = {"name": "Expense", "amount": expenseTotal.value};
            List<Map> totalMap = [incomeMap, expenseMap];
            return overViewGraphNotifier.value.isEmpty
                ? SizedBox(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Center(child: Text('no data'))
                          Center(
                            child: Lottie.network(
                                'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                          ),
                        ],
                      ),
                    ),
                  )
                : SfCircularChart(
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
                      PieSeries<Map, String>(
                        dataSource: totalMap,
                        xValueMapper: (Map data, _) => data['name'],
                        yValueMapper: (Map data, _) => data['amount'],
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
                  );
          }),
    ));
  }
}
