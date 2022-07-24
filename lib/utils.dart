import 'dart:html' as html;

import 'package:flutter/material.dart';

import './quiz/quiz.dart';

void devOnlyPickRandomAnswers(Quiz quiz) {
    while (quiz.currentQuestion != null) {
        quiz.currentQuestion!.answers.shuffle();
        quiz.submitAnswer(quiz.currentQuestion!.answers.first);
    }
}

String getUrlToResultsPage(String id) {
    return '${html.window.location.href}?results=$id';
}

void setUrlToResultsPage(String id) {
    // TODO Navigator.push etc
    html.window.history.pushState(
        null,
        'Results | ${html.document.title}',
        getUrlToResultsPage(id)
    );
}

String getAnswerContent(int index) {
  switch (index) {
    case 1: return 'Strongly disagree';
    case 2: return 'Disagree';
    case 3: return 'Slightly disagree';
    case 4: return 'No opinion';
    case 5: return 'Slightly agree';
    case 6: return 'Agree';
    case 7: return 'Strongly agree';
    default: return '';
  }
}

Map<QuizVariable, int> parseQuizAnswerScore(String scoreText) {
  Map<QuizVariable, int> score = {};
  List<String> scoreTextSplit = scoreText.split(RegExp(r",(?:\s+)?"));

  for (int i = 0; i < scoreTextSplit.length; ++i) {
    List<String> scoreEntrySplit = scoreTextSplit[i].split(RegExp(r"(?:\s+)?\+"));

    switch (scoreEntrySplit[0]) {
      case 'Libertarian': score[QuizVariable.libertarian] = int.parse(scoreEntrySplit[1]); break;
      case 'Conservative': score[QuizVariable.conservative] = int.parse(scoreEntrySplit[1]); break;
      case 'Progressive': score[QuizVariable.progressive] = int.parse(scoreEntrySplit[1]); break;
    }
  }

  return score;
}