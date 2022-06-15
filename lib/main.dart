import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liberty_compass/answer.dart';
import 'package:liberty_compass/layout.dart';
import 'package:liberty_compass/question.dart';
import 'package:liberty_compass/quiz.dart';
import 'package:liberty_compass/utils.dart';

class LibertyCompass extends StatefulWidget {
  const LibertyCompass({Key? key}) : super(key: key);

  @override
  LibertyCompassState createState() => LibertyCompassState();
}

class LibertyCompassState extends State<LibertyCompass> {
  Quiz quiz = Quiz([]);
  bool started = false;
  int cursor = 0;
  Answer? selectedAnswer;

  void setupQuestions() async {
    final quizQuestionsCsv = await rootBundle.loadString('quiz_questions.csv');
    final quizQuestionsRows = const CsvToListConverter().convert(quizQuestionsCsv, eol: '\n');

    List<Question> quizQuestions = [];

    for (int qI = 1; qI < quizQuestionsRows.length; ++qI) {
      List<Answer> quizQuestionAnswers = [];

      for (int aI = 1; aI < quizQuestionsRows[qI].length - 1; ++aI) {
        quizQuestionAnswers.add(Answer(
            content: getAnswerContent(aI),
            score: parseQuizAnswerScore(quizQuestionsRows[qI][aI])
        ));
      }

      quizQuestions.add(Question(
          content: quizQuestionsRows[qI][0],
          answers: quizQuestionAnswers
      ));
    }

    setState(() {
      quiz = Quiz(quizQuestions..shuffle());
    });
  }

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
      quiz.score.update(QuizVariable.conservative, (value) => value + answer.score[QuizVariable.conservative]!);
    }

    if (answer.score.containsKey(QuizVariable.libertarian)) {
      quiz.score.update(QuizVariable.libertarian, (value) => value + answer.score[QuizVariable.libertarian]!);
    }

    if (answer.score.containsKey(QuizVariable.progressive)) {
      quiz.score.update(QuizVariable.progressive, (value) => value + answer.score[QuizVariable.progressive]!);
    }

    setState(() {
      selectedAnswer = null;
      cursor += 1;
    });
  }

  @override
  void initState() {
    super.initState();
    setupQuestions();
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
        quiz: quiz,
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
  runApp(const LibertyCompass());
}
