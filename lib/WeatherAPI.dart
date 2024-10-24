import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZIP Code Weather',
      home: ZipCodeWeather(),
    );
  }
}

class ZipCodeWeather extends StatefulWidget {
  @override
  _ZipCodeWeatherState createState() => _ZipCodeWeatherState();
}

class _ZipCodeWeatherState extends State<ZipCodeWeather> {
  final _zipController = TextEditingController();
  String _temperature = '';

  @override
  void dispose() {
    _zipController.dispose();
    super.dispose();
  }

  Future<void> _getWeather() async {
    final zipCode = _zipController.text;
    final apiKey = '566d3711eb044087b92221429242410'; // Replace with your actual API key
    final apiUrl =
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$zipCode';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final tempF = data['current']['temp_f'];
        final location = data['location']['name'];
        setState(() {
          _temperature = 'Current Temperature in $location: $tempF°F';
        });
      } else {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['error']['message'];
        setState(() {
          _temperature = 'Error: $errorMessage';
        });
      }
    } catch (e) {
      setState(() {
        _temperature = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ZIP Code Weather'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _zipController,
                decoration: InputDecoration(
                  labelText: 'Enter ZIP Code',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getWeather,
                child: Text('Get Temperature'),
              ),
              SizedBox(height: 20),
              Text(
                _temperature,
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ));
  }
}