import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

TextStyle ts = TextStyle(fontSize: 30);

class CounterState {
  int count;
  CounterState(this.count);
}

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(0));

  void inc() {
    emit(CounterState(state.count + 1));
  }
}

void main() {
  runApp(RoutesDemo());
}

class RoutesDemo extends StatelessWidget {
  RoutesDemo({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "Routes Demo";
    return MaterialApp(
      title: title,
      // BlocProvider wrapping the initial widget.
      home: BlocProvider(
        create: (_) => CounterCubit(),  // Creating the CounterCubit instance
        child: Route1(title: title),    // Passing Route1 as the initial screen
      ),
    );
  }
}

class Route1 extends StatelessWidget {
  final String title;
  Route1({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    CounterCubit cc = BlocProvider.of<CounterCubit>(context);
    return Scaffold(
      appBar: AppBar(title: Text(title, style: ts)),
      body: Column(
        children: [
          Text("page 1", style: ts),
          Text("${cc.state.count}", style: ts),
          ElevatedButton(
            onPressed: () {
              cc.inc();
            },
            child: Text("add 1", style: ts),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigating to Route2 while passing the existing CounterCubit
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: cc,                  // Passing the existing CounterCubit
                    child: Route2(title: title), // Navigate to Route2
                  ),
                ),
              );
            },
            child: Text("go to page 2", style: ts),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigating to Route3 while passing the existing CounterCubit
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: cc,                  // Passing the existing CounterCubit
                    child: Route3(title: title), // Navigate to Route3
                  ),
                ),
              );
            },
            child: Text("go to page 3", style: ts),
          ),
        ],
      ),
    );
  }
}

class Route2 extends StatelessWidget {
  final String title;
  Route2({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    CounterCubit cc = BlocProvider.of<CounterCubit>(context);
    return Scaffold(
      appBar: AppBar(title: Text(title, style: ts)),
      body: Column(
        children: [
          Text("page 2", style: ts),
          Text("${cc.state.count}", style: ts),
          ElevatedButton(
            onPressed: () {
              cc.inc();
            },
            child: Text("add 1", style: ts),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("go back", style: ts),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigating to Route3 while passing the existing CounterCubit
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: cc,                  // Passing the existing CounterCubit
                    child: Route3(title: title), // Navigate to Route3
                  ),
                ),
              );
            },
            child: Text("go to page 3", style: ts),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigating back to Route1 while clearing the route stack
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: cc,                  // Passing the existing CounterCubit
                    child: Route1(title: title), // Navigate back to Route1
                  ),
                ),
                    (Route<dynamic> route) => false, // Remove all other routes from the stack
              );
            },
            child: Text("go to page 1", style: ts),
          ),
        ],
      ),
    );
  }
}

class Route3 extends StatelessWidget {
  final String title;
  Route3({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    CounterCubit cc = BlocProvider.of<CounterCubit>(context);
    return Scaffold(
      appBar: AppBar(title: Text(title, style: ts)),
      body: Column(
        children: [
          Text("page 3", style: ts),
          Text("${cc.state.count}", style: ts),
          ElevatedButton(
            onPressed: () {
              cc.inc();
            },
            child: Text("add 1", style: ts),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("go back", style: ts),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigating to Route2 while passing the existing CounterCubit
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: cc,                  // Passing the existing CounterCubit
                    child: Route2(title: title), // Navigate to Route2
                  ),
                ),
              );
            },
            child: Text("go to page 2", style: ts),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigating back to Route1 while clearing the route stack
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: cc,                  // Passing the existing CounterCubit
                    child: Route1(title: title), // Navigate back to Route1
                  ),
                ),
                    (Route<dynamic> route) => false, // Remove all other routes from the stack
              );
            },
            child: Text("go to page 1", style: ts),
          ),
        ],
      ),
    );
  }
}