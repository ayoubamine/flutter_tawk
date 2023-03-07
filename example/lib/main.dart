import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Tawk'),
          backgroundColor: const Color(0XFFF7931E),
          elevation: 0,
        ),
        body: Tawk(
          directChatLink: 'https://tawk.to/chat/627028aeb0d10b6f3e70525b/1g231tqaj',
          visitor: TawkVisitor(
            name: 'Ayoub AMINE',
            email: 'ayoubamine2a@gmail.com',
          ),
          onLoad: () {
            if (kDebugMode) {
              print('Hello Tawk!');
            }
          },
          onLinkTap: (String url) {
            if (kDebugMode) {
              print(url);
            }
          },
          placeholder: const Center(
            child: Text('Loading...'),
          ),
        ),
      ),
    );
  }
}
