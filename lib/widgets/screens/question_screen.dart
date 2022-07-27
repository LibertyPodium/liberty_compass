import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liberty_compass/quiz/quiz.dart';

import '../../quiz/answer.dart';
import '../content/graph.dart';
import '../content/introduction.dart';
import '../layout/header.dart';

class QuestionScreen extends StatelessWidget {
  final Quiz quiz;
  final bool ready;
  final bool started;
  final DocumentReference? results;
  final Function() onStart;
  final Function(BuildContext) onReset;
  final void Function(Answer) onAnswerSelect;
  final void Function(Answer) onAnswerSubmit;
  final Answer? selectedAnswer;

  const QuestionScreen({
    Key? key,
    this.results,
    required this.quiz,
    required this.ready,
    required this.started,
    required this.onStart,
    required this.onReset,
    required this.onAnswerSelect,
    required this.onAnswerSubmit,
    required this.selectedAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final mediaQuery = MediaQuery.of(context);
      final isMobile = mediaQuery.size.width < 600;

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
          body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  color: Color(0xFF262A35),
              ),
              child: Flex(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  direction: Axis.horizontal,
                  children: [
                      Flexible(
                          child: Container(
                              constraints: const BoxConstraints(
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
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      height: 1.5,
                                                      fontWeight: FontWeight.w500,
                                                  ),
                                              ),
                                              const SizedBox(height: 24),
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
                                                          style: ButtonStyle(
                                                              minimumSize: MaterialStateProperty.all(const Size(double.infinity, 54)),
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
                                                          child: const Text(
                                                              'NEXT QUESTION',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w300,
                                                              )
                                                          ),
                                                      )
                                                  ),
                                              ),
                                              SizedBox(height: isMobile ? 32 : 48),
                                              Container(
                                                  width: double.infinity,
                                                  height: isMobile ? 200 : 300,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage('assets/images/question.png'),
                                                          filterQuality: FilterQuality.medium,
                                                          fit: BoxFit.contain,
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