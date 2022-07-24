import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liberty_compass/quiz/quiz.dart';

class Header extends StatelessWidget {
    final bool ready;
    final bool started;
    final Quiz quiz;
    final DocumentReference? results;

    const Header({
        required this.ready,
        required this.started,
        required this.quiz,
        required this.results,
        Key? key,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        final headerDecorations = !started
            ? [
                const Icon(
                    Icons.not_started_outlined,
                    color: Colors.black,
                    size: 24
                )
            ]
            : quiz.currentQuestion == null
                ? [
                    const Icon(
                        Icons.restart_alt,
                        color: Colors.black,
                        size: 24
                    )
                ]
                : [
                    Text(
                        'Question ${quiz.currentPlace + 1}/${quiz.questions.length}',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                        ),
                    ),
                ];

        return SizedBox(
            width: double.infinity,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    const Image(
                        image: AssetImage('assets/images/logo.png'),
                        height: 40,
                        filterQuality: FilterQuality.medium,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                        'LIBERTY COMPASS',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                        )
                    ),
                    Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: headerDecorations
                        )
                    )
                ]
            )
        );
    }
}