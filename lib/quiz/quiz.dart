import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:liberty_compass/quiz/answer.dart';
import 'package:liberty_compass/quiz/question.dart';
import 'package:liberty_compass/quiz/score.dart';
import 'package:liberty_compass/quiz/sentiment.dart';

import 'package:liberty_compass/firebase_options.dart';

enum QuizVariable {
  conservative,
  progressive,
  libertarian
}

class Quiz {
    final String src;
    late final Score score;
    final Sentiment sentiment = Sentiment();
    final List<Question> questions = [];

    int _place = 0;

    int get currentPlace => _place;
    Question? get currentQuestion => _place < questions.length ? questions[_place] : null;

    Quiz(this.src) {
        score = Score(this);
    }

    Map<String, dynamic> toMap() {
        final questionToAnswerMap = {};

        for (final question in questions) {
            questionToAnswerMap[question.originalIndex.toString()] = question.markedAnswer?.index ?? -1;
        }

        return {
            'questions': questionToAnswerMap
        };
    }

    Future<DocumentReference> saveResults() async {
        final database = FirebaseFirestore.instance;
        final document = await database.collection('results').add(toMap());

        return document;
    }

    Future<DocumentReference?> lookupResults(String id) async {
        final database = FirebaseFirestore.instance;
        final document = await database.collection('results').doc(id).get();

        if (!document.exists) {
            return null;
        }

        final resultsMap = document.data()!;

        if (resultsMap.containsKey('questions')) {
            final questionsToAnswersMap = resultsMap['questions'] as Map;

            for (final entry in questionsToAnswersMap.entries) {
                final question = questions.firstWhere((question) => question.originalIndex == int.parse(entry.key));
                final answer = question.answers.firstWhere((answer) => answer.index == entry.value);

                _place = questions.indexOf(question);

                submitAnswer(answer);
            }

            _place = questions.length;
        }

        return document.reference;
    }

    Future setupQuestions() async {
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
        );

        final quizQuestionsCsv = await rootBundle.loadString(src);
        final quizQuestionsRows = const CsvToListConverter().convert(quizQuestionsCsv, eol: '\n');
        final quizQuestionsCount = quizQuestionsRows.length;

        for (int whichQuestion = 1; whichQuestion < quizQuestionsCount; ++whichQuestion) {
            final List questionColumns = quizQuestionsRows[whichQuestion];
            final String questionText = questionColumns[0];
            final String questionSentimentText = questionColumns[questionColumns.length - 1];
            final List<Answer> questionAnswers = [];

            for (int whichAnswer = 1; whichAnswer < quizQuestionsRows[whichQuestion].length - 1; ++whichAnswer) {
                final String scoreText = quizQuestionsRows[whichQuestion][whichAnswer];

                questionAnswers.add(
                    Answer(
                        whichAnswer,
                        Score.parseString(scoreText)
                    )
                );
            }

            questions.add(
                Question(
                    whichQuestion,
                    questionText,
                    questionAnswers,
                    Sentiment.parseString(questionSentimentText)
                )
            );
        }

        questions.shuffle();
    }

    void submitAnswer(Answer answer) {
        score.conservative += answer.score.conservative;
        score.libertarian += answer.score.libertarian;
        score.progressive += answer.score.progressive;

        if (currentQuestion != null) {
            currentQuestion!.markAnswer(answer);
            sentiment.adoptQuestionSentiment(currentQuestion!);
        }

        _place++;
    }
}

