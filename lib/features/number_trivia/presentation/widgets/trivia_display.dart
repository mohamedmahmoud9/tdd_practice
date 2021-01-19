import 'package:clean_architecture_practice/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter/material.dart';

class TriviaDisplay extends StatelessWidget {
  final NumberTrivia numberTrivia;
  const TriviaDisplay({Key key, this.numberTrivia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Text(
            numberTrivia.number.toString(),
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                  child: Text(numberTrivia.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}
