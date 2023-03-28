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
        Icons.calendar_month_rounded,
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
            dateFilteredList =
                TransactionDB.instance.transactionListNotifier.value;
            refreshSearchResult();
          },
        ),
        PopupMenuItem(
          // value: 2,
          child: const Text(
            "Today",
          ),
          onTap: () {
            dateFilteredList =
                TransactionDB.instance.transactionListNotifier.value;
            var today = DateTime.now();
            dateFilteredList = dateFilteredList
                .where((element) =>
                    element.date.day == today.day &&
                    element.date.month == today.month &&
                    element.date.year == today.year)
                .toList();
            refreshSearchResult();
          },
        ),
        PopupMenuItem(
            // value: 3,
            child: const Text(
              "Yesterday",
            ),
            onTap: () {
              dateFilteredList =
                  TransactionDB.instance.transactionListNotifier.value;
              var today = DateTime.now();
              dateFilteredList = dateFilteredList
                  .where((element) =>
                      element.date.day == today.day - 1 &&
                      element.date.month == today.month &&
                      element.date.year == today.year)
                  .toList();
              refreshSearchResult();
            }),
        PopupMenuItem(
          onTap: () async {
            if (first == null || second == null) {
              return;
            } else {
              await TransactionDB.instance.refresh();
              dateFilteredList =
                  TransactionDB.instance.transactionListNotifier.value;
              dateFilteredList = dateFilteredList
                  .where(
                    (element) =>
                        element.date.isAfter(
                            first!.subtract(const Duration(days: 1))) &&
                        element.date
                            .isBefore(second!.add(const Duration(days: 1))),
                  )
                  .toList();
              refreshSearchResult();

              // print(_endDate);
              // print(_startDate);
            }
          },
          child: Row(children: const [WidgetDateRange()]),
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
