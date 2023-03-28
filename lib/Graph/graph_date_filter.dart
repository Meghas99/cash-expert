import 'package:flutter/material.dart';
import 'package:moneymanagement/Graph/all_grap.dart';
import 'package:moneymanagement/db/transaction/transaction_db.dart';

class DateFilterGraph extends StatelessWidget {
  const DateFilterGraph({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      color: const Color.fromARGB(255, 101, 163, 150),
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
            // searchResultNotifier.value =
            //     TransactionDB.instance.transactionListNotifier.value;
            // searchResultNotifier.notifyListeners();

            overViewGraphNotifier.value =
                TransactionDB.instance.transactionListNotifier.value;
            overViewGraphNotifier.notifyListeners();
          },
        ),
        PopupMenuItem(
          // value: 2,
          child: const Text(
            "Today",
          ),
          onTap: () {
            overViewGraphNotifier.value =
                TransactionDB.instance.transactionListNotifier.value;
            var today = DateTime.now();
            var newList = overViewGraphNotifier.value
                .where((element) =>
                    element.date.day == today.day &&
                    element.date.month == today.month &&
                    element.date.year == today.year)
                .toList();
            overViewGraphNotifier.value = newList;
            overViewGraphNotifier.notifyListeners();
          },
        ),
        PopupMenuItem(
            // value: 3,
            child: const Text(
              "Yesterday",
            ),
            onTap: () {
              overViewGraphNotifier.value =
                  TransactionDB.instance.transactionListNotifier.value;
              var today = DateTime.now();
              var newList = overViewGraphNotifier.value
                  .where((element) =>
                      element.date.day == today.day - 1 &&
                      element.date.month == today.month &&
                      element.date.year == today.year)
                  .toList();
              overViewGraphNotifier.value = newList;
              overViewGraphNotifier.notifyListeners();
            }),
      ],
    );
  }
}
