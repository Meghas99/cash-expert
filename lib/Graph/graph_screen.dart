import 'package:flutter/material.dart';
import 'package:moneymanagement/Graph/all_grap.dart';
import 'package:moneymanagement/Graph/expense_graph.dart';
import 'package:moneymanagement/Graph/graph_date_filter.dart';
import 'package:moneymanagement/Graph/income_graph.dart';

class ScreenGraph extends StatelessWidget {
  const ScreenGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [DateFilterGraph()],
                ),
              ),
              const TabBar(labelColor: Colors.black, tabs: [
                Tab(
                  text: 'All',
                ),
                Tab(
                  text: 'Income',
                ),
                Tab(
                  text: 'Expence',
                ),
              ]),
              const Expanded(
                  child: TabBarView(
                children: [AllGraph(), IncomeGraph(), ExpenseGraph()],
              ))
            ],
          )),
    );
  }
}
