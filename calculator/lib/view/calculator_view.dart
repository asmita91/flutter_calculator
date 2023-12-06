import 'dart:math' as math;

import 'package:flutter/material.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String _output = '0';
  String _currentInput = '';
  double _num1 = 0;
  String _operator = '';
  String _operatorText = '';
  String _errorMessage = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _clear();
        _operatorText = '';
        _errorMessage = '';
      } else if ('+-*/%'.contains(buttonText)) {
        _performOperation(buttonText);
        _operatorText = buttonText;
      } else if (buttonText == '=') {
        _calculateResult();
        _operatorText = '';
      } else if (buttonText == '<-') {
        _backspace();
      } else if (buttonText == '√') {
        _performOperation(buttonText);
      } else {
        _updateInput(buttonText);
        _operatorText = '';
        _errorMessage = ''; // Clear error message when new input is entered
      }
    });
  }

  void _clear() {
    _output = '0';
    _currentInput = '';
    _num1 = 0;
    _operator = '';
    _errorMessage = '';
  }

  void _performOperation(String operator) {
    if (_currentInput.isNotEmpty) {
      try {
        if (operator == '√') {
          // Square root operation
          double num = double.parse(_currentInput);
          _output =
              (num >= 0) ? math.sqrt(num).toString() : 'Error: Invalid Input';
          _currentInput = _output;
        } else {
          _num1 = double.parse(_currentInput);
          _currentInput = '';
          _operator = operator;
        }
        _errorMessage = ''; // Clear error message on successful operation
      } catch (e) {
        _output = 'Error: Invalid Input';
        _currentInput = _output;
        _errorMessage = _output; // Set error message for invalid input
      }
    }
  }

  void _updateInput(String value) {
    if (_currentInput.length < 10) {
      _currentInput += value;
      _output = _currentInput;
    }
  }

  void _backspace() {
    setState(() {
      if (_currentInput.isNotEmpty) {
        _currentInput = _currentInput.substring(0, _currentInput.length - 1);
        _output = _currentInput.isEmpty ? '0' : _currentInput;
      }
    });
  }

  void _calculateResult() {
    if (_currentInput.isNotEmpty && _operator.isNotEmpty) {
      try {
        double num2 = double.parse(_currentInput);
        switch (_operator) {
          case '+':
            _output = (_num1 + num2).toString();
            break;
          case '-':
            _output = (_num1 - num2).toString();
            break;
          case '*':
            _output = (_num1 * num2).toString();
            break;
          case '/':
            _output = (num2 != 0)
                ? (_num1 / num2).toString()
                : 'Error: Division by Zero';
            break;
          case '%':
            _output = (num2 != 0)
                ? (_num1 % num2).toString()
                : 'Error: Division by Zero';
            break;
        }
        _currentInput = '';
        _operator = '';
        _num1 = 0;
        _errorMessage = ''; // Clear error message on successful calculation
      } catch (e) {
        _output = 'Error: Invalid Input';
        _currentInput = _output;
        _errorMessage =
            _output; // Set error message for invalid input during calculation
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> buttonRows = [
      ['C', '*', '/', '<-'],
      ['1', '2', '3', '+'],
      ['4', '5', '6', '-'],
      ['7', '8', '9', '%'],
      ['0', '.', '=', '√']
    ];
    List<String> flattenedButtons = buttonRows.expand((row) => row).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Text(
              _errorMessage.isNotEmpty ? _errorMessage : _output,
              style: TextStyle(
                fontSize: 40,
              color: _errorMessage.isNotEmpty ? Colors.red : Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(8),
              crossAxisCount: 4,
              crossAxisSpacing: 9.0,
              mainAxisSpacing: 42.0,
              children: [
                for (int index = 0; index < flattenedButtons.length; index++)
                  Expanded(
                    child: FractionallySizedBox(
                      heightFactor: 1.35,
                      child: ElevatedButton(
                        onPressed: () =>
                            _onButtonPressed(flattenedButtons[index]),
                        child: Text(
                          flattenedButtons[index],
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
