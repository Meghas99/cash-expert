import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/categoty_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

class AddCategory extends StatelessWidget {
  AddCategory({super.key, required this.isexpense});

  bool isexpense;

  final _nameEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    selectedCategoryNotifier.value =
        isexpense ? CategoryType.expense : CategoryType.income;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add Category',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 34, 73, 106)),
        ),
        backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
      ),
      backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: const [
                  Radiobutton(title: 'Income', type: CategoryType.income),
                  Radiobutton(title: 'Expense', type: CategoryType.expense)
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 20, 143, 36),
              ),
              onPressed: () {
                final name = _nameEditingController.text;
                if (name.isEmpty) {
                  return;
                }
                final type = selectedCategoryNotifier.value;
                final category = CategoryModel(
                    id: DateTime.now().microsecondsSinceEpoch.toString(),
                    name: name,
                    type: type);

                CategoryDB().insertCategory(category);
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

class Radiobutton extends StatelessWidget {
  final String title;
  final CategoryType type;
  // final CategoryType selectedCategoryType;

  const Radiobutton({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder:
                (BuildContext context, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                value: type,
                groupValue: newCategory,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedCategoryNotifier.value = value;
                  selectedCategoryNotifier.notifyListeners(); // setState(() {
                  // _type = value;
                  // });
                },
              );
            }),
        Text(title)
      ],
    );
  }
}
