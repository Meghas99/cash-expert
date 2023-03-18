import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class PageHelp extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  // const PageHelp({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController body = TextEditingController();

  PageHelp({super.key});

  sendEmail(String subject, String body, String recipientmail) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: ['meghasreemohan99@gmail.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Help?',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 34, 73, 106)),
        ),
        backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
      ),
      backgroundColor: const Color.fromRGBO(183, 244, 235, 0.902),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: Form(
          key: _key,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: subject,
                decoration: const InputDecoration(
                  hintText: 'Enter Subject',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: body,
                decoration: const InputDecoration(
                  hintText: 'Enter problem',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    _key.currentState!.save();

                    // print('${email.text}');
                    sendEmail(subject.text, body.text, email.text);
                  },
                  child: const Text('send email')),
            ],
          ),
        )),
      ),
    );
  }
}
