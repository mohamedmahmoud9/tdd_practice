import 'package:flutter/material.dart';

import '../../domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({
    @required String text,
    @required int number,
  }) : super(
          text: text,
          number: number,
        );
  factory NumberTriviaModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return NumberTriviaModel(
      number: (json['number'] as num).toInt(),
      text: json['text'] ,
    );
  }
  Map<String,dynamic> toJson(){
    return {
      "number":number,
      "text":text
    };
  }
}
