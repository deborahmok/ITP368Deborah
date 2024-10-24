import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AnimalEvent {}

class SelectAnimalEvent extends AnimalEvent {
  final String animal;
  SelectAnimalEvent(this.animal);
}

abstract class AnimalState {}

class InitialAnimalState extends AnimalState {}

class AnimalSoundState extends AnimalState {
  final String sound;
  AnimalSoundState(this.sound);
}

class AnimalBloc extends Bloc<AnimalEvent, AnimalState> {
  final Map<String, String> animalSounds = {
    'dog': 'Bark!',
    'pig': 'Oink!',
    'snake': 'Hiss!',
    'bird': 'Chirp!',
    'cow': 'Moo!',
  };

  AnimalBloc() : super(InitialAnimalState()) {
    //debugging
    on<SelectAnimalEvent>((event, emit) {
      final sound = animalSounds[event.animal] ?? '';
      emit(AnimalSoundState(sound));
    });
  }
}

void main() {
  runApp(MyAnimal());
}

class MyAnimal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speak',
      home: BlocProvider(
        create: (context) => AnimalBloc(),
        child: AnimalSoundPage(),
      ),
    );
  }
}

class AnimalSoundPage extends StatelessWidget {
  final List<String> animals = ['dog', 'pig', 'snake', 'bird', 'cow'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Sounds'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ...animals.map((animal) {
            return ElevatedButton(
              onPressed: () {
                BlocProvider.of<AnimalBloc>(context)
                    .add(SelectAnimalEvent(animal));
              },
              child: Text(animal),
            );
          }).toList(),
          SizedBox(height: 20),
          BlocBuilder<AnimalBloc, AnimalState>(
            builder: (context, state) {
              if (state is AnimalSoundState) {
                return Text(
                  'Sound: ${state.sound}',
                  style: TextStyle(fontSize: 20),
                );
              }
              return Text(
                'Press a button!',
                style: TextStyle(fontSize: 20),
              );
            },
          ),
        ],
      ),
    );
  }
}
