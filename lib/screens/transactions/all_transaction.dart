import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:moneymanagement/db/transaction/transaction_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';
import 'package:moneymanagement/screens/transactions/edit_transaction.dart';

import 'package:moneymanagement/screens/transactions/transaction_filter/date_filter.dart';
import 'package:moneymanagement/screens/transactions/transaction_filter/list_filter.dart';

import 'package:moneymanagement/screens/transactions/transaction_filter/search_transaction.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({super.key});

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  @override
  void initState() {
    TransactionDB.instance.refresh();
    searchResultNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // incomeAndExpense();
    TransactionDB.instance.refresh();

    return ValueListenableBuilder(
        valueListenable: searchResultNotifier,
        builder:
            (BuildContext context, List<TransactionModel> newList, Widget? _) {
          return Scaffold(
            backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color.fromARGB(255, 87, 84, 84),
                  )),
              backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
              actions: const <Widget>[
                ListFilterTransaction(),
                SizedBox(
                  width: 20,
                ),
                DateFilterTransaction(),
              ],
              centerTitle: true,
              title: const Text(
                'All Transactions',
                style: TextStyle(color: Color.fromARGB(255, 21, 47, 68)),
              ),
            ),
            body: Column(
              children: [
                const SearchField(),
                Expanded(
                  child: newList.isEmpty
                      ? Center(
                          child: Lottie.network(
                              'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                        )
                      : ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          itemCount: newList.length,
                          itemBuilder: (ctx, index) {
                            final value = newList[index];

                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                color: const Color.fromARGB(255, 195, 202, 213),
                                elevation: 0,
                                child: Slidable(
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (ctx) async {
                                          showDialog(
                                            context: context,
                                            builder: ((context) {
                                              return AlertDialog(
                                                content: const Text(
                                                  'Do you want to delete?',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextButton(
                                                        onPressed: (() {
                                                          TransactionDB.instance
                                                              .deleteTransaction(
                                                                  value.id!);

                                                          TransactionDB.instance
                                                              .refresh();
                                                          searchResultNotifier
                                                                  .value =
                                                              TransactionDB
                                                                  .instance
                                                                  .transactionListNotifier
                                                                  .value;
                                                          searchResultNotifier
                                                              .notifyListeners();
                                                          Navigator.of(context)
                                                              .pop();
                                                        }),
                                                        child: const Text(
                                                          'yes',
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: (() {
                                                          Navigator.of(context)
                                                              .pop();
                                                        }),
                                                        child: const Text(
                                                          'no',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            }),
                                          );
                                        },
                                        icon: Icons.delete,
                                        foregroundColor: Colors.red,
                                        label: 'delete',
                                        backgroundColor: const Color.fromARGB(
                                            255, 167, 215, 203),
                                      ),
                                      SlidableAction(
                                        onPressed: (ctx) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: ((context) {
                                                return (EditTransaction(
                                                  currentDatas: value,
                                                ));
                                              }),
                                            ),
                                          );
                                        },
                                        icon: Icons.edit,
                                        foregroundColor: Colors.indigo[500],
                                        label: 'edit',
                                        backgroundColor: const Color.fromARGB(
                                            255, 167, 215, 203),
                                      )
                                    ],
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 23,
                                      backgroundColor:
                                          value.type == CategoryType.income
                                              ? Colors.greenAccent[700]
                                              : Colors.orange,
                                      child: Icon(
                                        value.type == CategoryType.income
                                            ? Icons.currency_rupee
                                            : Icons.shopping_bag,
                                        color: const Color.fromARGB(
                                            255, 241, 233, 233),
                                      ),
                                    ),
                                    title: Text(
                                      value.category.name,
                                    ),
                                    subtitle: Text(
                                      value.notes,
                                      // maxLines: 1,
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 21, 28, 111)),
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            value.type == CategoryType.income
                                                ? Text(
                                                    '+₹ ${value.amount}',
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 20, 171, 25)),
                                                  )
                                                : Text(
                                                    '-₹ ${value.amount}',
                                                    style: const TextStyle(
                                                        color: Colors.red),
                                                  ),
                                            Text(
                                              parseDate(value.date),
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Color.fromARGB(
                                                      255, 38, 6, 127)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        });
  }

  String parseDate(DateTime date) {
    final dates = DateFormat.MMMd().format(date);
    final splitedDate = dates.split(' ');

    return '${splitedDate.last} ${splitedDate.first}';
    //return '${date.day}\n ${date.month}';
  }
}
