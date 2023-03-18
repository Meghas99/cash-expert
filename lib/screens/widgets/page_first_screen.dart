import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:moneymanagement/Graph/all_grap.dart';

import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';
import 'package:moneymanagement/screens/transactions/all_transaction.dart';
import 'package:moneymanagement/screens/transactions/edit_transaction.dart';

import '../../db/transaction/transaction_db.dart';
import '../transactions/transaction_filter/search_transaction.dart';

class FrontPge extends StatefulWidget {
  const FrontPge({super.key});

  @override
  State<FrontPge> createState() => _FrontPgeState();
}

class _FrontPgeState extends State<FrontPge> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      overViewGraphNotifier.value =
          TransactionDB.instance.transactionListNotifier.value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                // decoration: const BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage('lib/images/rectangle.png'),
                //     fit: BoxFit.cover,
                //   ),
                //   borderRadius: BorderRadius.all(
                //     Radius.circular(10),
                //   ),
                // ),
                child: Image.asset(
                  'lib/images/rectangle.png',
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 150,
                width: 500,
                // color: Colors.pink,
                alignment: Alignment.center,
                // child: Text(
                //   '${totalBalance.value.abs().toString()} ₹',
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 30),
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: totalBalance,
                        builder:
                            (BuildContext ctx, dynamic value, Widget? child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              totalBalance.value >= 0
                                  ? const Text(
                                      'Total Balance',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  : const Text(
                                      'Loss',
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent),
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              totalBalance.value >= 0
                                  ? Text(
                                      '₹${totalBalance.value.abs().toString()} ',
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      '₹-${totalBalance.value.abs().toString()} ',
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.red,
                                      ),
                                    )
                            ],
                          );
                        })
                  ],
                ),
              ),
              Row(
                children: [
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: ValueListenableBuilder(
                        valueListenable: incomeTotal,
                        builder:
                            (BuildContext ctx, dynamic value, Widget? child) {
                          return SizedBox(
                            // color: Colors.pink,
                            // alignment: Alignment.centerLeft,
                            width: size.width * 0.5,
                            height: size.height * 0.13,
                            child: Column(
                              children: [
                                const Text(
                                  "Income",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '₹ ${incomeTotal.value.toString()} ',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: ValueListenableBuilder(
                        valueListenable: expenseTotal,
                        builder:
                            (BuildContext ctx, dynamic value, Widget? child) {
                          return SizedBox(
                            // color: Colors.green,
                            width: size.width * 0.3,
                            height: size.height * 0.13,

                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Expense",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '- ₹ ${expenseTotal.value.toString()} ',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                ],
              )
            ],
          ),
        ),
        ListTile(
          leading: TextButton(
            onPressed: () {},
            child: const Text(
              'Tranasactions',
              style: TextStyle(
                backgroundColor: Color.fromARGB(199, 127, 205, 149),
                color: Color.fromARGB(255, 26, 26, 31),
              ),
            ),
          ),
          trailing: TextButton(
            onPressed: () {
              // searchResultNotifier.value =
              //     TransactionDB.instance.transactionListNotifier.value;
              // searchResultNotifier.notifyListeners();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: ((context) => const AllTransactions())),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: const Text(
                'View all',
                style: TextStyle(
                    backgroundColor: Color.fromARGB(199, 127, 205, 149),
                    color: Color.fromARGB(255, 31, 26, 26)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 300,
          child: ValueListenableBuilder(
              valueListenable: TransactionDB.instance.transactionListNotifier,
              builder: (BuildContext context, List<TransactionModel> newList,
                  Widget? _) {
                return Column(
                  children: [
                    Expanded(
                      child: newList.isEmpty
                          ? Center(
                              child: Lottie.network(
                                  'https://assets5.lottiefiles.com/packages/lf20_rdjfuniz.json'),
                            )
                          : ListView.builder(
                              // ignore: unnecessary_null_comparison
                              itemCount: newList == null
                                  ? 0
                                  : (newList.length > 3 ? 3 : newList.length),
                              itemBuilder: (ctx, index) {
                                final value = newList[index];

                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        255, 195, 202, 213),
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          TextButton(
                                                            onPressed: (() {
                                                              TransactionDB
                                                                  .instance
                                                                  .deleteTransaction(
                                                                      value
                                                                          .id!);

                                                              TransactionDB
                                                                  .instance
                                                                  .refresh();
                                                              searchResultNotifier
                                                                      .value =
                                                                  TransactionDB
                                                                      .instance
                                                                      .transactionListNotifier
                                                                      .value;
                                                              searchResultNotifier
                                                                  .notifyListeners();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }),
                                                            child: const Text(
                                                              'yes',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: (() {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }),
                                                            child: const Text(
                                                              'no',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green),
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
                                            backgroundColor:
                                                const Color.fromARGB(
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
                                            backgroundColor:
                                                const Color.fromARGB(
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
                                              color: Color.fromARGB(
                                                  255, 21, 28, 111)),
                                        ),
                                        trailing: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                value.type ==
                                                        CategoryType.income
                                                    ? Text(
                                                        '+₹ ${value.amount}',
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    20,
                                                                    171,
                                                                    25)),
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
                );
              }),
        ),
      ]),
    ));
  }

  String parseDate(DateTime date) {
    final dates = DateFormat.MMMd().format(date);
    final splitedDate = dates.split(' ');

    return '${splitedDate.last} ${splitedDate.first}';
    //return '${date.day}\n ${date.month}';
  }
}
