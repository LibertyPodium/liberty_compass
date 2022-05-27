import 'package:flutter/material.dart';
import 'package:liberty_compass/answer.dart';
import 'package:liberty_compass/layout.dart';
import 'package:liberty_compass/question.dart';
import 'package:liberty_compass/quiz.dart';

class LibertyCompass extends StatefulWidget {
  final Quiz quiz;

  const LibertyCompass(this.quiz, {Key? key}) : super(key: key);

  @override
  LibertyCompassState createState() => LibertyCompassState();
}

class LibertyCompassState extends State<LibertyCompass> {
  bool started = false;
  int cursor = 0;
  Answer? selectedAnswer;

  void handleStart() {
    setState(() {
      started = true;
    });
  }

  void handleAnswerSelect(Answer answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }
  
  void handleAnswerSubmit(Answer answer) {
    if (answer.score.containsKey(QuizVariable.conservative)) {
      widget.quiz.score.update(QuizVariable.conservative, (value) => value + answer.score[QuizVariable.conservative]!);
    }

    if (answer.score.containsKey(QuizVariable.libertarian)) {
      widget.quiz.score.update(QuizVariable.libertarian, (value) => value + answer.score[QuizVariable.libertarian]!);
    }

    if (answer.score.containsKey(QuizVariable.progressive)) {
      widget.quiz.score.update(QuizVariable.progressive, (value) => value + answer.score[QuizVariable.progressive]!);
    }

    setState(() {
      selectedAnswer = null;
      cursor += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Liberty Compass',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Layout(
        quiz: widget.quiz,
        cursor: cursor,
        started: started,
        onStart: handleStart,
        onAnswerSubmit: handleAnswerSubmit,
        onAnswerSelect: handleAnswerSelect,
        selectedAnswer: selectedAnswer,
      ),
    );
  }
}

void main() {
  runApp(LibertyCompass(
    Quiz([
      Question(
        content: 'It should be legal for two consenting adults of the same sex to be married.',
        answers: [
          Answer(
            content: 'Strongly disagree',
            score: {
              QuizVariable.conservative: 2
            }
          ),
          Answer(
            content: 'Disagree',
            score: {
              QuizVariable.conservative: 2
            }
          ),
          Answer(
            content: 'Slightly disagree',
            score: {
              QuizVariable.conservative: 1
            }
          ),
          Answer(
            content: 'No opinion',
            score: {
              QuizVariable.conservative: 1
            }
          ),
          Answer(
            content: 'Slightly agree',
            score: {
              QuizVariable.progressive: 1
            }
          ),
          Answer(
            content: 'Agree',
            score: {
              QuizVariable.progressive: 2,
              QuizVariable.libertarian: 1
            }
          ),
          Answer(
            content: 'Strongly agree',
            score: {
              QuizVariable.conservative: 2,
              QuizVariable.libertarian: 2
            }
          )
        ]
      ),
      Question(
        content: 'It should be legal for a government to spy on their citizens in order to root out extremists.',
        answers: [
          Answer(
            content: 'Strongly disagree',
            score: {
              QuizVariable.libertarian: 2
            }
          ),
          Answer(
            content: 'Disagree',
            score: {
              QuizVariable.libertarian: 1
            }
          ),
          Answer(
            content: 'Slightly disagree',
            score: {
              QuizVariable.conservative: 1,
              QuizVariable.libertarian: 1
            }
          ),
          Answer(
            content: 'No opinion',
            score: {
              QuizVariable.conservative: 1
            }
          ),
          Answer(
            content: 'Slightly agree',
            score: {
              QuizVariable.conservative: 2,
              QuizVariable.progressive: 1
            }
          ),
          Answer(
            content: 'Agree',
            score: {
              QuizVariable.conservative: 2,
              QuizVariable.progressive: 2
            }
          ),
          Answer(
            content: 'Strongly agree',
            score: {
              QuizVariable.conservative: 2,
              QuizVariable.progressive: 2
            }
          )
        ]
      ),
      Question(
        content: 'It should be legal for an adult to purchase and use any recreational drug.',
        answers: [
          Answer(
            content: 'Strongly disagree',
            score: {
              QuizVariable.conservative: 2
            }
          ),
          Answer(
            content: 'Disagree',
            score: {
              QuizVariable.conservative: 2
            }
          ),
          Answer(
            content: 'Slightly disagree',
            score: {
              QuizVariable.conservative: 1,
            }
          ),
          Answer(
            content: 'No opinion',
            score: {
              QuizVariable.progressive: 1
            }
          ),
          Answer(
            content: 'Slightly agree',
            score: {
              QuizVariable.libertarian: 1,
              QuizVariable.progressive: 1
            }
          ),
          Answer(
            content: 'Agree',
            score: {
              QuizVariable.libertarian: 2,
              QuizVariable.progressive: 1
            }
          ),
          Answer(
            content: 'Strongly agree',
            score: {
              QuizVariable.libertarian: 2,
              QuizVariable.progressive: 1
            }
          )
        ]
      ),
      Question(
        content: 'Government should disallow certain religious beliefs and organizations.',
        answers: [
          Answer(
            content: 'Strongly disagree',
            score: {
              QuizVariable.libertarian: 2,
              QuizVariable.progressive: 1
            }
          ),
          Answer(
            content: 'Disagree',
            score: {
              QuizVariable.libertarian: 2,
              QuizVariable.progressive: 1
            }
          ),
          Answer(
            content: 'Slightly disagree',
            score: {
              QuizVariable.libertarian: 1,
              QuizVariable.progressive: 2
            }
          ),
          Answer(
            content: 'No opinion',
            score: {
              QuizVariable.progressive: 1
            }
          ),
          Answer(
            content: 'Slightly agree',
            score: {
              QuizVariable.conservative: 1,
              QuizVariable.progressive: 1
            }
          ),
          Answer(
            content: 'Agree',
            score: {
              QuizVariable.conservative: 2,
            }
          ),
          Answer(
            content: 'Strongly agree',
            score: {
              QuizVariable.conservative: 2,
            }
          )
        ]
      ),
      Question(
        content: 'Government should disallow people from owning certain types of weapons (knives, guns, explosives, etc.).',
        answers: [
          Answer(
            content: 'Strongly disagree',
            score: {
              QuizVariable.libertarian: 2,
              QuizVariable.conservative: 1
            }
          ),
          Answer(
            content: 'Disagree',
            score: {
              QuizVariable.libertarian: 1,
              QuizVariable.conservative: 2
            }
          ),
          Answer(
            content: 'Slightly disagree',
            score: {
              QuizVariable.conservative: 1
            }
          ),
          Answer(
            content: 'No opinion',
            score: {
              QuizVariable.progressive: 1
            }
          ),
          Answer(
            content: 'Slightly agree',
            score: {
              QuizVariable.progressive: 1
            }
          ),
          Answer(
            content: 'Agree',
            score: {
              QuizVariable.progressive: 2
            }
          ),
          Answer(
            content: 'Strongly agree',
            score: {
              QuizVariable.progressive: 2
            }
          )
        ]
      ),
      Question(
        content: 'Government should disallow people from saying things that are deemed as offensive to someone else.',
        answers: [
          Answer(
            content: 'Strongly disagree',
            score: {
              QuizVariable.libertarian: 2,
              QuizVariable.conservative: 1
            }
          ),
          Answer(
            content: 'Disagree',
            score: {
              QuizVariable.libertarian: 2,
              QuizVariable.conservative: 2
            }
          ),
          Answer(
            content: 'Slightly disagree',
            score: {
              QuizVariable.libertarian: 1,
              QuizVariable.conservative: 1
            }
          ),
          Answer(
            content: 'No opinion',
            score: {
              QuizVariable.conservative: 1,
              QuizVariable.progressive: 1
            }
          ),
          Answer(
            content: 'Slightly agree',
            score: {
              QuizVariable.progressive: 1
            }
          ),
          Answer(
            content: 'Agree',
            score: {
              QuizVariable.progressive: 1
            }
          ),
          Answer(
            content: 'Strongly agree',
            score: {
              QuizVariable.progressive: 2
            }
          )
        ]
      ),
    ])
  ));
}
