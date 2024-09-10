import "package:flutter/material.dart";

void main2()
{
  runApp(RobotLatin());
}

class RobotLatin extends StatelessWidget
{
  RobotLatin({super.key});

  @override
  Widget build(BuildContext context)
  { return MaterialApp
    ( title: "whatEVER",
    home: RobotHome(),
  );
  }
}

class RobotHome extends StatefulWidget
{
  @override
  State<RobotHome> createState() => RobotHomeState();
}

class RobotHomeState extends State<RobotHome>
{
  //state members
  int currow = 2;
  int currcol = 2;

  @override
  Widget build( BuildContext context )
  {
    Column grid2 = Column(children:[]);
    for ( int x = 0; x<5; x++ )
    {
      Row arow = Row(children:[]);
      for( int y=0; y<5; y++ )
      {
        if (x == currow && y == currcol) {
          arow.children.add(TextWithBorder("R"));
        }
        else{
          arow.children.add(TextWithBorder(""));
        }
      }
      grid2.children.add(arow); //you're adding the rows
    }
    // Scaffold is the screen contents for PigHomeState
    return Scaffold(
      appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.start, // Aligns the text to the start (left)
              children:
              [ Text("Robot"), ],
          ),
        ),
      body: Column
        ( children:
      [

        //5x5 grid
        grid2,

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (currow > 0) {
                    currow = currow - 1;
                  }
                });
              },
              child: Text("Up"),
            ),
            SizedBox(width: 10), // Adds some spacing between buttons
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (currow < 4) {
                    currow = currow + 1;
                  }
                });
              },
              child: Text("Down"),
            ),
            SizedBox(width: 10),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (currcol > 0) {
                    currcol = currcol - 1;
                  }
                });
              },
              child: Text("Left"),
            ),
            SizedBox(width: 10),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (currcol < 4) {
                    currcol = currcol + 1;
                  }
                });
              },
              child: Text("Right"),
            ),
          ],
        ),
      ],
      ),
    );
  }
}

class TextWithBorder extends StatelessWidget
{
  final String s; // this is what is in the box

  const TextWithBorder(this.s, {super.key});

  @override
  Widget build( BuildContext context )
  {
    return Container
      ( height: 50,
      width: 50,
      decoration: BoxDecoration
        ( border: Border.all
        (width:2,color: const Color(0xff0000ff)),
      ),

      child: Text(s),
    );
  }
}
