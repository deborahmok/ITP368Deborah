import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(DealMok());

class Suitcase {
  final int id;
  final int value;

  Suitcase(this.id, this.value);
}

class DealMok extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deal or No Deal',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DealGame(),
    );
  }
}

class DealGame extends StatefulWidget {
  @override
  _DealGameState createState() => _DealGameState();
}

class _DealGameState extends State<DealGame> {
  List<Suitcase> suitcases = [];
  Suitcase? playerSuitcase;
  List<int> revealedValues = [];
  double? dealerOffer;
  bool gameActive = true;

  @override
  void initState() {
    super.initState();
    initializeSuitcases();
  }

  // Initialize 10 suitcases with random values
  void initializeSuitcases() {
    List<int> values = [
      1, 5, 10, 100, 1000, 5000, 10000, 100000, 500000, 1000000
    ];
    values.shuffle(Random());
    for (int i = 0; i < 10; i++) {
      suitcases.add(Suitcase(i + 1, values[i]));
    }
  }

  // Update dealer's offer based on remaining suitcases
  void updateOffer() {
    int sumRemaining = 0;
    int countRemaining = 0;
    for (var suitcase in suitcases) {
      if (!revealedValues.contains(suitcase.value) && suitcase != playerSuitcase) {
        sumRemaining += suitcase.value;
        countRemaining++;
      }
    }
    if (countRemaining > 0) {
      dealerOffer = 0.9 * (sumRemaining / countRemaining); // 90% of expected value
    } else {
      dealerOffer = null; // Reset dealer's offer if no suitcases remain
    }
  }

  // Handle player selecting their first suitcase
  void handleSuitcaseSelection(Suitcase suitcase) {
    if (playerSuitcase == null) {
      setState(() {
        playerSuitcase = suitcase;
        updateOffer();  // Make an offer after the first selection
      });
    } else {
      revealSuitcase(suitcase);  // Reveal suitcases after "No Deal"
    }
  }

  // Reveal a suitcase and calculate the new offer
  void revealSuitcase(Suitcase suitcase) {
    if (!revealedValues.contains(suitcase.value) && suitcase != playerSuitcase) {
      setState(() {
        revealedValues.add(suitcase.value);
        updateOffer();
      });

      if (revealedValues.length >= 9) {
        // If all but one suitcase is revealed, end the game
        gameActive = false;
        _showDialog('Game Over', 'Your suitcase had \$${playerSuitcase!.value}');
      }
    }
  }

  // Handle "Deal" choice
  void handleDeal() {
    setState(() {
      gameActive = false;
    });
    _showDialog('Deal Accepted', 'You accepted the deal for \$${dealerOffer!.toStringAsFixed(2)}');
  }

  // Handle "No Deal" choice
  void handleNoDeal() {
    setState(() {
      if (revealedValues.length < 9) {
        // Prompt the user to select a suitcase to reveal
        _promptRevealSuitcase();
      } else {
        // If all but one suitcase is revealed, end the game
        gameActive = false;
        _showDialog('Game Over', 'Your suitcase had \$${playerSuitcase!.value}');
      }
    });
  }

  void _promptRevealSuitcase() {
    // Show dialog to let the user choose a suitcase to reveal
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose a suitcase to reveal'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: suitcases.where((suitcase) => !revealedValues.contains(suitcase.value) && suitcase != playerSuitcase).map((suitcase) {
                return ListTile(
                  title: Text('Suitcase ${suitcase.id}'),
                  //title: Text('Suitcase ${suitcase.id} - \$${suitcase.value}'),
                  onTap: () {
                    Navigator.of(context).pop(); // Close dialog
                    revealSuitcase(suitcase); // Reveal selected suitcase
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // Show dialog for end of the game
  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Visual representation of remaining and revealed values
  Widget valueTable() {
    List<int> allValues = [1, 5, 10, 100, 1000, 5000, 10000, 100000, 500000, 1000000];
    allValues.sort(); // Ensure values are in ascending order

    return Column(
      children: allValues.map((value) {
        bool revealed = revealedValues.contains(value);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '\$${value.toString()}',
            style: TextStyle(
              color: revealed ? Colors.grey : Colors.black,
              decoration: revealed ? TextDecoration.lineThrough : null,
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deal or No Deal'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(playerSuitcase == null
                ? 'Pick a suitcase'
                : 'You chose suitcase ${playerSuitcase!.id}'),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, childAspectRatio: 2.0),
              itemCount: suitcases.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: gameActive &&
                      !revealedValues.contains(suitcases[index].value) &&
                      (playerSuitcase == null || playerSuitcase != suitcases[index])
                      ? () => handleSuitcaseSelection(suitcases[index])
                      : null,
                  child: Text('Case ${suitcases[index].id}'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      revealedValues.contains(suitcases[index].value)
                          ? Colors.grey
                          : Colors.blue,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            dealerOffer != null
                ? Text('Dealer offers: \$${dealerOffer!.toStringAsFixed(2)}')
                : SizedBox.shrink(),
            SizedBox(height: 10),
            playerSuitcase != null && gameActive && dealerOffer != null
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: gameActive ? handleDeal : null,
                  child: Text('Deal'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: gameActive ? handleNoDeal : null,
                  child: Text('No Deal'),
                ),
              ],
            )
                : SizedBox.shrink(),
            SizedBox(height: 20),
            Text('Values Remaining:'),
            valueTable(),
          ],
        ),
      ),
    );
  }
}