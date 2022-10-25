import 'package:flutter/material.dart';
import 'package:proj1/buttons.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final myTextStyle = TextStyle(fontSize: 30, color: Colors.deepPurple[900]);

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'Ans',
    '=',
  ];

  @override
  Widget build(BuildContext context){ return
      Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userQuestion,
                        style:
                        const TextStyle(fontSize: 100, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userAnswer,
                        style: const TextStyle(fontSize:40,color:Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Center(
                  child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisExtent: 100,
                        crossAxisSpacing: 0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                userQuestion = '';
                                userAnswer='';
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.grey,
                            textColor: Colors.white,
                          );
                        } else if (index ==1) {
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                userQuestion = userQuestion.substring(
                                    0, userQuestion.length - 1);
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.grey,
                            textColor: Colors.white,
                          );
                        } else if (index == buttons.length - 1) {
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                equalPressed();
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.purple,
                            textColor: Colors.white,
                          );
                        } else {
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                userQuestion += buttons[index];
                              });
                            },
                            buttonText: buttons[index],
                            color: isOperator(buttons[index])
                                ? Colors.orange
                                : Colors.deepPurple[50],
                            textColor: isOperator(buttons[index])
                                ? Colors.white
                                : Colors.deepPurple,
                          );
                        }
                      }),
                ),
              ),
            ),
          ],
        ),
      );
}
  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
  void equalPressed(){
    String finalQuestion=userQuestion;
    finalQuestion=finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer=eval.toString();
  }
}