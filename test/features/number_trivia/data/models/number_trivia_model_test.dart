import 'dart:convert';

import 'package:clean_architecture_practice/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture_practice/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  final tNumberTriviaModel = NumberTriviaModel(text: "test", number: 1);
  test("Should be a subtype of NumberTrivia entity", () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });
  group("fromJson", () {
    test("should return a valid model when the JSON number is an integer", () {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });
    test("should return a valid model when the JSON number is double", () {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });
  });
  group('toJson', () {
    test('should return a JSON map containing the proper data', () {      
      final result = tNumberTriviaModel.toJson();
      Map<String, dynamic> expectedMap = {"number": 1, "text": "test"};
      expect(result, expectedMap);
    });
  });
}
