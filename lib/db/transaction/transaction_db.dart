import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';
import 'package:moneymanagement/screens/transactions/transaction_filter/search_transaction.dart';

const transactionDbName = 'transaction-db';

abstract class TransactionFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransaction(String id);
  Future<void> editTransaction(String id, TransactionModel obj);
}

ValueNotifier expenseTotal = ValueNotifier(0.0);
ValueNotifier incomeTotal = ValueNotifier(0.0);
ValueNotifier totalBalance = ValueNotifier(0.0);

class TransactionDB implements TransactionFunctions {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> transactionIncomeListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> transactionExpenseListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    await db.put(obj.id, obj);
    // await db.add(obj);
  }

  Future<void> refresh() async {
    final list = await getAllTransactions();

    list.sort((first, second) => second.date.compareTo(first.date));

    transactionExpenseListNotifier.value.clear();
    transactionIncomeListNotifier.value.clear();

    await Future.forEach(list, (TransactionModel transaction) {
      if (transaction.type == CategoryType.income) {
        transactionIncomeListNotifier.value.add(transaction);
      } else if (transaction.type == CategoryType.expense) {
        transactionExpenseListNotifier.value.add(transaction);
      }
    });

    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);

    incomeAndExpense();

    transactionListNotifier.notifyListeners();
    transactionExpenseListNotifier.notifyListeners();
    transactionIncomeListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    return db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    db.delete(id);
    await refresh();
  }

  @override
  Future<void> editTransaction(String id, TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    db.put(id, obj);
    refresh();
  }

  filter(int indx) {
    if (indx == 0) {
      filteredList = transactionListNotifier.value;
    } else if (indx == 1) {
      filteredList = transactionIncomeListNotifier.value;
    } else {
      filteredList = transactionExpenseListNotifier.value;
    }
    refreshSearchResult();
  }

  Future<void> refreshAllTransaction() async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    await db.clear();
    await db.close();
    refresh();
  }
}

void incomeAndExpense() {
  incomeTotal.value = 0;
  expenseTotal.value = 0;
  totalBalance.value = 0;

  final List<TransactionModel> value =
      TransactionDB.instance.transactionListNotifier.value;

  for (int i = 0; i < value.length; i++) {
    if (CategoryType.income == value[i].category.type) {
      incomeTotal.value = incomeTotal.value + value[i].amount;
    } else {
      expenseTotal.value = expenseTotal.value + value[i].amount;
    }
  }
  totalBalance.value = incomeTotal.value - expenseTotal.value;
}
