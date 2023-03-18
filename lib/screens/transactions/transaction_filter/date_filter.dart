import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/db/transaction/transaction_db.dart';
import 'package:moneymanagement/screens/transactions/transaction_filter/date_range.dart';
import 'package:moneymanagement/screens/transactions/transaction_filter/search_transaction.dart';

// DateTime? first;
// DateTime? second;

class DateFilterTransaction extends StatefulWidget {
  const DateFilterTransaction({
    Key? key,
  }) : super(key: key);

  @override
  State<DateFilterTransaction> createState() => _DateFilterTransactionState();
}

class _DateFilterTransactionState extends State<DateFilterTransaction> {
  // DateTime? _startDate;
  // DateTime? _endDate;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      color: Color.fromARGB(255, 101, 163, 150),
      child: const Icon(
        Icons.sort,
        color: Colors.black,
        // size: 0,
        // shadows: <Shadow>[Shadow(color: Colors.white, blurRadius: 15.0)],
      ),
      itemBuilder: (ctx) => [
        PopupMenuItem(
          // value: 1,
          child: const Text(
            "All",
          ),
          onTap: () {
            searchResultNotifier.value =
                TransactionDB.instance.transactionListNotifier.value;
            searchResultNotifier.notifyListeners();
          },
        ),
        PopupMenuItem(
          // value: 2,
          child: const Text(
            "Today",
          ),
          onTap: () {
            searchResultNotifier.value =
                TransactionDB.instance.transactionListNotifier.value;
            var today = DateTime.now();
            var newList = searchResultNotifier.value
                .where((element) =>
                    element.date.day == today.day &&
                    element.date.month == today.month &&
                    element.date.year == today.year)
                .toList();
            searchResultNotifier.value = newList;
            searchResultNotifier.notifyListeners();
          },
        ),
        PopupMenuItem(
            // value: 3,
            child: const Text(
              "Yesterday",
            ),
            onTap: () {
              searchResultNotifier.value =
                  TransactionDB.instance.transactionListNotifier.value;
              var today = DateTime.now();
              var newList = searchResultNotifier.value
                  .where((element) =>
                      element.date.day == today.day - 1 &&
                      element.date.month == today.month &&
                      element.date.year == today.year)
                  .toList();
              searchResultNotifier.value = newList;
              searchResultNotifier.notifyListeners();
            }),
        PopupMenuItem(
          onTap: () async {
            if (first == null || second == null) {
              return;
            } else {
              await TransactionDB.instance.refresh();
              searchResultNotifier.value =
                  TransactionDB.instance.transactionListNotifier.value;
              var newList = searchResultNotifier.value

                  // var today = DateTime.now();

                  .where(
                    (element) =>
                        element.date.isAfter(
                            first!.subtract(const Duration(days: 1))) &&
                        element.date
                            .isBefore(second!.add(const Duration(days: 1))),
                  )
                  .toList();
              searchResultNotifier.value = newList;
              searchResultNotifier.notifyListeners();
              // print(_endDate);
              // print(_startDate);
            }
          },
          child: Row(children: [
            WidgetDateRange()

            // TextButton(
            //     onPressed: () async {
            //       final date = await showDatePicker(
            //         context: context,
            //         initialDate: _startDate ?? DateTime.now(),
            //         firstDate: DateTime(2022),
            //         lastDate: DateTime.now(),
            //       );
            //       if (date == null) {
            //         return;
            //       } else {
            //         setState(() {
            //           _startDate = date;
            //         });
            //       }
            //     },
            //     child: Text(
            //       _startDate == null ? 'From' : parseDate(_startDate!),
            //       style: TextStyle(color: Colors.black),
            //     )),
            // TextButton(
            //     onPressed: () async {
            //       DateTime? date = await showDatePicker(
            //           context: context,
            //           initialDate:
            //               _startDate != null ? _startDate! : DateTime.now(),
            //           firstDate:
            //               _startDate != null ? _startDate! : DateTime.now(),
            //           lastDate: DateTime.now());
            //       if (date != null) {
            //         setState(() {
            //           _endDate = date;
            //         });
            //       }
            //       // print(date);
            //     },
            //     child: Text(
            //       _endDate == null ? 'To' : parseDate(_endDate!),
            //       style: TextStyle(color: Colors.black),
            //     )),
            // ClipRRect(
            //     borderRadius: BorderRadius.circular(10),
            //     child: Container(
            //         height: 30,
            //         width: 30,
            //         color: Color.fromARGB(255, 131, 94, 212),
            //         child: Icon(Icons.check_circle)))
          ]),
        )
      ],
    );
  }

  String parseDate(DateTime date) {
    final parsedDate = DateFormat.yMMMd().format(date);
    final splittedDate = parsedDate.split(' ');
    return '${splittedDate.elementAt(1)} ${splittedDate.elementAt(0)} ${splittedDate.elementAt(2)}';
  }
}

// PopupMenuItem(
        //     value: 4,
        //     child: const Text(
        //       "one Month",
        //     ),
        //     onTap: () async {
        //       // searchResultNotifier.value =
        //       //     TransactionDB.instance.transactionListNotifier.value;
        //       // var today = DateTime.now();
        //       // var newList = searchResultNotifier.value
        //       //     .where((element) =>
        //       //         element.date.month == today.month &&
        //       //         element.date.year == today.year)
        //       //     .toList();
        //       // searchResultNotifier.value = newList;
        //       // searchResultNotifier.notifyListeners();

        //       final selectedDateTemp = await showDatePicker(
        //           context: context,
        //           initialDate: DateTime.now(),
        //           firstDate: DateTime.now().subtract(const Duration(days: 30)),
        //           lastDate: DateTime.now());

        //       if (selectedDateTemp == null) {
        //         return;
        //       } else {
        //         print(selectedDateTemp.toString());

        //         var newList = searchResultNotifier.value
        //             .where((element) =>
        //                 element.date.month == selectedDateTemp.month &&
        //                 element.date.year == selectedDateTemp.year)
        //             .toList();
        //         searchResultNotifier.value = newList;
        //         searchResultNotifier.notifyListeners();
        //       }
        //     }),
