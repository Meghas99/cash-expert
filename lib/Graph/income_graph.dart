// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class IncomeGraph extends StatefulWidget {
//   const IncomeGraph({super.key});

//   @override
//   State<IncomeGraph> createState() => _IncomeGraphState();
// }

// class _IncomeGraphState extends State<IncomeGraph> {
//    late List<GDPData> _chartData;

//    @override
//   void initState() {
//     _chartData = getChartDta();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
//         body: Column(
//           children: [
//             const SizedBox(
//               height: 40,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 CircleAvatar(
//                   backgroundColor: Colors.lightBlue,
//                   radius: 10,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   'SALARY',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   width: 50,
//                 ),
//                 CircleAvatar(
//                   backgroundColor: Color.fromARGB(255, 207, 114, 145),
//                   radius: 10,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text('BANK', style: TextStyle(fontWeight: FontWeight.bold)),
//               ],
//             ),
//             Column(
//               children: [
//                 SfCircularChart(
//                   series: <CircularSeries>[
//                     PieSeries<GDPData, String>(

//                         dataSource: _chartData,
//                         xValueMapper: (GDPData data, _) => data.continent,
//                         yValueMapper: (GDPData data, _) => data.gdp)
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   List<GDPData> getChartDta() {
//     final List<GDPData> chartData = [
//       GDPData('hi', 100),
//       GDPData('hi1', 240),
//       // GDPData('hi2', 2900),
//       // GDPData('hi3', 23050),
//       // GDPData('hi4', 24800),
//       // GDPData('hi5', 34390),
//     ];
//     return chartData;
//   }
// }

// class GDPData {
//   GDPData(this.continent, this.gdp);
//   final String continent;
//   final int gdp;
// }
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moneymanagement/Graph/all_grap.dart';

import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IncomeInsights extends StatelessWidget {
  const IncomeInsights({super.key});

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
            return overViewGraphNotifier.value.isEmpty
                ? SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // children: [
                        //   Lottie.asset(
                        //     'assets/images/no-data.json',
                        //     height: 360,
                        //   ),
                        // ],
                      ),
                    ),
                  )
                : SfCircularChart(
                    series: <CircularSeries>[
                      PieSeries<TransactionModel, String>(
                        dataSource: allIncome,
                        xValueMapper: (TransactionModel incomeDate, _) =>
                            incomeDate.category.name,
                        yValueMapper: (TransactionModel incomeDate, _) =>
                            incomeDate.amount,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                      )
                    ],
                    legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.scroll,
                      alignment: ChartAlignment.center,
                    ),
                  );
          },
        ),
      ),
    );
  }
}

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
            log(allIncome.toString());
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
                    series: <CircularSeries>[
                      PieSeries<TransactionModel, String>(
                        dataSource: allIncome,
                        xValueMapper: (TransactionModel incomeData, _) =>
                            incomeData.category.name,
                        yValueMapper: (TransactionModel incomeData, _) =>
                            incomeData.amount,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                      )
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
