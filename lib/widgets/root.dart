import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liberty_compass/widgets/screens/question_screen.dart';
import 'package:liberty_compass/widgets/screens/results_screen.dart';

import '../quiz/answer.dart';
import '../quiz/quiz.dart';
import '../utils.dart';

import './dialogs/help_dialog.dart';
import './dialogs/reset_warning_dialog.dart';
import './dialogs/share_results_dialog.dart';
import './screens/landing_screen.dart';

class Root extends StatefulWidget {
    final String resultsId;

    const Root({
        required this.resultsId,
        Key? key
    }) : super(key: key);

    @override
    RootState createState() => RootState();
}

class RootState extends State<Root> with SingleTickerProviderStateMixin {
    Quiz quiz = Quiz('assets/quiz_questions.csv');
    bool ready = false;
    bool started = false;
    String resultsId = '';
    Answer? selectedAnswer;
    DocumentReference? savedDocument;

    late final AnimationController loadingAnimation = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this
    )..repeat();

    void initQuiz() {
        quiz.setupQuestions().then((_) {
            if (resultsId.isNotEmpty) {
                setUrlToResultsPage(resultsId);
                quiz.lookupResults(resultsId).then((document) {
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

    @override
    void initState() {
        resultsId = widget.resultsId;

        precacheImage(const AssetImage('assets/images/logo.png'), context);
        precacheImage(const AssetImage('assets/images/github.png'), context);
        precacheImage(const AssetImage('assets/images/intro.png'), context);
        precacheImage(const AssetImage('assets/images/question.png'), context);
        precacheImage(const AssetImage('assets/images/share.png'), context);
        precacheImage(const AssetImage('assets/images/success.png'), context);

        super.initState();
        initQuiz();
    }

    void resetState() {
        setState(() {
            quiz = Quiz(quiz.src);
            ready = false;
            started = false;
            resultsId = '';
            selectedAnswer = null;
            savedDocument = null;
        });
        resetUrl();
        initQuiz();
    }

    void handleReset(BuildContext context) {
        if (started && savedDocument == null) {
            showDialog(
                context: context,
                builder: buildResetWarningDialog
            ).then((shouldReset) {
                if (shouldReset == true) {
                    resetState();
                }
            });
        } else {
            resetState();
        }
    }

    void handleResetAccept() {
        resetState();
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

    void handleShare(BuildContext context) {
        showDialog(
            context: context,
            builder: buildShareResultsDialog
        );
    }

    void handleShareContinue(DocumentReference document) {
        setState(() {
            savedDocument = document;
        });
    }

    void handleCopyUrl(BuildContext context) {
        final url = getUrlToResultsPage(savedDocument!.id);
        final scaffold = ScaffoldMessenger.of(context);

        Clipboard.setData(ClipboardData(text: url));
        scaffold.showSnackBar(buildCopySuccessSnackbar(context) as SnackBar);
    }

    void handleHelp(BuildContext context) {
        showDialog(
            context: context,
            builder: buildHelpDialog
        );
    }

    Widget buildResetWarningDialog(BuildContext context) {
        return ResetWarningDialog(
            quiz: quiz,
            onAccept: handleResetAccept
        );
    }

    Widget buildShareResultsDialog(BuildContext context) {
        return ShareResultsDialog(
            quiz: quiz,
            onContinue: handleShareContinue,
            onCopy: handleCopyUrl
        );
    }

    Widget buildHelpDialog(BuildContext context) {
        return HelpDialog(
            quiz: quiz
        );
    }

    Widget buildCopySuccessSnackbar(BuildContext context) {
        return SnackBar(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 24
            ),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                    Text(
                        'RESULTS URL COPIED',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 17
                        ),
                    ),
                ],
            )
        );
    }

    Widget buildLayout(BuildContext context) {
        if (!started) {
            return LandingScreen(
                quiz: quiz,
                ready: ready,
                started: started,
                results: savedDocument,
                onStart: handleStart,
                onReset: handleReset,
                loadingAnimation: loadingAnimation
            );
        } else if (!quiz.isComplete) {
            return QuestionScreen(
                quiz: quiz,
                ready: ready,
                started: started,
                onStart: handleStart,
                onReset: handleReset,
                onAnswerSelect: handleAnswerSelect,
                onAnswerSubmit: handleAnswerSubmit,
                selectedAnswer: selectedAnswer
            );
        } else {
            return ResultsScreen(
                quiz: quiz,
                ready: ready,
                started: started,
                results: savedDocument,
                onStart: handleStart,
                onReset: handleReset,
                onShare: handleShare,
                onHelp: handleHelp,
                onCopy: handleCopyUrl
            );
        }
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Liberty Compass',
            themeMode: ThemeMode.dark,
            theme: ThemeData(
                primarySwatch: Colors.amber,
                canvasColor: Colors.transparent
            ),
            home: Builder(
                builder: buildLayout
            )
        );
    }
}
