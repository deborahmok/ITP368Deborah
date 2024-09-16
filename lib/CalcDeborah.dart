import 'package:flutter/material.dart';

void main() {
  runApp(ConverterApp());
}

class ConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      home: ConverterHome(),
    );
  }
}

class ConverterHome extends StatefulWidget {
  _ConverterHomeState createState() => _ConverterHomeState();
}

class _ConverterHomeState extends State<ConverterHome> {
  String input = '';
  String result = '';
  String selectedConversion = 'F to C';

  // Conversion logic
  void convert() {
    if (input.isEmpty || input == '-') return; // Avoid empty or negative-only input

    double value = double.tryParse(input) ?? 0;
    double convertedValue;

    switch (selectedConversion) {
      case 'F to C':
        convertedValue = (value - 32) * 5 / 9;
        break;
      case 'C to F':
        convertedValue = (value * 9 / 5) + 32;
        break;
      case 'Pounds to Kg':
        convertedValue = value * 0.453592;
        break;
      case 'Kg to Pounds':
        convertedValue = value / 0.453592;
        break;
      default:
        convertedValue = 0;
    }

    setState(() {
      result = convertedValue.toString();
    });
  }

  // Handle input from buttons
  void handleInput(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        input = '';
        result = '';
      }
      else if (buttonText == '<-') {
        input = input.isNotEmpty ? input.substring(0, input.length - 1) : '';
      }
      else if (buttonText == '=') {
        convert(); // Trigger the conversion when "=" is pressed
      }
      else if (buttonText == '-' && input.isEmpty) {
        input += buttonText; // Allow negative numbers only at the start
      }
      else if (buttonText == '.' && !input.contains('.')) {
        input += buttonText; // Allow only one decimal point
      }
      else if (double.tryParse(buttonText) != null) {
        input += buttonText;
      }
    });
  }

  void selectConversion(String conversion) {
    setState(() {
      selectedConversion = conversion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
      ),
      body: Column(
        children: [
          // Conversion buttons using FloatingActionButton
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //buttons
              buildConversionButton('F to C'),
              buildConversionButton('C to F'),
              buildConversionButton('Pounds to Kg'),
              buildConversionButton('Kg to Pounds'),
            ],
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                //allowing the text to show at the edge
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(fontSize: 40, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Text(
                    result,
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 4,
              padding: EdgeInsets.all(10),
              children: [
                //making all the numbers
                buildFABButton('7'),
                buildFABButton('8'),
                buildFABButton('9'),
                buildFABButton('<-'),
                buildFABButton('4'),
                buildFABButton('5'),
                buildFABButton('6'),
                buildFABButton('C'),
                buildFABButton('1'),
                buildFABButton('2'),
                buildFABButton('3'),
                buildFABButton('-'),
                buildFABButton('0'),
                buildFABButton('.'),
                buildFABButton('='), // This triggers the conversion
              ],
            ),
          ),
        ],
      ),
    );
  }

  //making the buttons:
  Widget buildConversionButton(String conversion) {
    return FloatingActionButton(
      onPressed: () => selectConversion(conversion),
      child: Text(
        conversion,
        style: TextStyle(fontSize: 10), // Text shrunk to fit
      ),
    );
  }

  Widget buildFABButton(String text) {
    return FloatingActionButton(
      onPressed: () => handleInput(text),
      child: Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}