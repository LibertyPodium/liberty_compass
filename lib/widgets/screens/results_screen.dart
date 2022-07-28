import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liberty_compass/quiz/quiz.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../content/freedom_of_religion.dart';
import '../content/freedom_of_speech.dart';
import '../content/graph.dart';
import '../content/immigration.dart';
import '../content/individual_liberty.dart';
import '../content/mandatory_medicine.dart';
import '../content/national_security.dart';
import '../content/parental_rights.dart';
import '../content/recreational_drugs.dart';
import '../content/right_to_bear_arms.dart';
import '../content/taxation.dart';
import '../layout/header.dart';

final GlobalKey genKey = GlobalKey();

class ResultsScreen extends StatelessWidget {
  final Quiz quiz;
  final bool ready;
  final bool started;
  final DocumentReference? results;
  final Function() onStart;
  final Function(BuildContext) onReset;
  final void Function(BuildContext) onShare;
  final void Function(BuildContext) onHelp;
  final void Function(BuildContext) onCopy;

  const ResultsScreen({
    Key? key,
    this.results,
    required this.quiz,
    required this.ready,
    required this.started,
    required this.onStart,
    required this.onReset,
    required this.onShare,
    required this.onHelp,
    required this.onCopy
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 600;
    final isMini = mediaQuery.size.width < 300;
    final sectionGap = isMobile ? 48.0 : 64.0;

    return Scaffold(
        appBar: AppBar(
          title: Header(
            quiz: quiz,
            ready: ready,
            started: started,
            results: results,
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
                    results != null ? Container(
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
                                    results?.id ?? 'unknown',
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
                                  results == null ? Flex(
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
                                  SizedBox(height: results == null ? sectionGap * 0.66 : 0),
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
                                                    results == null ? 'RETAKE QUIZ' : 'TAKE QUIZ',
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
                                  results == null ? SizedBox(height: 20) : Container(),
                                  results == null ? Flex(
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
}