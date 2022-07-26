import 'package:flutter/material.dart';

import '../../quiz/quiz.dart';
import '../../quiz/sentiment.dart';
import '../listing.dart';
import '../section.dart';

class Immigration extends StatelessWidget {
    final Quiz quiz;

    const Immigration({
        required this.quiz,
        Key? key
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        String descriptionWithSentiment = '';

        if (quiz.sentiment.immigration == 0) {
            descriptionWithSentiment = 'You are neutral towards immigration. You believe in a balance between legal immigration and national security.';
        } else if (quiz.sentiment.immigration < 0) {
            descriptionWithSentiment = 'You are generally disagreeable towards immigration. You believe that government should prioritize its citizens.';
        } else {
            descriptionWithSentiment = 'You are generally favorable towards immigration. You believe that people should be allowed toi live where they feel most free.';
        }

        return Section(
            icon: 'assets/images/passport.png',
            title: 'Immigration',
            sentiment: quiz.sentiment.immigration,
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
                    sentimentQuestions: quiz.sentiment.immigrationQuestions,
                    sentimentKind: SentimentKind.immigration
                )
            ]
        );
    }
}