import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/categoty_db.dart';
import 'package:moneymanagement/db/transaction/transaction_db.dart';

import 'package:moneymanagement/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigatehome();
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.refresh();
    super.initState();
  }

  void navigatehome() async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            "lib/images/splash.jpg",
            fit: BoxFit.cover,
          )),
      const Center(
        child: Text(
          "Cash Expert",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      )
    ]));
  }
}
