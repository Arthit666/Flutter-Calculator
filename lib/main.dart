// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors, avoid_print, iterable_contains_unrelated_type

import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = '0';

  String _out = '0';
  double num1 = 0.0;
  double num2 = 0.0;
  String operate = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 77, 76, 76),
          title: const Text('Calculator'),
        ),
        body: Container(
          color: Color.fromARGB(255, 77, 76, 76),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20)),
                  color: Colors.grey,
                ),
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 50.0),
                child: Text(
                  output,
                  style: TextStyle(fontSize: 60, color: Colors.white),
                ),
              ),
              Expanded(child: Divider()),
              Column(
                children: [
                  Row(
                    children: [
                      calButtton('.'),
                      calButtton('C'),
                      calButtton('<-'),
                      calButtton('*')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      calButtton('7'),
                      calButtton('8'),
                      calButtton('9'),
                      calButtton('/')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      calButtton('4'),
                      calButtton('5'),
                      calButtton('6'),
                      calButtton('+')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      calButtton('1'),
                      calButtton('2'),
                      calButtton('3'),
                      calButtton('-')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      calButtton('0'),
                      calButtton('='),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget calButtton(String btnval) {
    return Expanded(
        child: Container(
      height: 75,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 32, 29, 29),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 198, 230, 246),
            spreadRadius: 1.0,
            blurRadius: 1.0,
          )
        ],
      ),
      child: TextButton(
        onPressed: () {
          pressButton(btnval);
        },
        child: Text(
          btnval,
          style: TextStyle(fontSize: 22.0, color: Colors.white),
        ),
      ),
    ));
  }

  pressButton(String btnval) {
    // print(btnval);
    if (btnval == 'C') {
      output = '0';
      _out = '0';
      num1 = 0.0;
      num2 = 0.0;
      operate = '';
    } else if (['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
        .contains(btnval)) {
      if (output == '0') {
        output = '';
      }
      _out = output + btnval;
    } else if (btnval == '.') {
      if (output.contains('.')) {
        return;
      } else {
        _out = output + btnval;
      }
    } else if (btnval == '<-' && output != '0') {
      List<String> list = output.split("");
      if (list.length == 1) {
        _out = '0';
      } else {
        list.removeLast();
        _out = list.join();
      }
    } else if (['+', '-', '*', '/'].contains(btnval)) {
      num1 = double.parse(output);
      operate = btnval;
      _out = '0';
      // print(num1);
    } else if (btnval == '=' && num1 != 0) {
      num2 = double.parse(output);
      // print(num1);
      // print(num2);
      if (operate == '+') {
        _out = (num1 + num2).toStringAsFixed(2);
      } else if (operate == '-') {
        _out = (num1 - num2).toStringAsFixed(2);
      } else if (operate == '*') {
        _out = (num1 * num2).toStringAsFixed(2);
      } else if (operate == '/') {
        _out = (num1 / num2).toStringAsFixed(2);
      }
      print(_out[_out.length - 1]);
      print(_out[_out.length - 2]);
      if (_out[_out.length - 1] == '0' && _out[_out.length - 2] == '0') {
        // print(_out);
        // print(_out.indexOf('.00'));
        _out = _out.substring(0, _out.indexOf('.00'));
      }
      num1 = 0;
      num2 = 0;
    }

    setState(() {
      output = _out;
    });
  }
}
