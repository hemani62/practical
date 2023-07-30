import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayValue = '0';
  double? _firstOperand;
  String? _operator;

  void _onDigitPress(String digit) {
    setState(() {
      if (_displayValue == '0' ||
          _displayValue == 'Infinity' ||
          _displayValue == '-Infinity') {
        _displayValue = digit;
      } else {
        _displayValue += digit;
      }
    });
  }

  void _onOperatorPress(String operator) {
    setState(() {
      if (_firstOperand != null) {
        _onEqualsPress();
        _firstOperand = double.parse(_displayValue);
      } else {
        _firstOperand = double.parse(_displayValue);
      }
      _operator = operator;
      _displayValue = '0';
    });
  }

  void _onEqualsPress() {
    setState(() {
      double? secondOperand = double.tryParse(_displayValue);
      if (secondOperand == null) {
        _displayValue = 'Error';
        _firstOperand = null;
        _operator = null;
        return;
      }

      double? result;

      switch (_operator) {
        case '+':
          result = _firstOperand! + secondOperand;
          break;
        case '-':
          result = _firstOperand! - secondOperand;
          break;
        case '*':
          result = _firstOperand! * secondOperand;
          break;
        case '/':
          if (secondOperand == 0) {
            _displayValue = 'Error';
            _firstOperand = null;
            _operator = null;
            return;
          }
          result = _firstOperand! / secondOperand;
          break;
        default:
          result = 0;
      }

      _displayValue = result.toString();
      _firstOperand = null;
      _operator = null;
    });
  }

  void _onClearPress() {
    setState(() {
      _displayValue = '0';
      _firstOperand = null;
      _operator = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _displayValue,
                style: const TextStyle(fontSize: 36.0),
              ),
            ),
          ),
          const Divider(height: 1.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('0'),
              _buildButton('.'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
          ElevatedButton(
            onPressed: _onClearPress,
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () {
        if (text == '=') {
          _onEqualsPress();
        } else if (text == '+' || text == '-' || text == '*' || text == '/') {
          _onOperatorPress(text);
        } else {
          _onDigitPress(text);
        }
      },
      child: Text(text),
    );
  }
}
