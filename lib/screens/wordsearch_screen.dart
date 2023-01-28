//flutter libraries:
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
//dart libraries:

//used to generate grid in word search:
import 'dart:math';
import 'dart:core';
//used to retrieve words from database:
import 'package:http/http.dart' as http;
import 'dart:convert';

//third-party libraries:
import 'package:rflutter_alert/rflutter_alert.dart';
//application classes:
import 'package:spello_1/models/wordlist.dart';
import 'package:spello_1/models/word.dart';

class WordSearch extends StatefulWidget {
  final finalGrid;

  WordSearch(this.finalGrid);

  static const routeName = '/word-search';

  @override
  WordSearchState createState() => WordSearchState(items, finalGrid);
}

var sortedWords = words.sort((a, b) => a.length.compareTo(b.length));

int maxLength(List<String> list) {
  int maxLength = 0;
  for (int i = 0; i < list.length; i++) {
    if (list[i].length > maxLength) {
      maxLength = list[i].length;
    }
  }
  return maxLength;
}

int gridSize = maxLength(words);

var words = wordList();

String selectedWord = "yeet";

var lst = items;

List<String> wordList() {
  lst.shuffle();
  print(lst);
  List<String> finalLst = [];
  for (int j = 0; j < 3; j++) {
    finalLst.add(lst[j].text.toUpperCase());
  }
  print("words:");
  print(finalLst);
  return finalLst;
}

class WordSearchState extends State<WordSearch> {
  var finalGrid;
  List<Word> items;
  WordSearchState(this.items, finalGrid);

  String wordText = "";

  int wordIndex = 0;

  List<List<String>> addWords(var words) {
    List<List<String>> emptyGrid = new List.generate(
      gridSize,
      (i) => new List.generate(gridSize, (j) => "_"),
    );
    Random rnd = new Random(); //random number generator
    var orientations = [
      'horizontal',
      'vertical'
    ]; //list of possible orientations
    String orientation; //orientation of the word on the grid
    int i = 0;
    while (i < words.length) {
      var word = words[i]; //words[] contains 3 randomly picked vocab words
      var x, y; //starting point coordinates on the grid for the word
      var xInc,
          yInc = 0; //increment values for the word that depend on orientation
      int range = gridSize -
          word.length +
          1; //limits where the word can start depending on orientation
      orientation = orientations[
          rnd.nextInt(orientations.length)]; //picks random orientation
      if (orientation == 'horizontal') {
        x = rnd.nextInt(range);
        y = rnd.nextInt(gridSize);
        xInc = 1; //each successive letter will move on tile right
      }
      if (orientation == 'vertical') {
        x = rnd.nextInt(gridSize);
        y = rnd.nextInt(range);
        yInc = 1; //each successive letter will move on tile down
      }
      var letters = word.split(""); //list of letters of the word
      bool canPlace = true;
      var xTest = x;
      var yTest = y;
      for (int j = 0; j < word.length; j++) {
        if (emptyGrid[yTest][xTest] == "_" || //if the tile is empty
            emptyGrid[yTest][xTest] == letters[j].toLowerCase()) {
          //or if it conatins the same letter
          xTest = xTest + xInc;//increment x if word is horizontal
          yTest = yTest + yInc;//increment y if word if vertical
        } else {
          canPlace = false;
          break; //breaks out of loop
        }
      }
      if (canPlace) {
        for (int k = 0; k < word.length; k++) {
          emptyGrid[y][x] = letters[k].toLowerCase();
          x = x + xInc;
          y = y + yInc;
        }//places each letter of the word into the grid
      } else {
        continue;//goes back to while loop to try new values
      }
      i++;
    }
    return gridPopulate(emptyGrid, gridSize);
  }

  List<List<String>> gridPopulate(var grid, int gridSize) {
    String abc = "abcdefghijklmnopqrstuvwxyz";
    List<String> abcList = abc.split(""); //list of alphabet
    Random rnd = new Random(); //random number generator
    for (int x = 0; x < gridSize; x++) {
      for (int y = 0; y < gridSize; y++) {
        if (grid[x][y] == "_") {
          //if grid tile is empty
          grid[x][y] =
              abcList[rnd.nextInt(abcList.length)]; //insert random letter
        }
      }
    }
    return grid;
  }

  void updateText(String text) {
    setState(() {
      wordText = text;
    });
  }

  void check(String word) {
    print(words);
    if (word == words[wordIndex]) {
      Alert(
        context: context,
        type: AlertType.success,
        title: "Correct",
        desc: "The word was " + items[wordIndex].text,
        style: AlertStyle(
          isCloseButton: false,
          isOverlayTapDismiss: false,
        ),
        buttons: [
          DialogButton(
            child: Text(
              "NEXT",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              if (wordIndex >= 2) {
                Navigator.pop(context);
                finish();
              } else {
                Navigator.pop(context);
                setState(() {
                  wordIndex++;
                  wordText = "";
                });
              }
            },
            width: 120,
          )
        ],
      ).show();
    } else {
      print("wrong");
    }
  }

  void finish() {
    finalGrid = null;
    wordIndex = 0;
    words = wordList();
    gridSize = maxLength(words);
    print("finished");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    finalGrid = addWords(words);
    return WillPopScope(
      onWillPop: () {
        finalGrid = null;
        wordIndex = 0;
        words = wordList();
        gridSize = maxLength(words);
        print("finished");
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              "SPELLO",
            ),
            backgroundColor: Colors.lightBlueAccent,
            actions: <Widget>[]),
        body: Column(children: [
          new Expanded(
            flex: 5,
            child: new Container(
              width: double.infinity,
              color: Colors.purpleAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(5.0, 5.0),
                                blurRadius: 2)
                          ]),
                      width: 270,
                      height: 270,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            items[wordIndex].imageURL,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    wordText,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          new Expanded(
            flex: 6,
            child: new Container(
              width: double.infinity,
              color: Colors.orangeAccent,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Grid(updateText, check, finalGrid),
              ),
              // ... bottom container contents
            ),
          )
        ]),
      ),
    );
  }
}


Widget gridItem(index, finalGrid) {
  int y = (index / gridSize).floor();
  int x = (index % gridSize);
  return Text(
    finalGrid[x][y].toUpperCase(),
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 40,
      color: Colors.blue,
    ),
  );
}

String _getWord(selectedIndexes, finalGrid) {
  var word = new List();
  for (int i = 0; i < selectedIndexes.length; i++) {
    var index = selectedIndexes[i];
    word.add(_getLetter(index, finalGrid));
  }
  return word.join();
}

String _getLetter(index, finalGrid) {
  int y = (index / gridSize).floor();
  int x = (index % gridSize);
  return finalGrid[x][y].toUpperCase();
}

class Grid extends StatefulWidget {
  final Function updateText;
  final Function check;
  final List<List<String>> finalGrid;

  Grid(this.updateText, this.check, this.finalGrid);

  @override
  GridState createState() {
    return new GridState(updateText, check, finalGrid);
  }
}

class GridState extends State<Grid> {
  final Function updateText;
  final Function check;
  final List<List<String>> finalGrid;
  GridState(this.updateText, this.check, this.finalGrid);

  final List<int> selectedIndexes = List<int>();
  final key = GlobalKey();
  final Set<_LetterRenderBox> _trackTaped = Set<_LetterRenderBox>();

  GlobalKey<WordSearchState> _stateKey = GlobalKey();

  _detectTapedItem(PointerEvent event) {
    final RenderBox box = key.currentContext.findRenderObject();
    final result = BoxHitTestResult();
    Offset local = box.globalToLocal(event.position);
    if (box.hitTest(result, position: local)) {
      for (final hit in result.path) {
        final target = hit.target;
        if (target is _LetterRenderBox && !_trackTaped.contains(target)) {
          _trackTaped.add(target);
          _selectIndex(target.index);
        }
      }
    }
  }

  _selectIndex(int index) {
    setState(() {
      selectedIndexes.add(index); //list of selected grid indexes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _detectTapedItem,//when student start selecting/dragging
      onPointerMove: _detectTapedItem,//while the student is selecting/dragging
      onPointerUp: _clearSelection,//when the student raises their
      child: GridView.builder(
        key: key,
        itemCount: gridSize * gridSize,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridSize,
          childAspectRatio: 1.0,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemBuilder: (context, index) {
          return LetterRenderBox(
            index: index,
            child: Container(
              alignment: Alignment.center,
              color: selectedIndexes.contains(index)
                  ? Colors.blue[100]
                  : Colors.white,
              child: gridItem(index, finalGrid),
            ),
          );
        },
      ),
    );
  }

  void _clearSelection(PointerUpEvent event) {
    setState(() {
      selectedWord = _getWord(selectedIndexes, finalGrid);
    });//convert indexes selected on grid into the word the student spelled
    updateText(selectedWord);//update the text above the grid
    check(selectedWord);//check against word shown by image
    setState(() {
      selectedIndexes.clear();
      _trackTaped.clear();
    });//clear these lists so that a new word can be selected
  }
}


class LetterRenderBox extends SingleChildRenderObjectWidget {
  final int index;

  LetterRenderBox({Widget child, this.index, Key key})
      : super(child: child, key: key);

  @override
  _LetterRenderBox createRenderObject(BuildContext context) {
    return _LetterRenderBox()..index = index;
  }

  @override
  void updateRenderObject(BuildContext context, _LetterRenderBox renderObject) {
    renderObject..index = index;
  }
}

class _LetterRenderBox extends RenderProxyBox {
  int index;
}
