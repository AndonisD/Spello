import 'package:flutter/material.dart';
import 'package:spello_1/models/wordlist.dart';
import 'package:spello_1/screens/quiz_screen.dart';
import 'package:spello_1/screens/wordsearch_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:provider/provider.dart';

class StartingScreen extends StatefulWidget {
  @override
  _StartingScreenState createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  var isLoading = false;
  String result = "text";

  void inputSubmitted(String input) {
    setState(
      () {
        result = input;
        print("changing");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var finalGrid;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SPELLO",
        ),
        backgroundColor: Colors.lightBlueAccent,
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.cloud_download),
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              fetchAndSetWords().then((_) {
                setState(() {
                  isLoading = false;
                });
              });
            },
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              new Expanded(
                flex: 4,
                child: new Container(
                  width: double.infinity,
                  color: Colors.orangeAccent,
                  child: Column(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "                             ↑",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          Text(
                            "Don't forget to download the vocabulary list!",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          // FlatButton(
                          //   child: Text("Alphabetical Order"),
                          //   onPressed: () {
                          //     orderAlphabetically();
                          //   },
                          // ),
                          // FlatButton(
                          //   child: Text("Random Order"),
                          //   onPressed: () {
                          //     randOrder();
                          //   },
                          // ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(90.0),
                        child: Text(
                          "Have fun!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new Expanded(
                flex: 4,
                child: new Container(
                    width: double.infinity,
                    color: Colors.purpleAccent,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              if (items.isEmpty) {
                                updateAlert(context).show();
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuizScreen()),
                                );
                              }
                            },
                            child: new StartQuizButton(),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (items.isEmpty) {
                                updateAlert(context).show();
                              } else {
                                finalGrid = null;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WordSearch(finalGrid)),
                                );
                              }
                            },
                            child: new StartWordSearchButton(),
                          ),
                        ],
                      ),
                    )),
              ),
            ]),
    );
  }

  Alert updateAlert(BuildContext context) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: "OOPS!",
      desc: "You forgot to download the list!",
      buttons: [
        DialogButton(
          child: Text(
            "OKAY",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    );
  }
}

class StartQuizButton extends StatelessWidget {
  const StartQuizButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(5.0, 5.0),
              blurRadius: 2,
            )
          ]),
      width: 250,
      height: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Center(
          child: Text(
            "QUIZ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 80,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class StartWordSearchButton extends StatelessWidget {
  const StartWordSearchButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(5.0, 5.0),
              blurRadius: 2,
            )
          ]),
      width: 250,
      height: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Center(
          child: Text(
            "WORD SEACH",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 60,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
