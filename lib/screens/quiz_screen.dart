import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:spello_1/models/wordlist.dart';

import 'package:spello_1/screens/starting_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz-screen';

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final TextEditingController controller = new TextEditingController();

  // Provider.of<QuestionMap>(context).items;

  var _questionIndex = 0;

  int score = 0;

  bool equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

  // String wordScrambeler(String str) {
  //   List<String> tempList = str.split("");
  //   tempList.shuffle();
  //   String string = tempList.join();
  //   return string;
  // }

  // String scrambleWord(String str, List list) {
  //   while (str == list[_questionIndex].text) {
  //     str = wordScrambeler(str);
  //   }
  //   return str.toUpperCase();
  // }
  String scrambleWord(String str, List list) {
    List<String> tempList = str.split("");
    tempList.shuffle();
    String string = tempList.join();
    if (string == list[_questionIndex].text) {
      return scrambleWord(string, list);
    } else {
      return string.toUpperCase();
    }
  }

  void _check(List list) {
    if (equalsIgnoreCase(result, list[_questionIndex].text)) {
      score++;
      QuizAlert.correct(
          list, _questionIndex, context, score, next, getQuestionNumber);
      // correctAlert(list).show();
    } else {
      QuizAlert.wrong(
          list, _questionIndex, context, score, next, getQuestionNumber);
      // wrongAlert(list, _questionIndex).show();
    }
  }

  void next(List list) {
    Image img;
    if (_questionIndex < list.length - 1) {
      setState(() {
        _questionIndex++;
      });
    } else {
      if (score < list.length / 2) {
        img = Image.asset("images/original.jpg");
      } else {
        img = Image.asset("images/finish.jpg");
      }
      QuizAlert.finished(img, list, _questionIndex, context, score, finish);
    }
  }

  void finish(List list) {
    _questionIndex = 0;
    list = null;
    Navigator.pop(context);
  }

  String result = "text";

  void inputSubmitted(String input) {
    setState(
      () {
        result = input;
        print("changing");
      },
    );
  }

  int getQuestionNumber() {
    return _questionIndex + 1;
  }

  // Alert wrongAlert(List list, int questionIndex) {
  //   return Alert(
  //     context: context,
  //     type: AlertType.error,
  //     title:
  //         "Wrong, the correct word was:" + """ """ + list[questionIndex].text,
  //     desc: "You spelled " +
  //         score.toString() +
  //         " out of " +
  //         getQuestionNumber().toString() +
  //         " words correctly",
  //     style: AlertStyle(
  //       isCloseButton: false,
  //       isOverlayTapDismiss: false,
  //     ),
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           "NEXT",
  //           style: TextStyle(color: Colors.white, fontSize: 20),
  //         ),
  //         onPressed: () {
  //           Navigator.pop(context);
  //           next(list);
  //         },
  //         width: 120,
  //       )
  //     ],
  //   );
  // }

  // Alert correctAlert(List list) {
  //   return Alert(
  //     context: context,
  //     type: AlertType.success,
  //     title: "Correct",
  //     desc: "You spelled " +
  //         score.toString() +
  //         " out of " +
  //         getQuestionNumber().toString() +
  //         " words correctly",
  //     style: AlertStyle(
  //       isCloseButton: false,
  //       isOverlayTapDismiss: false,
  //     ),
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           "NEXT",
  //           style: TextStyle(color: Colors.white, fontSize: 20),
  //         ),
  //         onPressed: () {
  //           Navigator.pop(context);
  //           next(list);
  //         },
  //         width: 120,
  //       )
  //     ],
  //   );
  // }

  // Alert finishAlert(Image img, List list) {
  //   return Alert(
  //     context: context,
  //     image: img,
  //     title: "FINISHED",
  //     desc: "You got " +
  //         score.toString() +
  //         " out of " +
  //         list.length.toString() +
  //         " words correct",
  //     style: AlertStyle(
  //       isCloseButton: false,
  //       isOverlayTapDismiss: false,
  //     ),
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           "FINISH",
  //           style: TextStyle(color: Colors.white, fontSize: 20),
  //         ),
  //         onPressed: () {
  //           Navigator.pop(context);
  //           finish(list);
  //         },
  //         width: 120,
  //       )
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // fetchAndSetWords();

    List questionList = items;
    print("building quiz");
    print(questionList);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Word " +
              getQuestionNumber().toString() +
              " out of " +
              questionList.length.toString(),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(children: [
          new Expanded(
            flex: 4,
            child: new Container(
                width: double.infinity,
                color: Colors.orangeAccent,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
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
                            width: 350,
                            height: 350,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  questionList[_questionIndex].imageURL,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue[200],
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(5.0, 5.0),
                                      blurRadius: 2)
                                ]),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Text(
                                  "Scrambled word: " +
                                      scrambleWord(
                                          questionList[_questionIndex].text,
                                          questionList),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // child: Text(
                  //   questionList[_questionIndex].text,
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 20),
                  //   textAlign: TextAlign.center,
                  // ),
                )
                // ... top container contents
                ),
          ),
          new Expanded(
            flex: 2,
            child: new Container(
                width: double.infinity,
                color: Colors.purpleAccent,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(5.0, 5.0),
                                      blurRadius: 2)
                                ]),
                            width: 250,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 30, 30, 30),
                                child: Container(
                                  child: TextField(
                                    controller: controller,
                                    textAlign: TextAlign.center,
                                    decoration: new InputDecoration(
                                      hintText: "Type here",
                                    ),
                                    onChanged: (String str) {
                                      result = str;
                                    },
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: new CheckButton(
                              questionList: questionList,
                              check: _check,
                              controller: controller),
                        ),
                      ],
                    ),
                  ),
                )
                // ... bottom container contents
                ),
          ),
        ]),
      ),
    );
  }
}

class QuizAlert extends Alert {
  var alertStyle = AlertStyle(
    isCloseButton: false,
    isOverlayTapDismiss: false,
  );

  QuizAlert.wrong(List list, int questionIndex, BuildContext context, int score,
      Function next, Function getQuestionNumber) {
        
    Alert(
      context: context,
      type: AlertType.error,
      title:
          "Wrong, the correct word was:" + """ """ + list[questionIndex].text,
      desc: "You spelled " +
          score.toString() +
          " out of " +
          getQuestionNumber().toString() +
          " words correctly",
      style: alertStyle,
      buttons: [
        DialogButton(
          child: Text(
            "NEXT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            next(list);
          },
          width: 120,
        )
      ],
    ).show();
  }

  QuizAlert.correct(List list, int questionIndex, BuildContext context,
      int score, Function next, Function getQuestionNumber) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Correct",
      desc: "You spelled " +
          score.toString() +
          " out of " +
          getQuestionNumber().toString() +
          " words correctly",
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
            Navigator.pop(context);
            next(list);
          },
          width: 120,
        )
      ],
    ).show();
  }

  QuizAlert.finished(Image img, List list, int questionIndex,
      BuildContext context, int score, Function finish) {
    Alert(
      context: context,
      image: img,
      title: "FINISHED",
      desc: "You got " +
          score.toString() +
          " out of " +
          list.length.toString() +
          " words correct",
      style: AlertStyle(
        isCloseButton: false,
        isOverlayTapDismiss: false,
      ),
      buttons: [
        DialogButton(
          child: Text(
            "FINISH",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            finish(list);
          },
          width: 120,
        )
      ],
    ).show();
  }
}

class CheckButton extends StatelessWidget {
  CheckButton(
      {Key key,
      @required this.questionList,
      @required this.check,
      @required this.controller})
      : super(key: key);

  final List questionList;
  final Function check;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.clear();
        check(questionList);
      },
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(5.0, 5.0),
                  blurRadius: 2)
            ]),
        child: Center(
          child: Text(
            "CHECK",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
