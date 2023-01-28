import 'package:flutter/material.dart';

import 'package:spello_1/screens/quiz_screen.dart';
import 'package:spello_1/screens/wordsearch_screen.dart';
import 'package:spello_1/models/wordlist.dart';

import './screens//starting_screen.dart';

void main() => runApp(SpelloApp());

class SpelloApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var finalGrid;
    return MaterialApp(home: StartingScreen(), routes: {
      QuizScreen.routeName: (ctx) => QuizScreen(),
      WordSearch.routeName: (ctx) => WordSearch(finalGrid),
    });
  }
}

