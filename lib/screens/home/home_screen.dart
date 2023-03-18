import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/categoty_db.dart';
import 'package:moneymanagement/db/transaction/transaction_db.dart';

import 'package:moneymanagement/screens/category/category_page.dart';
import 'package:moneymanagement/screens/transactions/add_transaction.dart';
import 'package:moneymanagement/screens/home/bottom_navigation.dart';
import 'package:moneymanagement/screens/widgets/page_first_screen.dart';

import 'package:moneymanagement/Graph/graph_screen.dart';
import 'package:moneymanagement/settings/about.dart';
import 'package:moneymanagement/settings/help.dart';
import 'package:moneymanagement/settings/privacy_policy.dart';
import 'package:moneymanagement/settings/terms_and_condition.dart';

final _pages = [
  const FrontPge(),
  const AddCategoryIncome(),
  const AddIncome(),
  const ScreenGraph()
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              child: const Icon(
                Icons.settings,
                color: Color.fromARGB(255, 95, 135, 154),
              ),
              onTap: () {
                return showSettingsModelBottomSheet(context);
              },
            ),
            const SizedBox(
              width: 100,
            ),
            const Text(
              'Cash expert',
              style:
                  TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
        elevation: 0,
      ),
      backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (context, updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
    );
  }

  void showSettingsModelBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 500,
            width: double.infinity,
            color: const Color.fromARGB(255, 150, 225, 221),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  buildMenuItems(
                    context,
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  const Text('App Version'),
                  const Text('2.0'),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          // runSpacing: 5,
          children: [
            Card(
              color: const Color.fromARGB(255, 150, 225, 221),
              shape: RoundedRectangleBorder(
                //<-- SEE HERE
                // side: BorderSide(width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) {
                        return (PageHelp());
                      }),
                    ),
                  );
                },
                title: const Text(
                  'Help',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 20, 30, 84),
                  ),
                ),
                leading: const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 65, 203, 69),
                  radius: 10,
                  child: Icon(
                    Icons.question_mark,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Card(
              color: const Color.fromARGB(255, 150, 225, 221),
              shape: RoundedRectangleBorder(
                //<-- SEE HERE
                // side: BorderSide(width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) {
                        return (const AboutScreen());
                      }),
                    ),
                  );
                },
                title: const Text(
                  'About',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 20, 30, 84),
                  ),
                ),
                leading: const Icon(
                  Icons.info_rounded,
                  color: Color.fromARGB(255, 65, 203, 69),
                ),
              ),
            ),
            Card(
              color: const Color.fromARGB(255, 150, 225, 221),
              // elevation: 8,
              shape: RoundedRectangleBorder(
                //<-- SEE HERE
                // side: BorderSide(width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) {
                        return (const ScreenPrivacyPolicy());
                      }),
                    ),
                  );
                },
                title: const Text(
                  ' Privacy Policy',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 20, 30, 84),
                  ),
                ),
                leading: const Icon(
                  Icons.privacy_tip,
                  color: Color.fromARGB(255, 65, 203, 69),
                ),
              ),
            ),
            Card(
              color: const Color.fromARGB(255, 150, 225, 221),
              //fromRGBO(183, 244, 235, 0.902)
              shape: RoundedRectangleBorder(
                //<-- SEE HERE
                // side: BorderSide(width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) {
                        return (const ScreenTermsAndCondition());
                      }),
                    ),
                  );
                },
                title: const Text(
                  'Terms and Condition',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 20, 30, 84),
                  ),
                ),
                leading: const Icon(
                  Icons.book_rounded,
                  color: Color.fromARGB(255, 65, 203, 69),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: ((context) {
                    return AlertDialog(
                      content: const Text(
                        'Do you want to remove all data!!',
                        style: TextStyle(
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
                                CategoryDB.instance.ResetAllCategory();
                                TransactionDB.instance.refreshAllTransaction();
                                Navigator.of(context).pop();
                              }),
                              child: const Text(
                                'yes',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: (() {
                                Navigator.of(context).pop();
                              }),
                              child: const Text(
                                'no',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                );
              },
              child: const Card(
                color: Color.fromARGB(255, 150, 225, 221),
                child: ListTile(
                  leading: Icon(
                    Icons.restart_alt,
                    color: Color.fromARGB(255, 65, 203, 69),
                  ),
                  title: Text(
                    'Reset',
                    style: TextStyle(
                      color: Color.fromARGB(255, 20, 30, 84),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
