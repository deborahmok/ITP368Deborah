import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define a block in the blockchain
class Block
{
  final int index;
  final String previousHash;
  final String data;
  final String hash;

  Block(this.index, this.previousHash, this.data)
      : hash = _generateHash(index, previousHash, data);

  static String _generateHash(int index, String previousHash, String data) {
    return (index.toString() + previousHash + data).hashCode.toString();
  }

  @override
  String toString() {
    return 'Block $index: $hash (Previous: $previousHash)';
  }
}

// A simple blockchain structure to store blocks
class Blockchain {
  final List<Block> _chain = [];

  Blockchain() {
    // Genesis block
    _chain.add(Block(0, '0', 'Genesis Block'));
  }

  void addBlock(String data) {
    final previousBlock = _chain.last;
    final newBlock = Block(
      previousBlock.index + 1,
      previousBlock.hash,
      data,
    );
    _chain.add(newBlock);
  }

  void displayChain() {
    for (var block in _chain) {
      print(block.toString());
    }
  }
}

void main() {
  final blockchain = Blockchain();

  // Simulate storing the code as data within blocks
  blockchain.addBlock('Flutter app code block 1');

  // Display the blockchain in the console
  blockchain.displayChain();

  // Run the Flutter app
  runApp(BlockProvider());
}

class BlockProvider extends StatelessWidget {
  const BlockProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}