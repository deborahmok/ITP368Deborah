import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PanelState {
  final List<Light> panel;

  PanelState(int n) : panel = List.generate(n, (_) => Light()) {
    for (int i = 1; i < n - 1; i++) {
      panel[i].addNeighbor(panel[i - 1]);
      panel[i].addNeighbor(panel[i + 1]);
    }
    if (n > 1) {
      panel[0].addNeighbor(panel[1]);
      panel[n - 1].addNeighbor(panel[n - 2]);
    }
  }
}

class PanelCubit extends Cubit<PanelState> {
  PanelCubit(int n) : super(PanelState(n));

  void update(int n) => emit(PanelState(n));
}

void main() {
  runApp(LightsOut());
}

class LightsOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LightsOut',
      home: LightsOutHome(),
    );
  }
}

class LightsOutHome extends StatelessWidget {
  final TextEditingController _tec = TextEditingController(text: '9');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lights Out')),
      body: BlocProvider(
        create: (context) => PanelCubit(9),
        child: Column(
          children: [
            BlocBuilder<PanelCubit, PanelState>(
              builder: (context, panelState) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: panelState.panel.map((light) {
                    return light.build(context);
                  }).toList(),
                );
              },
            ),
            TextField(
              controller: _tec,
              keyboardType: TextInputType.number,
            ),
            FloatingActionButton(
              onPressed: () {
                int n = int.parse(_tec.text);
                BlocProvider.of<PanelCubit>(context).update(n);
              },
              child: Text("Update Lights"),
            ),
          ],
        ),
      ),
    );
  }
}

class LightState {
  bool isOn;

  LightState(this.isOn);
  LightState.random() : isOn = Random().nextBool();
}

class LightCubit extends Cubit<LightState> {
  LightCubit() : super(LightState.random());

  void toggle() => emit(LightState(!state.isOn));
}

class Light {
  final List<Light> neighbors = [];
  final LightCubit _cubit = LightCubit();

  void addNeighbor(Light neighbor) {
    neighbors.add(neighbor);
  }

  Widget build(BuildContext context) {
    return BlocProvider<LightCubit>.value(
      value: _cubit,
      child: BlocBuilder<LightCubit, LightState>(
        builder: (context, lightState) {
          return GestureDetector(
            onTap: () {
              _cubit.toggle();
              for (var neighbor in neighbors) {
                neighbor._cubit.toggle();
              }
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                color: lightState.isOn ? Colors.yellow : Colors.brown,
              ),
            ),
          );
        },
      ),
    );
  }
}