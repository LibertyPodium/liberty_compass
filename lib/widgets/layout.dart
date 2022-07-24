import 'dart:html' as html;
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../quiz/answer.dart';
import '../quiz/quiz.dart';
import './content/freedom_of_religion.dart';
import './content/immigration.dart';
import './content/mandatory_medicine.dart';
import './content/parental_rights.dart';
import './content/right_to_bear_arms.dart';
import './content/taxation.dart';
import './content/introduction.dart';
import './content/graph.dart';
import './content/freedom_of_speech.dart';
import './content/individual_liberty.dart';
import './content/national_security.dart';
import './content/recreational_drugs.dart';
import './header.dart';

final GlobalKey genKey = GlobalKey();

class Layout extends StatelessWidget {
  final AnimationController loadingAnimationController;
  final Quiz quiz;
  final bool started;
  final bool ready;
  final bool saving;
  final void Function() onStart;
  final void Function(Answer) onAnswerSelect;
  final void Function(Answer) onAnswerSubmit;
  final void Function(BuildContext) onShare;
  final Answer? selectedAnswer;
  final DocumentReference? savedDocument;

  const Layout({
      required this.loadingAnimationController,
      required this.quiz,
      required this.started,
      required this.ready,
      required this.saving,
      required this.onStart,
      required this.onAnswerSubmit,
      required this.onAnswerSelect,
      required this.onShare,
      required this.selectedAnswer,
      required this.savedDocument,
      Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 600;

    if (!ready) {
        return Container(
            color: Color(0xFF262A35),
            width: double.infinity,
            height: double.infinity,
            child: Center(
                child: AnimatedBuilder(
                    animation: loadingAnimationController,
                    builder: (_, child) {
                        return Transform.rotate(
                            origin: const Offset(0, -15),
                            angle: loadingAnimationController.value * math.pi * 2,
                            child: child
                        );
                    },
                    child: Graph(quiz: Quiz('')),
                )
            )
        );
    }

    if (!started) {
      return Scaffold(
        appBar: AppBar(
            title: Header(
                ready: ready,
                started: started,
                quiz: quiz,
                results: savedDocument
            ),
            shadowColor: Colors.transparent,
        ),
        body: Container(
          color: Color(0xFF262A35),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 640,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(32),
                    child: Introduction(onStart: onStart)
                  )
                ),
              ]
            ),
          )
        )
      );
    }

    if (quiz.currentQuestion == null) {
      final sectionGap = isMobile ? 48.0 : 72.0;

      return Scaffold(
        appBar: AppBar(
          title: Header(
            ready: ready,
            started: started,
            quiz: quiz,
            results: savedDocument
          ),
          shadowColor: Colors.transparent,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFFAD65FF),
          elevation: 0,
          child: const Icon(
              Icons.question_mark,
              color: Color(0xFF262A35),
          )
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFF262A35),
          child: SingleChildScrollView(
            child: Column(
              children: [
                savedDocument != null ? Container(
                  height: 56,
                  decoration: BoxDecoration(
                      color: Colors.black
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SelectableText(
                          'VIEWING RESULTS',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: Colors.white,
                          size: 20
                        ),
                        SizedBox(width: 2),
                        SelectableText(
                          savedDocument?.id ?? 'unknown',
                          style: TextStyle(
                              color: Colors.green,// Color(0xFFAD65FF),
                              fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ),
                ) : Container(),
                Container(
                  child: Container(
                    padding: EdgeInsets.all(isMobile ? 16 : 32),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: sectionGap / 2),
                        Center(
                          child: Container(
                            padding: EdgeInsets.only(left: isMobile ? 16 : 64),
                            child: RepaintBoundary(
                                key: genKey,
                                child: Graph(quiz: quiz)
                            ),
                          )
                        ),
                        SizedBox(height: sectionGap * 0.75),
                        savedDocument == null ? Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: 320,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () => onShare(context),
                                      child: const Text(
                                          'SHARE RESULTS',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          )
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.black),
                                          foregroundColor: MaterialStateProperty.all(Colors.white),
                                          minimumSize: MaterialStateProperty.all(Size(double.infinity, 54)),
                                          shadowColor: MaterialStateProperty.all(Colors.transparent),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(100)
                                              )
                                          )
                                      ),
                                    )
                                ),
                              ),
                            ]
                        ) : Container(),
                        SizedBox(height: savedDocument == null ? sectionGap * 0.66 : 0),
                        IndividualLiberty(quiz: quiz),
                        SizedBox(height: sectionGap),
                        NationalSecurity(quiz: quiz),
                        SizedBox(height: sectionGap),
                        RightToBearArms(quiz: quiz),
                        SizedBox(height: sectionGap),
                        Immigration(quiz: quiz),
                        SizedBox(height: sectionGap),
                        ParentalRights(quiz: quiz),
                        SizedBox(height: sectionGap),
                        FreedomOfSpeech(quiz: quiz),
                        SizedBox(height: sectionGap),
                        FreedomOfReligion(quiz: quiz),
                        SizedBox(height: sectionGap),
                        Taxation(quiz: quiz),
                        SizedBox(height: sectionGap),
                        RecreationalDrugs(quiz: quiz),
                        SizedBox(height: sectionGap),
                        MandatoryMedicine(quiz: quiz),
                        SizedBox(height: sectionGap * 0.75),
                        Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 320,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () => onShare(context),
                                    child: const Text(
                                        'SHARE RESULTS',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                        )
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.black),
                                        foregroundColor: MaterialStateProperty.all(Colors.white),
                                        minimumSize: MaterialStateProperty.all(Size(double.infinity, 54)),
                                        shadowColor: MaterialStateProperty.all(Colors.transparent),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(100)
                                            )
                                        )
                                    ),
                                  )
                              ),
                            ),
                          ]
                        ),
                        SizedBox(height: sectionGap),
                      ]
                    )
                  )
                ),
              ],
            )
          )
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Header(
            ready: ready,
            started: started,
            quiz: quiz,
            results: savedDocument
        ),
        shadowColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xFF262A35),
        ),
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.horizontal,
          children: [
            Flexible(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 640,
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/question.png'),
                        filterQuality: FilterQuality.medium,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter
                    )
                ),
                child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            quiz.currentQuestion!.content,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 24),
                          ...quiz.currentQuestion!.answers.map((answer) => Material(
                              color: Colors.transparent,
                              child: ListTile(
                                visualDensity: VisualDensity.compact,
                                tileColor: Colors.transparent,
                                hoverColor: Colors.white.withOpacity(0.166),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                title: Text(
                                    answer.content,
                                    style: TextStyle(
                                      color: answer == selectedAnswer ? Colors.white : Colors.white.withOpacity(0.9),
                                      fontWeight: answer == selectedAnswer ? FontWeight.w500 : FontWeight.w300,
                                    )
                                ),
                                leading: Radio(
                                  value: answer,
                                  groupValue: selectedAnswer,
                                  onChanged: (void value) => onAnswerSelect(answer),
                                  fillColor: answer == selectedAnswer
                                      ? MaterialStateProperty.all(Colors.amber)
                                      : MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.5)),
                                  overlayColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.166)),
                                ),
                                onTap: () => onAnswerSelect(answer),
                              )
                          )),
                          const SizedBox(height: 32),
                          Center(
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 320,
                                ),
                                child: ElevatedButton(
                                  onPressed: selectedAnswer != null ? () => onAnswerSubmit(selectedAnswer!) : null,
                                  child: const Text(
                                      'NEXT QUESTION',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(Size(double.infinity, 54)),
                                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.disabled)) {
                                        return Colors.white.withOpacity(0.25);
                                      }
                                      return Colors.amber;
                                    }),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100)
                                        )
                                    )
                                  ),
                                )
                            ),
                          ),
                          SizedBox(height: isMobile ? 280 : 400),
                        ],
                      ),
                    )
                ),
              )
            )
          ]
        )
      )
    );
  }
}