import 'package:clean_architecture_practice/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key key,
  }) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  String inputStr;
    final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TextField
        TextField(
          controller: controller,
          
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: RaisedButton(
                child: Text('Search'),
                textColor: Colors.white,
                onPressed: dispatchConcrete,
                color: Theme.of(context).accentColor,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: RaisedButton(
                child: Text('Random Trivia'),
                
                onPressed: dispatchRandom,
               
              ),
            ),
          ],
        )
      ],
    );
  }
   void dispatchConcrete() {
  
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(numberString: controller.text));
    controller.clear();
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}
