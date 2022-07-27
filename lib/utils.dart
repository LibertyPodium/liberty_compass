import 'dart:html' as html;

import './quiz/quiz.dart';

void devOnlyPickRandomAnswers(Quiz quiz) {
    while (quiz.currentQuestion != null) {
        quiz.currentQuestion!.answers.shuffle();
        quiz.submitAnswer(quiz.currentQuestion!.answers.elementAt(3));
    }
}

String getUrlToResultsPage(String id) {
    return '${html.window.location.origin}${html.window.location.pathname}?results=$id';
}

void setUrlToResultsPage(String id) {
    // TODO Navigator.push etc
    html.window.history.pushState(
        null,
        html.document.title,
        '${html.window.location.origin}${html.window.location.pathname}?results=$id'
    );
}

void resetUrl() {
    // TODO Navigator.push etc
    html.window.history.pushState(
        null,
        html.document.title,
        '${html.window.location.origin}${html.window.location.pathname}'
    );
}