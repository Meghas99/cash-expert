import 'package:flutter/material.dart';

class ScreenPrivacyPolicy extends StatelessWidget {
  const ScreenPrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 34, 73, 106)),
        ),
        backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
      ),
      backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(
              'At Cash Expert we take the privacy of our users seriously. We collect certain information from our users in order to provide them with the best possible experience. This information includes but is not limited to: name, email address, phone number, and payment information. \nWe use this information to provide our services and to improve our products. We do not share this information with any third parties. All data is stored securely and is only accessible to authorized personnel. \nIf you have any questions or concerns about your data,\nplease contact us at \nmeghasreemohan99@gmail.com ',
              style: TextStyle(
                  fontSize: 21, color: Color.fromARGB(255, 7, 11, 49)),
            ),
          )
        ],
      ),
    );
  }
}
