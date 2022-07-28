import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liberty_compass/quiz/quiz.dart';

import '../content/graph.dart';
import '../content/introduction.dart';
import '../layout/header.dart';

class LandingScreen extends StatelessWidget {
    final Quiz quiz;
    final bool ready;
    final bool started;
    final DocumentReference? results;
    final Function() onStart;
    final Function(BuildContext) onReset;
    final AnimationController loadingAnimation;

    const LandingScreen({
        Key? key,
        this.results,
        required this.quiz,
        required this.ready,
        required this.started,
        required this.onStart,
        required this.onReset,
        required this.loadingAnimation
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        if (!ready) {
            return Container(
                color: const Color(0xFF262A35),
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
                color: const Color(0xFF262A35),
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                    child: Column(
                        children: [
                          ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 640,
                              ),
                              child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(32),
                                  child: Introduction(onStart: onStart)
                              )
                          ),
                        ]
                    ),
                )
            )
        );
    }
}
