import 'package:flutter/material.dart';

import 'package:moneymanagement/screens/home/home_screen.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndexNotifier,
      builder: (BuildContext context, int updatedIntex, Widget? _) {
        return BottomNavigationBar(
          onTap: (newIndex) {
            HomeScreen.selectedIndexNotifier.value = newIndex;

            // if (value == 0) {
            //   Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => const AddCategoryIncome()));
            // }
            // if (value == 1) {
            //   Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) {
            //       return const AddIncome();
            //     },
            //   ));
            // }
            // if (value == 2) {
            //   Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => const ScreenGraph(),
            //   ));
            // }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
          currentIndex: updatedIntex,
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: ' Trasaction',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_graph),
              label: 'graph',
            ),
          ],
        );
      },
    );
  }
}
