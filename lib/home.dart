import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:core';

import 'package:flutter_application_1/rounding.dart';

class MainPage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MainPage> {
  final TextEditingController valueController = TextEditingController();
  final TextEditingController inaccuracyController = TextEditingController();

  String textOutput = '';
  String _errorText = '';

  void roundUpValue() {
    double value = double.parse(valueController.text);
    double inaccuracy = double.parse(inaccuracyController.text);

    var rounding = Rounding();

    setState(() {
      textOutput = rounding.getFinalResult(value, inaccuracy);
      valueController.clear();
      inaccuracyController.clear();
    });
  }

  void checkTextInput() {
    try {
      double value = double.parse(valueController.text);
      double inaccuracy = double.parse(inaccuracyController.text);

      if (valueController.text.endsWith('.') ||
          valueController.text.endsWith(',') ||
          inaccuracyController.text.endsWith('.') ||
          inaccuracyController.text.endsWith(',')) {
        alertDialogBuilder(context);
      } else {
        roundUpValue();
      }
    } catch (e) {
      alertDialogBuilder(context);
      setState(() {
        valueController.clear();
        inaccuracyController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(0.0),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.zero,
                color: Colors.lightGreen,
                height: 70,
                child: Center(
                  child: Text(
                    'ПолиОкругление',
                  ),
                )),
            SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    textOutput,
                    style: TextStyle(fontSize: 35),
                  ),
                )),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: valueController,
                onTap: () {
                  setState(() {
                    textOutput = '';
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Введите среднее',
                  border: OutlineInputBorder(),

                  ///hintText: 'Введите число...',
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: inaccuracyController,
                  onTap: () {
                    setState(() {
                      textOutput = '';
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Введите погрешность',
                    errorText: _errorText;
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              width: 250,
              child: ElevatedButton(
                onPressed: () => {checkTextInput()},
                child: Text(
                  'Округлить',
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightGreen),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> alertDialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ошибка ввода'),
            content: Text('Повторите ввод'),
          );
        });
  }

  void clear(){
    setState(() {
      valueController.clear();
      inaccuracyController.clear();
    });
  }
}
