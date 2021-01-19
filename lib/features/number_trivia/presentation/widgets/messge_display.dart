import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final String message;
  const MessageDisplay({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Center(
            child: Text(
          message,
          style: TextStyle(fontSize: 25),
        )),
      ),
    );
  }
}
