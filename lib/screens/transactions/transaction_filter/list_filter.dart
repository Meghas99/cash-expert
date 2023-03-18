import 'package:flutter/material.dart';
import 'package:moneymanagement/db/transaction/transaction_db.dart';

class ListFilterTransaction extends StatelessWidget {
  const ListFilterTransaction({
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
      color: Color.fromARGB(255, 101, 163, 150),
      child: const Icon(
        Icons.list,
        color: Colors.black,
        // size: 0,
        // shadows: <Shadow>[Shadow(color: Colors.white, blurRadius: 15.0)],
      ),
      itemBuilder: (ctx) => [
        PopupMenuItem(
          value: 1,
          child: const Text(
            "All",
          ),
          onTap: () {
            TransactionDB.instance.filter(0);
          },
        ),
        PopupMenuItem(
          value: 2,
          child: const Text(
            "Income",
          ),
          onTap: () {
            TransactionDB.instance.filter(1);
          },
        ),
        PopupMenuItem(
            value: 3,
            child: const Text(
              "Expense",
            ),
            onTap: () {
              TransactionDB.instance.filter(2);
            }),
      ],
    );
  }
}
