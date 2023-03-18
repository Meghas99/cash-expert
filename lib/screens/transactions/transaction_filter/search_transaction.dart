import 'package:flutter/material.dart';
import 'package:moneymanagement/db/transaction/transaction_db.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';

ValueNotifier<List<TransactionModel>> searchResultNotifier = ValueNotifier([]);

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchQueryController = TextEditingController();

  @override
  void initState() {
    searchResultNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TransactionDB.instance.refresh();
    // incomeAndExpense();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        color: const Color.fromARGB(255, 195, 202, 213),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextField(
            controller: _searchQueryController,
            onChanged: (query) {
              searchResultNotifier.value =
                  TransactionDB.instance.transactionListNotifier.value;
              searchResult(query, context);
            },
            decoration: InputDecoration(
                hintText: 'Search..',
                border: InputBorder.none,
                icon: const Icon(
                  Icons.search,
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      _searchQueryController.clear();
                    },
                    icon: const Icon(
                      Icons.close,
                      // color: Colors.black,
                    ))),
          ),
        ),
      ),
    );
  }
}

searchResult(String query, BuildContext context) {
  if (query.isEmpty) {
  } else {
    searchResultNotifier.value = TransactionDB
        .instance.transactionListNotifier.value
        .where((element) =>
            element.category.name.toLowerCase().contains(query.toLowerCase()) ||
            element.amount.toString().contains(query) ||
            element.notes.toLowerCase().contains(query.toLowerCase()))
        .toList();
    searchResultNotifier.notifyListeners();
  }
}
