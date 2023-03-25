import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/categoty_db.dart';
import 'package:moneymanagement/db/transaction/transaction_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';
import 'package:moneymanagement/screens/home/home_screen.dart';
import 'package:moneymanagement/screens/transactions/transaction_filter/search_transaction.dart';

class EditTransaction extends StatefulWidget {
  const EditTransaction({super.key, required this.currentDatas});
  final TransactionModel currentDatas;
  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCtegoryModel;

  String? categoryid;

  late final TextEditingController _noteTextEditingController;

  late final TextEditingController _amoundTextEditingController;

  // bool autovalidate = false;
  final _formKey = GlobalKey<FormState>();
  String dateString = 'select date';

  List<String> monthList = [
    "Jan",
    "Feb",
    "Mrc",
    "Apr",
    "May",
    "Jun",
    "July",
    "Aug",
    "Spt",
    "Oct",
    "Nuv",
    "Dec"
  ];
  @override
  void initState() {
    _selectedCtegoryModel = widget.currentDatas.category;
    _selectedDate = widget.currentDatas.date;
    _noteTextEditingController =
        TextEditingController(text: widget.currentDatas.notes);

    _amoundTextEditingController =
        TextEditingController(text: widget.currentDatas.amount.toString());

    _selectedCategoryType = widget.currentDatas.type;

    dateString =
        '${_selectedDate!.day} ${monthList[_selectedDate!.month - 1]} ${_selectedDate!.year} ';

    categoryid = widget.currentDatas.category.id;

    if (CategoryDB.instance.incomeCategoryListListener.value
            .contains(widget.currentDatas.category) ||
        CategoryDB.instance.expenseCategoryListListener.value
            .contains(widget.currentDatas.category)) {
    } else {
      categoryid = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(_selectedCtegoryModel.toString());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 167, 215, 203),
      body: SafeArea(
        child: DefaultTabController(
            length: 2,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    //radio button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: CategoryType.income,
                              groupValue: _selectedCategoryType,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedCategoryType = CategoryType.income;
                                });
                              },
                            ),
                            const Text('Income')
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: CategoryType.expense,
                              groupValue: _selectedCategoryType,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedCategoryType = CategoryType.expense;
                                  categoryid = null;
                                });
                              },
                            ),
                            const Text('Expense')
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: (Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        height: 20,
                        width: 100,
                        child: const Center(
                          child: Text(
                            'Add money',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    //amound

                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.9,
                      // padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        validator: (value) {
                          // log("amount Validating");
                          if (value == null || value.isEmpty) {
                            // log('value is empty or null');
                            return 'Please enter amount';
                          }
                          // log('value is not empty nor null');
                          return null;
                        },
                        style: const TextStyle(
                            color: Color.fromARGB(255, 31, 29, 29),
                            fontSize: 30),
                        textAlign: TextAlign.center,
                        controller: _amoundTextEditingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 1,
                              )),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 195, 202, 213),
                              width: 1,
                            ),
                          ),

                          fillColor: const Color.fromARGB(255, 195, 202, 213),
                          filled: true,
                          isCollapsed: true,
                          // border: InputBorder.none,
                          hintText: '₹',
                          hintStyle: const TextStyle(
                            fontSize: 45,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    //select category----------------------------------------------------------------------------------

                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      // padding: const EdgeInsets.only(left: 20),
                      child: DropdownButtonFormField<String>(
                        borderRadius: BorderRadius.circular(50),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                              )),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 195, 202, 213),
                              width: 0,
                            ),
                          ),
                          fillColor: const Color.fromARGB(255, 195, 202, 213),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            log('value is empty or null');
                            return 'please choose category';
                          }
                          return null;
                        },
                        hint: const Text('Category'),
                        value: categoryid,
                        items: (_selectedCategoryType == CategoryType.income
                                ? CategoryDB.instance.incomeCategoryListListener
                                : CategoryDB
                                    .instance.expenseCategoryListListener)
                            .value
                            .map(
                          (e) {
                            return DropdownMenuItem(
                              value: e.id,
                              child: Text(e.name),
                              onTap: () {
                                setState(() {
                                  _selectedCtegoryModel = e;
                                  log(e.toString());
                                });
                              },
                            );
                          },
                        ).toList(),
                        onChanged: (selectedValue) {
                          // print(selectedValue);

                          setState(
                            () {
                              categoryid = selectedValue;
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //notes
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,

                      // padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        validator: (value) {
                          // log("amount Validating");
                          if (value == null || value.isEmpty) {
                            // log('value is empty or null');
                            return 'Please add notes';
                          }
                          // log('value is not empty nor null');
                          return null;
                        },
                        style: const TextStyle(
                            color: Color.fromARGB(255, 31, 29, 29)),
                        // textAlign: TextAlign.center,
                        controller: _noteTextEditingController,

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                              )),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 195, 202, 213),
                              width: 0,
                            ),
                          ),

                          fillColor: const Color.fromARGB(255, 195, 202, 213),
                          filled: true,
                          // isCollapsed: true,
                          contentPadding: const EdgeInsets.all(15),
                          // border: InputBorder.none,
                          hintText: 'Note',
                          hintStyle: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //callender

                    Container(
                      height: 50,
                      alignment: AlignmentDirectional.centerStart,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 195, 202, 213)),
                      child: TextButton.icon(
                        onPressed: () async {
                          final selectedDateTemp = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 30)),
                              lastDate: DateTime.now());

                          if (selectedDateTemp == null) {
                            return;
                          } else {
                            // print(selectedDateTemp.toString());
                            setState(() {
                              _selectedDate = selectedDateTemp;

                              dateString =
                                  "${selectedDateTemp.day} ${monthList[selectedDateTemp.month - 1]} ${selectedDateTemp.year} ";
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.calendar_today,
                          size: 10,
                          color: Color.fromARGB(255, 68, 54, 10),
                        ),
                        label: Text(
                          _selectedDate == null
                              ? 'Date'
                              // : _selectedDate!.toString(),
                              : dateString,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 72, 70, 70)),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor:
                            const Color.fromARGB(255, 20, 197, 173),
                        fixedSize: const Size(200, 50),
                      ),
                      onPressed: () async {
                        log('Save button Pressed');
                        if (_formKey.currentState!.validate()) {
                          log('Validation Successful');
                          await addTransaction();
                          HomeScreen.selectedIndexNotifier.value = 0;
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('saved'),
                            backgroundColor: (Colors.black12),
                          ));
                        } else {
                          log('Validator failed');
                        }

                        Navigator.of(context).pop();
                      },
                      child: const Text('SAVE'),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future<void> addTransaction() async {
    final noteText = _noteTextEditingController.text;
    final amountText = _amoundTextEditingController.text;

    if (noteText.isEmpty) {
      return;
    }

    if (amountText.isEmpty) {
      return;
    }

    // if (categoryid == null) {
    //   return;
    // }
    if (_selectedDate == null) {
      return;
    }

    if (_selectedCtegoryModel == null) {
      return;
    }

    final parseAmount = double.tryParse(amountText);

    if (parseAmount == null) {
      return;
    }
// _selectedDate
//     _selectedCategoryType
// categoryid

    final model = TransactionModel(
        notes: noteText,
        amount: parseAmount,
        date: _selectedDate!,
        type: _selectedCategoryType!,
        category: _selectedCtegoryModel!);

    model.id = widget.currentDatas.id;

    await TransactionDB.instance.editTransaction(model.id!, model);
    TransactionDB.instance.refresh();
    searchResultNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;
    searchResultNotifier.notifyListeners();
  }
}
