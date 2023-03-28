import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/categoty_db.dart';
import 'package:moneymanagement/db/transaction/transaction_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';
import 'package:moneymanagement/screens/category/add_category.dart';
import 'package:moneymanagement/screens/home/home_screen.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

FocusNode _focusNode = FocusNode();

class _AddIncomeState extends State<AddIncome> {
  DateTime? _selectedDate = DateTime.now();
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCtegoryModel;

  // ignore: non_constant_identifier_names
  String? _CategoryID;

  final _noteTextEditingController = TextEditingController();
  final _amoundTextEditingController = TextEditingController();
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
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sceenWidth = MediaQuery.of(context).size.width;
    final sceenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
        length: 2,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
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
                                _CategoryID = null;
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
                    width: 150,
                    height: 80,
                    // padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(
                      focusNode: _focusNode,
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
                          color: Color.fromARGB(255, 31, 29, 29), fontSize: 30),
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
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 195, 202, 213),
                            // width: 1,
                          ),
                        ),

                        fillColor: const Color.fromARGB(255, 195, 202, 213),
                        filled: true,
                        // isCollapsed: true,
                        // border: InputBorder.none,
                        hintText: '₹',
                        hintStyle: const TextStyle(
                          fontSize: 45,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //select category

                  SizedBox(
                    height: MediaQuery.of(context).size.width / 6.2,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: ValueListenableBuilder(
                              valueListenable:
                                  CategoryDB().expenseCategoryListListener,
                              builder:
                                  (context, selectCategoryexpense, child_) {
                                return ValueListenableBuilder(
                                    valueListenable:
                                        CategoryDB().incomeCategoryListListener,
                                    builder: (context, selectCategoryincome,
                                        child_) {
                                      return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,

                                        // padding: const EdgeInsets.only(left: 20),
                                        child: DropdownButtonFormField<String>(
                                          // focusNode: _focusNode,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                  width: 0,
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(28),
                                              borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 195, 202, 213),
                                                width: 0,
                                              ),
                                            ),
                                            fillColor: const Color.fromARGB(
                                                255, 195, 202, 213),
                                            filled: true,
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              log('value is empty or null');
                                              return 'please choose category';
                                            }
                                            return null;
                                          },
                                          hint: const Text('Category'),
                                          value: _CategoryID,
                                          items: (_selectedCategoryType ==
                                                      CategoryType.income
                                                  ? selectCategoryincome
                                                  : selectCategoryexpense)
                                              .map(
                                            (e) {
                                              return DropdownMenuItem(
                                                value: e.id,
                                                child: Text(e.name),
                                                onTap: () {
                                                  _selectedCtegoryModel = e;
                                                },
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (selectedValue) {
                                            //  print(selectedValue);

                                            setState(
                                              () {
                                                _CategoryID = selectedValue;
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    });
                              }),
                        ),
                        IconButton(
                            onPressed: (() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddCategory(
                                        isexpense: _selectedCategoryType ==
                                                CategoryType.income
                                            ? false
                                            : true,
                                      )));
                            }),
                            icon: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    height: 30,
                                    width: 30,
                                    color: const Color.fromARGB(
                                        255, 195, 202, 213),
                                    child: const Icon(Icons.add))))
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //notes===========================================================================================================================
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 6.5,
                    width: MediaQuery.of(context).size.width / 1.2,

                    // padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(
                      // focusNode: _focusNode,
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

                  // const SizedBox(
                  //   height: 10,
                  // ),

                  //callender--------=============================================================================================

                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      height: sceenHeight * 0.07,
                      alignment: AlignmentDirectional.centerStart,
                      width: sceenWidth * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(195, 202, 213, 1)),
                      child: TextButton.icon(
                        focusNode: _focusNode,
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
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
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color.fromARGB(255, 20, 197, 173),
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
                    },
                    child: const Text('SAVE'),
                  ),
                ],
              ),
            ),
          ),
        ));
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

    // if (_CategoryID == null) {
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

    final model = TransactionModel(
        notes: noteText,
        amount: parseAmount,
        date: _selectedDate!,
        // date: DateTime.now(),
        type: _selectedCategoryType!,
        category: _selectedCtegoryModel!);

    await TransactionDB.instance.addTransaction(model);
    TransactionDB.instance.refresh();
  }
}
