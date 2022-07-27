import 'package:flutter/material.dart';

import '../../quiz/quiz.dart';
import '../../quiz/sentiment.dart';
import '../layout/listing.dart';
import '../layout/section.dart';

class RightToBearArms extends StatelessWidget {
    final Quiz quiz;

    const RightToBearArms({
        required this.quiz,
        Key? key
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        String descriptionWithSentiment = '';

        if (quiz.sentiment.rightToBearArms == 0) {
            descriptionWithSentiment = 'You are neutral towards the the right to bear arms. You believe that government should be allowed to restrict certain types of weapons.';
        } else if (quiz.sentiment.rightToBearArms < 0) {
            descriptionWithSentiment = 'You are generally disagreeable towards the right to bear arms. You believe that government should keep its citizens safe so they don\'t require weapons of their own.';
        } else {
            descriptionWithSentiment = 'You are generally favorable towards the right to bear arms. You believe in your right to defend yourself and your family against violence and tyranny.';
        }

        return Section(
            icon: 'assets/images/gun.png',
            title: 'Right to Bear Arms',
            sentiment: quiz.sentiment.rightToBearArms,
            children: [
                SelectableText(
                    descriptionWithSentiment,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                        height: 1.5
                    )
                ),
                Listing(
                    sentimentQuestions: quiz.sentiment.bearArmsQuestions,
                    sentimentKind: SentimentKind.rightToBearArms
                )
            ]
        );
    }
}