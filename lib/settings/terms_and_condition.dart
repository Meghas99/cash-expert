import 'package:flutter/material.dart';

class ScreenTermsAndCondition extends StatelessWidget {
  const ScreenTermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Terms and Condition',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 11, 32, 138)),
        ),
        backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
      ),
      backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Welcome to Cash Expert, these are the terms and conditions outline the rules and regulations for the use of money. By using htis app awe assume you accept these terms and conditions. Do not continue ton use money Tracker if you do not agree to take all of the terms and conditipon stated on this page.The following terminology applies to these terms and condition. Privacy statement and disclaimer notice and all agreements: "Client"."You" and "Your" referes to you, the person log on this website and complaint to the company terms and conditions. "The company" , "Our selfs", "We", "Our", "Us", refers to both the client and ourselves. All terms refers to the offer , acceptance and consideraiton of payment necessary to undertake the process of our assistance to the client in the most appropreate manner for the express purpose of meeting the client needs in respect of provision of the companys stated services in the accordance with and subject to prevailing law of netherlands.Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they are taken as interchangable and therefore as refering to same.',
              style: TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 4, 10, 74)),
            ),
          )
        ],
      ),
    );
  }
}
