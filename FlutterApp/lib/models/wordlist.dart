import 'package:flutter/widgets.dart';

import './word.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Word> items = [];

void addWord(Word word) {
  const url = "https://my-first-project-244715.firebaseio.com/words.json";
  http.post(
    url,
    body: json.encode({
      "text": word.text,
      "imageURL": word.imageURL,
    }),
  );
}


Future<void> fetchAndSetWords() async {
  const url = "https://my-first-project-244715.firebaseio.com/words.json";
  try {
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as List<dynamic>;
    print(extractedData);
    final List<Word> loadedWords = [];
    int wordCounter = 0;
    extractedData.forEach((wordList) {
      loadedWords.add(Word(
        id: wordCounter,
        text: wordList[0],
        imageURL: wordList[1],
      ));
      wordCounter++;
    });
    items = loadedWords;
  } catch (error) {
    throw (error);
  }
}

void orderAlphabetically() {
  var list = items;
  var tmp;
  for (int i = list.length - 1; i > 0; i--) {
    for (int j = 0; j < i; j++) {
      String firstLetterA = list[j].text.substring(0, 1);
      String firstLetterB = list[j + 1].text.substring(0, 1);
      if (firstLetterA.compareTo(firstLetterB) > 0) {
        tmp = list[j + 1];
        list[j + 1] = list[j];
        list[j] = tmp;
      }
    }
  }
  items = list;
}

void randOrder() {
  items.shuffle();
}
