import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(GroceryApp());
}

class GroceryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery List',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: GroceryListScreen(),
    );
  }
}

class GroceryListScreen extends StatefulWidget {
  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  TextEditingController _controller = TextEditingController();
  String _fileContents = '';
  List<String> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _readFile().then((contents) {
      setState(() {
        _fileContents = contents;
        _groceryItems = _fileContents.split('\n').where((item) => item.isNotEmpty).toList();
      });
    });
  }

  // Get the file path
  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/grocery_list.txt';
  }

  // Save the item to the file
  Future<void> _saveToFile(String item) async {
    final filePath = await _getFilePath();
    final file = File(filePath);
    await file.writeAsString('$item\n', mode: FileMode.append);
  }

  // Read the file
  Future<String> _readFile() async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);
      return await file.readAsString();
    } catch (e) {
      return 'No items found';
    }
  }

  // Add a grocery item
  void _addGroceryItem() {
    String item = _controller.text;
    if (item.isNotEmpty) {
      setState(() {
        _groceryItems.add(item);
      });
      _saveToFile(item);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter grocery item',
              ),
              onSubmitted: (value) => _addGroceryItem(),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _groceryItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_groceryItems[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGroceryItem,
        child: Icon(Icons.add),
      ),
    );
  }
}