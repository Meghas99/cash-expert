import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 165, 171, 180)),
                // color: Colors.amber,
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromARGB(255, 222, 117, 12),
                    child: Icon(
                      Icons.food_bank,
                    ),
                  ),
                  title: const Text('Food'),
                  trailing: TextButton(
                    onPressed: () {},
                    child: Column(
                      children: const [
                        Text(
                          '-₹45.00',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 207, 27, 27)),
                        ),
                        Text(
                          '05.10.2023',
                          style: TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 38, 6, 127)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 165, 171, 180)),
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromARGB(255, 61, 12, 222),
                    child: Icon(
                      Icons.shopping_bag,
                    ),
                  ),
                  title: const Text('Shopping'),
                  trailing: TextButton(
                    onPressed: () {},
                    child: Column(
                      children: const [
                        Text(
                          '-₹45.00',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 207, 27, 27)),
                        ),
                        Text(
                          '05.10.2023',
                          style: TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 38, 6, 127)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 165, 171, 180)),
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromARGB(255, 10, 200, 10),
                    child: Icon(
                      Icons.currency_rupee,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text('Salary'),
                  trailing: TextButton(
                    onPressed: () {},
                    child: Column(
                      children: const [
                        Text(
                          '-₹45.00',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 207, 27, 27)),
                        ),
                        Text(
                          '05.10.2023',
                          style: TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 38, 6, 127)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 165, 171, 180)),
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromARGB(255, 86, 161, 196),
                    child: Icon(
                      Icons.travel_explore,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text('Travel'),
                  trailing: TextButton(
                    onPressed: () {},
                    child: Column(
                      children: const [
                        Text(
                          '-₹45.00',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 207, 27, 27)),
                        ),
                        Text(
                          '05.10.2023',
                          style: TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 38, 6, 127)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
