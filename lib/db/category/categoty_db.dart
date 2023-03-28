import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:moneymanagement/models/category/category_model.dart';

const categoryDbName = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String id);
}

class CategoryDB implements CategoryDbFunctions {
  CategoryDB._internal();

  static CategoryDB instance = CategoryDB._internal();

  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListener =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryDB.put(value.id, value);

    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    return categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final allCategories = await getCategories();
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();
    await Future.forEach(
      allCategories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryListListener.value.add(category);
        } else {
          expenseCategoryListListener.value.add(category);
        }
      },
    );

    incomeCategoryListListener.notifyListeners();
    expenseCategoryListListener.notifyListeners();
  }

  // Future<void> deleteCategory(CategoryModel value) async {
  //   final categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
  //   await categoryDB.delete(value.id);
  //   refreshUI();
  // }
  @override
  Future<void> deleteCategory(String categoryID) async {
    final categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryDB.delete(categoryID);
    refreshUI();
  }

  @override
  Future<void> ResetAllCategory() async {
    final categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryDB.clear();
    await categoryDB.close();
    refreshUI();
  }
}
