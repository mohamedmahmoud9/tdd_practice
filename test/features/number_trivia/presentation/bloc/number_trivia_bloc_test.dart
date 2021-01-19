import 'package:clean_architecture_practice/core/error/failures.dart';
import 'package:clean_architecture_practice/core/usecases/usecases.dart';
import 'package:clean_architecture_practice/core/util/input_converter.dart';
import 'package:clean_architecture_practice/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_practice/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_practice/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture_practice/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });
  test('inialState should be empty', () {
    expect(bloc.state, equals(Empty()));
  });
  group('GetTriviaForRandomNumber', () {
    // NumberTrivia instance is needed too, of course
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    test('should get data from the random use case', () async {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      //act
      bloc.add(GetTriviaForRandomNumber());
      await untilCalled(mockGetRandomNumberTrivia(any));
      //assert
      verify(mockGetRandomNumberTrivia(NoParams()));
    });
    test('should emits [Loading ,Loaded] when data is gotten successfully',
        () async {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      //assert later
      final expected = [Loading(), Loaded(trivia: tNumberTrivia)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForRandomNumber());
    });
    test('should emits [Loading ,Error] when data is fails', () async {
      //arrange

      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [Loading(), Error(message: SERVER_FAILURE_MESSAGE)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForRandomNumber());
    });
    test(
        'should emits [Loading ,Error] with proper message for the error getting data fails',
        () async {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [Loading(), Error(message: CACHE_FAILURE_MESSAGE)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForRandomNumber());
    });
  });
  group('GetTriviaForConcreteNumber', () {
    // The event takes in a String
    final tNumberString = '1';
    // This is the successful output of the InputConverter
    final tNumberParsed = int.parse(tNumberString);
    // NumberTrivia instance is needed too, of course
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');
    setUpMockInputConverterSuccess() {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Right(tNumberParsed));
    }

    test(
      'should call the InputConverter to validate and convert the string to an unsigned integer',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        // act
        bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        // assert
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );
    test('should emit [Error] when the input is invalid', () async {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      final expected = [
        Error(message: INVALID_INPUT_FAILURE_MESSAGE),
      ];
      expectLater(bloc, emitsInOrder(expected));
      bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
    });
    test('should get data from the concrete use case', () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      //act
      bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
      await untilCalled(mockGetConcreteNumberTrivia(any));
      //assert
      verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
    });
    test('should emits [Loading ,Loaded] when data is gotten successfully',
        () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      //assert later
      final expected = [Loading(), Loaded(trivia: tNumberTrivia)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
    });
    test('should emits [Loading ,Error] when data is fails', () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [Loading(), Error(message: SERVER_FAILURE_MESSAGE)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
    });
    test(
        'should emits [Loading ,Error] with proper message for the error getting data fails',
        () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [Loading(), Error(message: CACHE_FAILURE_MESSAGE)];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
    });
  });
}
