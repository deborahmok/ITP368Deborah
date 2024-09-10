// Barrett Koster
// Your Name Here (replace mine, this is just demos
// of stuff anyone can use).

import "package:flutter/material.dart";

//hello hello

void main23() // 23
{
  runApp(Yahtzee());
}

class Yahtzee extends StatelessWidget
{
  Yahtzee({super.key});

  @override
  Widget build( BuildContext context )
  { return MaterialApp
    ( title: "yahtzee",
      home: YahtzeeHome(),
    );
  }
}

class YahtzeeHome extends StatefulWidget
{
  @override
  State<YahtzeeHome> createState() => YahtzeeHomeState();
}

class YahtzeeHomeState extends State<YahtzeeHome>
{
  @override
  Widget build( BuildContext context )
  { return Scaffold
    ( appBar: AppBar(title: const Text("Yahtzee")),
      body: Column
      ( children:
        [
          // const Text //could change
          // ( "font styles",
          //   style: TextStyle
          //   ( fontSize: 35,
          //     color: Colors.orange,
          //   )
          // ),
          //
          // Spacer(flex:1),

          // const Text //could change
          // ( "line 2",
          //   style: TextStyle
          //   ( fontWeight: FontWeight.bold,
          //     fontSize: 30,
          //   ),
          // ),
          //
          // Spacer(flex:1),

          // FloatingActionButton(
          //   onPressed: () {
          //     setState(() {
          //       if (currow > 0) {
          //         currow = currow - 1;
          //       }
          //     });
          //   },
          //   child: Text("Roll"),
          // ),

          Container
            ( decoration: BoxDecoration
            ( color: Colors.yellow,
              border: Border.all //all four borders
                ( width:3,
              )
          ),
            child: const Text //could change
              ( "Roll",style:TextStyle
              ( fontSize: 40)
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container //block 1
                ( decoration: BoxDecoration
                ( border: Border.all( width:1, ) ),
                height: 100,
                width: 100,
                child: Stack
                  ( children:
                [ Positioned //needs to be in a stack of Container
                  ( left: 45, top: 45, //fixed position up to a 100
                    child: Container
                      ( height: 10, width: 10,
                      decoration: BoxDecoration
                        ( color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    )
                ),
                ],
                ),
              ),

              Container //block 2
                ( decoration: BoxDecoration
                ( border: Border.all( width:1, ) ),
                height: 100,
                width: 100,
                child: Stack
                  ( children:
                [ Positioned //needs to be in a stack of Container
                  ( left: 10, top: 80, //fixed position up to a 100
                    child: Container
                      ( height: 10, width: 10,
                      decoration: BoxDecoration
                        ( color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    )
                ),
                  Positioned //needs to be in a stack of Container
                    ( left: 80, top: 10, //fixed position up to a 100
                      child: Container
                        ( height: 10, width: 10,
                        decoration: BoxDecoration
                          ( color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                  ),
                ],
                ),
              ),

              Container //block 3
                ( decoration: BoxDecoration
                ( border: Border.all( width:1, ) ),
                height: 100,
                width: 100,
                child: Stack
                  ( children:
                [ Positioned //needs to be in a stack of Container
                  ( left: 10, top: 80, //fixed position up to a 100
                    child: Container
                      ( height: 10, width: 10,
                      decoration: BoxDecoration
                        ( color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    )
                ),
                  Positioned //needs to be in a stack of Container
                    ( left: 80, top: 10, //fixed position up to a 100
                      child: Container
                        ( height: 10, width: 10,
                        decoration: BoxDecoration
                          ( color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                  ),
                  Positioned //needs to be in a stack of Container
                    ( left: 45, top: 45, //fixed position up to a 100
                      child: Container
                        ( height: 10, width: 10,
                        decoration: BoxDecoration
                          ( color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                  ),
                ],
                ),
              ),

              Container //block 4
                ( decoration: BoxDecoration
                ( border: Border.all( width:1, ) ),
                height: 100,
                width: 100,
                child: Stack
                  ( children:
                [ Positioned //needs to be in a stack of Container
                  ( left: 80, top: 72, //fixed position up to a 100
                    child: Container
                      ( height: 10, width: 10,
                      decoration: BoxDecoration
                        ( color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    )
                ),
                  Positioned //needs to be in a stack of Container
                    ( left: 10, top: 72, //fixed position up to a 100
                      child: Container
                        ( height: 10, width: 10,
                        decoration: BoxDecoration
                          ( color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                  ),
                  Positioned //needs to be in a stack of Container
                    ( left: 10, top: 10, //fixed position up to a 100
                      child: Container
                        ( height: 10, width: 10,
                        decoration: BoxDecoration
                          ( color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                  ),
                  Positioned //needs to be in a stack of Container
                    ( left: 80, top: 10, //fixed position up to a 100
                      child: Container
                        ( height: 10, width: 10,
                        decoration: BoxDecoration
                          ( color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                  ),
                ],
                ),
              ),

              Container //block 5
                ( decoration: BoxDecoration
                ( border: Border.all( width:1, ) ),
                height: 100,
                width: 100,
                child: Stack
                  ( children:
                [ Positioned //needs to be in a stack of Container
                  ( left: 80, top: 72, //fixed position up to a 100
                    child: Container
                      ( height: 10, width: 10,
                      decoration: BoxDecoration
                        ( color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    )
                ),
                  Positioned //needs to be in a stack of Container
                    ( left: 10, top: 72, //fixed position up to a 100
                      child: Container
                        ( height: 10, width: 10,
                        decoration: BoxDecoration
                          ( color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                  ),
                  Positioned //needs to be in a stack of Container
                    ( left: 10, top: 10, //fixed position up to a 100
                      child: Container
                        ( height: 10, width: 10,
                        decoration: BoxDecoration
                          ( color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                  ),
                  Positioned //needs to be in a stack of Container
                    ( left: 80, top: 10, //fixed position up to a 100
                      child: Container
                        ( height: 10, width: 10,
                        decoration: BoxDecoration
                          ( color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                  ),
                  Positioned //needs to be in a stack of Container
                    ( left: 45, top: 45, //fixed position up to a 100
                      child: Container
                        ( height: 10, width: 10,
                        decoration: BoxDecoration
                          ( color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                  ),
                ],
                ),
              ),

              Container //block 6
                ( decoration: BoxDecoration
                ( border: Border.all( width:1, ) ),
                height: 100,
                width: 100,
                child: Stack
                  ( children:
                [ Positioned //needs to be in a stack of Container
                  ( left: 80, top: 72, //fixed position up to a 100
                    child: Container
                      ( height: 10, width: 10,
                      decoration: BoxDecoration
                        ( color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    )
                ),
                  Positioned //needs to be in a stack of Container
                    ( left: 10, top: 72, //fixed position up to a 100
                      child: Container
                        ( height: 10, width: 10,
                        decoration: BoxDecoration
                          ( color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                  ),
                  Positioned //needs to be in a stack of Container
                    ( left: 10, top: 10, //fixed position up to a 100
                      child: Container
                        ( height: 10, width: 10,
                        decoration: BoxDecoration
                          ( color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                  ),
                  Positioned //needs to be in a stack of Container
                    ( left: 80, top: 10, //fixed position up to a 100
                      child: Container
                        ( height: 10, width: 10,
                        decoration: BoxDecoration
                          ( color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                  ),
                  Positioned //needs to be in a stack of Container
                    ( left: 45, top: 10, //fixed position up to a 100
                      child: Container
                        ( height: 10, width: 10,
                        decoration: BoxDecoration
                          ( color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                  ),
                  Positioned //needs to be in a stack of Container
                    ( left: 80, top: 45, //fixed position up to a 100
                      child: Container
                        ( height: 10, width: 10,
                        decoration: BoxDecoration
                          ( color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                  ),
                ],
                ),
              ),
            ],
          ),

        ]
      ),
    );
  }
}

