import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liberty_compass/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  final Quiz quiz;
  final bool started;
  final bool ready;
  final Answer? selectedAnswer;
  final DocumentReference? savedDocument;
  final AnimationController loadingAnimation;
  final void Function() onStart;
  final void Function(BuildContext) onReset;
  final void Function(BuildContext) onShare;
  final void Function(BuildContext) onHelp;
  final void Function(BuildContext) onCopy;
  final void Function(Answer) onAnswerSelect;
  final void Function(Answer) onAnswerSubmit;

  const Layout({
      required this.quiz,
      required this.started,
      required this.ready,
      required this.selectedAnswer,
      required this.savedDocument,
      required this.loadingAnimation,
      required this.onReset,
      required this.onStart,
      required this.onShare,
      required this.onHelp,
      required this.onCopy,
      required this.onAnswerSubmit,
      required this.onAnswerSelect,
      Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 600;
    final isMini = mediaQuery.size.width < 300;

    if (!ready) {
        return Container(
            color: Color(0xFF262A35),
            width: double.infinity,
            height: double.infinity,
            child: Center(
                child: AnimatedBuilder(
                    animation: loadingAnimation,
                    builder: (_, child) {
                        return Transform.rotate(
                            origin: const Offset(0, -15),
                            angle: loadingAnimation.value * math.pi * 2,
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
                quiz: quiz,
                ready: ready,
                started: started,
                results: savedDocument,
                onStart: onStart,
                onReset: onReset,
            ),
            titleSpacing: 0,
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
      final sectionGap = isMobile ? 48.0 : 64.0;

      return Scaffold(
        appBar: AppBar(
          title: Header(
            quiz: quiz,
            ready: ready,
            started: started,
            results: savedDocument,
            onStart: onStart,
            onReset: onReset,
          ),
          titleSpacing: 0,
          shadowColor: Colors.transparent,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => onHelp(context),
          backgroundColor: const Color(0xFFAD65FF),
          elevation: 0,
          child: const Icon(
              Icons.question_mark,
              color: Colors.black,
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
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => onCopy(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isMini ? 'RESULTS' : 'VIEWING RESULTS',
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
                            Text(
                              savedDocument?.id ?? 'unknown',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                        SizedBox(height: sectionGap),
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
                                      onPressed: () => onReset(context),
                                      child: Text(
                                          savedDocument == null ? 'RETAKE QUIZ' : 'TAKE QUIZ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          )
                                      ),
                                      style: ButtonStyle(
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
                              )
                            ]
                        ),
                        savedDocument == null ? SizedBox(height: 20) : Container(),
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
                        SizedBox(height: 48),
                        Center(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                launchUrlString('https://github.com/fyrware/liberty_compass');
                              },
                              child: Image(
                                image: AssetImage('assets/images/github.png'),
                                height: 40,
                                filterQuality: FilterQuality.medium,
                              ),
                            ),
                          ),
                        )
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
          quiz: quiz,
          ready: ready,
          started: started,
          results: savedDocument,
          onStart: onStart,
          onReset: onReset,
        ),
        titleSpacing: 0,
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
                child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: isMobile ? 32 :  48
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            quiz.currentQuestion!.content,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 24),
                          ...quiz.currentQuestion!.answers.map((answer) => Material(
                              color: Colors.transparent,
                              child: ListTile(
                                visualDensity: VisualDensity.compact,
                                tileColor: answer == selectedAnswer ? Colors.white.withOpacity(0.25) : Colors.transparent,
                                hoverColor: answer == selectedAnswer ? Colors.transparent : Colors.white.withOpacity(0.1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
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
                                  maxWidth: isMobile ? double.infinity : 320,
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
                                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.disabled)) {
                                        return Colors.black.withOpacity(0.66);
                                      }
                                      return Colors.black;
                                    }),
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
                          SizedBox(height: isMobile ? 32 : 48),
                          Container(
                            width: double.infinity,
                            height: isMobile ? 200 : 300,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/question.png'),
                                    filterQuality: FilterQuality.medium,
                                    fit: BoxFit.contain,
                                    // alignment: Alignment.bottomCenter
                                )
                            ),
                          )
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