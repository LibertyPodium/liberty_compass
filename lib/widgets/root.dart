import 'dart:html' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liberty_compass/widgets/dialogs/share_results_dialog.dart';

import '../utils.dart';
import '../quiz/answer.dart';
import '../quiz/quiz.dart';
import './layout.dart';

class Root extends StatefulWidget {
  final Map<String, String> parameters;

  const Root({required this.parameters, Key? key}) : super(key: key);

  @override
  RootState createState() => RootState();
}

class RootState extends State<Root> with SingleTickerProviderStateMixin {
    Quiz quiz = Quiz('quiz_questions.csv');
    bool ready = false;
    bool started = false;
    bool saving = false;
    Answer? selectedAnswer;
    DocumentReference? savedDocument;

    late final AnimationController loadingAnimationController = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this
    )..repeat();

    @override
    void initState() {
        super.initState();
        quiz.setupQuestions().then((_) {
            if (widget.parameters.containsKey('results')) {
                setUrlToResultsPage(widget.parameters['results']!);
                quiz.lookupResults(widget.parameters['results']!).then((document) {
                    Future.delayed(const Duration(milliseconds: 1250), () {
                        setState(() {
                            ready = true;
                            started = true;
                            savedDocument = document;
                        });
                    });
                });
            } else {
                Future.delayed(const Duration(milliseconds: 1500), () {
                    setState(() {
                        ready = true;
                    });
                });
            }
        });
    }

    void handleStart() {
        // devOnlyPickRandomAnswers(quiz);
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
        quiz.submitAnswer(answer);
        setState(() {
            selectedAnswer = null;
        });
    }

    void handleShareContinue(DocumentReference document) {
        setState(() {
            savedDocument = document;
        });
    }

    void handleShare(BuildContext context) {
        showDialog(
            context: context,
            builder: (context) {
                return ShareResultsDialog(
                    quiz: quiz,
                    onContinue: handleShareContinue
                );
            }
        );
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
                loadingAnimationController: loadingAnimationController,
                quiz: quiz,
                started: started,
                ready: ready,
                saving: saving,
                onStart: handleStart,
                onAnswerSubmit: handleAnswerSubmit,
                onAnswerSelect: handleAnswerSelect,
                onShare: handleShare,
                selectedAnswer: selectedAnswer,
                savedDocument: savedDocument
            ),
        );
    }
}