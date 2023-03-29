import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moneymanagement/db/transaction/transaction_db.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';

ValueNotifier<List<TransactionModel>> searchResultNotifier = ValueNotifier([]);
List<TransactionModel> filteredList = [];
List<TransactionModel> dateFilteredList = [];
final TextEditingController _searchQueryController = TextEditingController();

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  void initState() {
    super.initState();

    searchResultNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;
    filteredList = TransactionDB.instance.transactionListNotifier.value;
    dateFilteredList = TransactionDB.instance.transactionListNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    log('$searchResultNotifier');

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
            //autofocus: false,

            controller: _searchQueryController,
            onChanged: (query) {
              print(".........$_searchQueryController");
              log('search controller onChanged called');
              refreshSearchResult();
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
                      refreshSearchResult();
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

refreshSearchResult() async {
  log('refresh search result');
  searchResultNotifier.value = [];

  log('total in db:${TransactionDB.instance.transactionListNotifier.value.length}');
  for (var element in TransactionDB.instance.transactionListNotifier.value) {
    log('total in filtered List:${filteredList.length}');
    log('total in dateFiltered List:${dateFilteredList.length}');
    if (filteredList.contains(element) && dateFilteredList.contains(element)) {
      searchResultNotifier.value.add(element);
    }
  }
  log('::${searchResultNotifier.value.length}');
  if (_searchQueryController.text.isNotEmpty) {
    searchResultNotifier.value = searchResultNotifier.value
        .where((element) =>
            element.category.name
                .toLowerCase()
                .contains(_searchQueryController.text.toLowerCase()) ||
            element.amount.toString().contains(_searchQueryController.text) ||
            element.notes
                .toLowerCase()
                .contains(_searchQueryController.text.toLowerCase()))
        .toList();
  }
  log('------${searchResultNotifier.value.length}');
  searchResultNotifier.notifyListeners();
}
