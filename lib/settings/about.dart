import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'About',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 34, 73, 106)),
        ),
        backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
      ),
      backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 42, 206, 197)),
          width: 300,
          height: 300,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Cash Expert",
                style: TextStyle(
                    color: Color.fromARGB(255, 45, 11, 125),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              const Center(
                child: Text(
                  'This is an app where you can add your daily transactions according to the category which it belongs to',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                    'Developed by',
                    style: TextStyle(
                        color: Color.fromARGB(255, 126, 59, 26),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 125,
                  ),
                  Text(
                    'Meghasree k',
                    style: TextStyle(
                        color: Colors.indigo[900], fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'contact me',
                style: TextStyle(
                    color: Colors.indigo, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.instagram,
                          color: Color.fromARGB(255, 203, 3, 107), size: 16.0)),
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.whatsapp,
                          color: Color.fromARGB(255, 12, 128, 20), size: 16.0)),
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.linkedin,
                          color: Color.fromARGB(255, 19, 49, 219), size: 16.0)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
