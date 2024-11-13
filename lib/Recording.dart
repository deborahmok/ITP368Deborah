import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart'; // Import kIsWeb

Future<void> requestPermissions() async {
  if (!kIsWeb) {
    await [Permission.microphone, Permission.storage].request();
  }
}

void main() {
  runApp(SoundboardApp());
}

class SoundboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soundboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SoundboardScreen(),
    );
  }
}

class SoundboardScreen extends StatefulWidget {
  @override
  _SoundboardScreenState createState() => _SoundboardScreenState();
}

class _SoundboardScreenState extends State<SoundboardScreen> {
  List<AudioPlayer> players = List.generate(5, (_) => AudioPlayer());
  List<File?> recordedFiles = List.generate(5, (_) => null);
  List<bool> isRecording = List.generate(5, (_) => false);
  List<FlutterSoundRecorder> recorders =
  List.generate(5, (_) => FlutterSoundRecorder());

  @override
  void initState() {
    super.initState();
    requestPermissions();
    if (!kIsWeb) {
      initRecorders();
    }
  }

  Future<void> initRecorders() async {
    for (int i = 0; i < recorders.length; i++) {
      try {
        await recorders[i].openRecorder();
      } catch (e) {
        print("Error initializing recorder for channel $i: $e");
      }
    }
  }

  Future<void> _startRecording(int index) async {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recording is not supported on the web')),
      );
      return;
    }
    try {
      Directory tempDir = await getTemporaryDirectory();
      String path = "${tempDir.path}/recording_$index.aac";
      await recorders[index].startRecorder(
        toFile: path,
        codec: Codec.aacADTS,
      );
      setState(() {
        isRecording[index] = true;
      });
    } catch (e) {
      print("Error starting recording for channel $index: $e");
    }
  }

  Future<void> _stopRecording(int index) async {
    if (kIsWeb) {
      return;
    }
    try {
      String? path = await recorders[index].stopRecorder();
      setState(() {
        isRecording[index] = false;
        if (path != null) {
          recordedFiles[index] = File(path);
        }
      });
    } catch (e) {
      print("Error stopping recording for channel $index: $e");
    }
  }

  void _toggleRecording(int index) {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recording is not supported on the web')),
      );
      return;
    }
    if (isRecording[index]) {
      _stopRecording(index);
    } else {
      _startRecording(index);
    }
  }

  void _playback(int index) {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Playback is limited on the web')),
      );
      return;
    }
    if (recordedFiles[index] != null) {
      players[index].play(DeviceFileSource(recordedFiles[index]!.path));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
            Text("No recording available for Channel ${index + 1}")),
      );
    }
  }

  @override
  void dispose() {
    if (!kIsWeb) {
      for (var recorder in recorders) {
        recorder.closeRecorder();
      }
    }
    for (var player in players) {
      player.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soundboard App'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Sound Channel ${index + 1}'),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _toggleRecording(index),
                  child: Text(isRecording[index] ? 'Stop' : 'Start'),
                ),
                ElevatedButton(
                  onPressed: () => _playback(index),
                  child: Text('Play'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}