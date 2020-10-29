import 'package:flutter/material.dart';

import 'package:flutter_tawk/flutter_tawk.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Tawk'),
          backgroundColor: Color(0XFFF7931E),
          elevation: 0,
        ),
        body: Tawk(
          directChatLink: 'YOUR_DIRECT_CHAT_LINK',
          visitor: TawkVisitor(
            name: 'Ayoub AMINE',
            email: 'ayoubamine2a@gmail.com',
          ),
          onLoad: () {
            print('Hello Tawk!');
          },
          onLinkTap: (String url) {
            print(url);
          },
          placeholder: Center(
            child: Text('Loading...'),
          ),
        ),
      ),
    );
  }
}
