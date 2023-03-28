import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/categoty_db.dart';
import 'package:moneymanagement/screens/category/add_category.dart';
import 'package:moneymanagement/screens/category/expense_list.dart';
import 'package:moneymanagement/screens/category/income_list.dart';

class AddCategoryIncome extends StatefulWidget {
  const AddCategoryIncome({super.key});

  @override
  State<AddCategoryIncome> createState() => _AddCategoryIncomeState();
}

class _AddCategoryIncomeState extends State<AddCategoryIncome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
            body: Column(
              children: [
                // TabBarView(children: [Text('income here'), Text('expense')]),

                TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    controller: _tabController,
                    tabs: const [
                      Tab(
                        text: 'Income',
                      ),
                      Tab(
                        text: 'Expense',
                      ),
                    ]),

                Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      children: const [
                        IncomeListCategory(),
                        ExpenseListCategory()
                      ]),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 16, 167, 89),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddCategory(
                        isexpense: _tabController.index == 0 ? false : true)));
              },
              child: const Icon(
                Icons.add,
              ),
            )));
  }
}
