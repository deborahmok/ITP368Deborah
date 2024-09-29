import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(PancakeSortGame());
}

class PancakeSortGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pancake Sorting Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PancakeSortScreen(),
    );
  }
}

class PancakeSortScreen extends StatefulWidget {
  @override
  _PancakeSortScreenState createState() => _PancakeSortScreenState();
}

class _PancakeSortScreenState extends State<PancakeSortScreen> {
  int pancakeCount = 5; // Default number of pancakes
  List<int> pancakeStack = [];
  List<int> originalStack = [];
  int flips = 0;

  @override
  void initState() {
    super.initState();
    generateNewStack();
  }

  void generateNewStack() {
    pancakeStack = List.generate(pancakeCount, (index) => index + 1)..shuffle();
    originalStack = List.from(pancakeStack);
    flips = 0;
  }

  void resetStack() {
    setState(() {
      pancakeStack = List.from(originalStack);
      flips = 0;
    });
  }

  void flipStack(int index) {
    setState(() {
      pancakeStack = pancakeStack.sublist(0, index + 1).reversed.toList() + pancakeStack.sublist(index + 1);
      flips++;
    });
  }

  bool isSorted() {
    for (int i = 1; i < pancakeStack.length; i++) {
      if (pancakeStack[i - 1] > pancakeStack[i]) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pancake Sorting Game'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Flips: $flips',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: pancakeCount > 2
                    ? () {
                  setState(() {
                    pancakeCount--;
                    generateNewStack();
                  });
                }
                    : null,
              ),
              Text(
                '$pancakeCount Pancakes',
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: pancakeCount < 20
                    ? () {
                  setState(() {
                    pancakeCount++;
                    generateNewStack();
                  });
                }
                    : null,
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            children: pancakeStack.asMap().entries.map((entry) {
              int index = entry.key;
              int size = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),  // Adding consistent spacing between pancakes
                child: GestureDetector(
                  onTap: () => flipStack(index),
                  child: Container(
                    width: size * 20.0 + 100,
                    height: 30,
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        '$size',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          if (isSorted())
            Text(
              'You sorted the pancakes in $flips flips!',
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetStack,
            child: Text('Try Again with Same Stack'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                generateNewStack();
              });
            },
            child: Text('Play New Stack'),
          ),
        ],
      ),
    );
  }
}