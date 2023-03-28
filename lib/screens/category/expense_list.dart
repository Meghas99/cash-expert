import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/categoty_db.dart';

import '../../models/category/category_model.dart';

class ExpenseListCategory extends StatelessWidget {
  const ExpenseListCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().expenseCategoryListListener,
        builder:
            (BuildContext context, List<CategoryModel> newlist, Widget? _) {
          return Padding(
            padding: const EdgeInsets.all(50.0),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  final Category = newlist[index];

                  return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    tileColor: const Color.fromARGB(255, 34, 175, 102),
                    title: Text(
                      Category.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              content: const Text(
                                'Do you want to delete?',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: (() {
                                        CategoryDB.instance
                                            .deleteCategory(Category.id);

                                        Navigator.of(context).pop();
                                      }),
                                      child: const Text(
                                        'yes',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: (() {
                                        Navigator.of(context).pop();
                                      }),
                                      child: const Text(
                                        'no',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        );
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: newlist.length),
          );
        });
  }
}
