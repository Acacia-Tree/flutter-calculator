import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var buttonList = [
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    '*',
    '1',
    '2',
    '3',
    '-',
    '0',
    'x',
    '=',
    '+'
  ];
  String output = '0';
  double result = 0;
  var hasEqual = false;
  double getResult() {
    String num1 = '';
    String num2 = '';
    String symbol = '';

    output.split('').forEach((ch) {
      if (_isNumeric(ch) && symbol == '') {
        num1 += ch;
      } else if (_isNumeric(ch) && symbol != '') {
        num2 += ch;
      } else if (!_isNumeric(ch)) {
        symbol = ch;
      }
    });

    switch (symbol) {
      case '/':
        result = double.parse(num1) / double.parse(num2);
        break;
      case '*':
        result = double.parse(num1) * double.parse(num2);
        break;
      case '-':
        result = double.parse(num1) - double.parse(num2);
        break;
      case '+':
        result = double.parse(num1) + double.parse(num2);
        break;
    }
    return result;
  }

  bool _isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text("Calculator")),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.all(50),
                  height: MediaQuery.of(context).size.height / 3,
                  child: hasEqual
                      ? Text(
                          '$result',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20),
                        )
                      : Text('$output',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 3,
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: [
                      ...buttonList
                          .map(
                            (e) => TextButton(
                              // style: OutlinedButton.styleFrom(
                              //     elevation: 0,
                              //     side:
                              //         BorderSide(width: 2, color: Colors.grey)),
                              child: Text(e, textAlign: TextAlign.center),
                              onPressed: () {
                                switch (e) {
                                  case 'x':
                                    setState(() {
                                      output = '0';
                                      result = 0;
                                      hasEqual = false;
                                    });
                                    break;
                                  case '=':
                                    setState(() {
                                      result = getResult();
                                      hasEqual = true;
                                    });
                                    output = result.toString();
                                    break;
                                  default: //if we have a number or a operator
                                    bool isNumeric = _isNumeric(e);
                                    setState(() {
                                      if (output == '0' && isNumeric) {
                                        output = e;
                                      } else {
                                        output += e;
                                      }
                                      if (!isNumeric) {
                                        hasEqual = false;
                                      }
                                    });
                                }
                              },
                            ),
                          )
                          .toList()
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
