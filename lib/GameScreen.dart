import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meme/constraints/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:async/async.dart';
class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  List<int> matchedIndexes=[];
  String resultDeclaration = '';
  int oScore=0;
  int xScore=0;
  int filledBoxes=0;
  bool winnerFound = false;
  static const maxSeconds=15;
  int seconds=maxSeconds;
  Timer? timer;
  int attempts=0;
  static var customeFontWhite = GoogleFonts.coiny(

    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 28,
      letterSpacing: 3,
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(21.0),
        child: Column(
          children: [
            Expanded(flex: 1,
              child: Container(
               child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Player O",style: customeFontWhite,),
                        Text(oScore.toString(),style: customeFontWhite,),
                      ],
                    ),
                    SizedBox(width: 20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Player X",style: customeFontWhite,),
                        Text(xScore.toString(),style: customeFontWhite,),
                      ],
                    ),

                  ],
                ),
              ),
            ),

            Expanded(flex: 3,
              child: GridView.builder(itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: MainColor.primaryColor,
                            width: 5),
                        color: matchedIndexes.contains(index) ? MainColor.tertiaryColor : MainColor.secondaryColor,
                      ),
                        child: Center(
                          child: Text(
                            displayXO[index],
                            style: GoogleFonts.coiny(
                              textStyle: TextStyle(
                                fontSize: 64,
                                color: Colors.white,
                              ),
                            ),

                          ),
                        ),
                      ),
                    );
                  }
              ),),
            Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(resultDeclaration,
                                    style: GoogleFonts.coiny(
                      textStyle: TextStyle(
                        fontSize: 34,
                        color: Colors.white,
                      ),),
                      ),
                      SizedBox(height: 20,),
                      _buildTimer(),

                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRunning= timer ==null ? false : timer!.isActive;
    if(isRunning){
      setState(() {
        if (oTurn && displayXO[index] == '') {
          displayXO[index] = 'O';
          filledBoxes++;
        }
        else if (!oTurn && displayXO[index] == '') {
          displayXO[index] = 'X';
          filledBoxes++;
        }
        oTurn = !oTurn;
        _checkWinner();
      });
    };

  }

  void _checkWinner() {
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = "Player " + displayXO[0] + " Wins!";
        matchedIndexes=[0,1,2];
        _stopTimer();
        _updateScore(displayXO[0]);
      });
    }

    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = "Player " + displayXO[3] + " Wins!";
        matchedIndexes=[3,4,5];
        _stopTimer();
        _updateScore(displayXO[3]);
      });
    }
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = "Player " + displayXO[6] + " Wins!";
        matchedIndexes=[6,7,8];
        _stopTimer();
        _updateScore(displayXO[6]);
      });
    }

    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = "Player " + displayXO[0] + " Wins!";
        _updateScore(displayXO[0]);
      });
    }

    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = "Player " + displayXO[1] + " Wins!";
        matchedIndexes=[1,4,7];
        _stopTimer();
        _updateScore(displayXO[1]);
      });
    }

    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = "Player " + displayXO[2] + " Wins!";
        matchedIndexes=[2,5,8];
        _stopTimer();
        _updateScore(displayXO[2]);
      });
    }

    if (displayXO[6] == displayXO[4] &&
        displayXO[4] == displayXO[2] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = "Player " + displayXO[6] + " Wins!";
        matchedIndexes=[6,4,2];
        _stopTimer();
        _updateScore(displayXO[6]);
      });
    }
    if(displayXO[0]==displayXO[4]&&
        displayXO[0]==displayXO[8]&&
        displayXO[0]!='') {
      setState(() {
        resultDeclaration = "Player " + displayXO[0] + " Wins!";
        matchedIndexes = [0, 4, 8];
        _stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    if(displayXO[0]==displayXO[3]&&
        displayXO[0]==displayXO[6]&&
        displayXO[0]!='') {
      setState(() {
        resultDeclaration = "Player " + displayXO[2] + " Wins!";
        matchedIndexes = [0, 3, 6];
        _stopTimer();
        _updateScore(displayXO[2]);
      });
    }
     if(!winnerFound && filledBoxes==9){
      setState(() {
        resultDeclaration = "Game Draw!";
        _stopTimer();
      });
    }

  }
  void _updateScore (String winner){
    if(winner=='O'){
      oScore++;
    }
    else if(winner=='X'){
      xScore++;
    }
    winnerFound=true;

  }
  void _clearBoard(){
    setState((){
      for(int i =0 ; i<9;i++){
        displayXO[i]='';
      }
      resultDeclaration='';
    });
    filledBoxes=0;
  }

  void _startTimer() {
    setState(() {
      timer = Timer.periodic(Duration(seconds: 1), (_) {
        setState(() {
          if (seconds > 0) {
            seconds--;
          } else {
            _stopTimer();
          }
        });
      });
    });
  }

  void _stopTimer() {
    _resetTimer();
    timer?.cancel();
  }

  void _resetTimer() {
    seconds = maxSeconds;
  }

  Widget _buildTimer(){
    final isRunning= timer ==null ? false : timer!.isActive;
    return isRunning ?
    SizedBox(
      width:100 ,
      height:100,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1-seconds/maxSeconds,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            backgroundColor: MainColor.primaryColor,
            strokeWidth: 8,
          ),
          Center(
            child: Text(
              '$seconds',
              style: GoogleFonts.coiny(
                textStyle: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),),
            ),
          ),
          Center(
            child: Text(
              '$seconds',
              style: GoogleFonts.coiny(
                textStyle: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),),
            ),
          ),
        ],
      ),

    )
        :ElevatedButton(style:ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
    ), onPressed:
        (){
      _startTimer();
      _clearBoard();
      attempts++;

    },
        child: Text
          (

          attempts==0? 'Start' : "Play Again!",
          style: GoogleFonts.coiny(
            textStyle: TextStyle(
              fontSize: 24,
              color: MainColor.primaryColor,
            ),),));
  }

}
