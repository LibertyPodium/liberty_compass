import 'package:flutter/material.dart';

import '../../quiz/quiz.dart';
import '../../quiz/sentiment.dart';
import '../listing.dart';
import '../section.dart';

class NationalSecurity extends StatelessWidget {
    final Quiz quiz;

    const NationalSecurity({
        required this.quiz,
        Key? key
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        String descriptionWithSentiment = '';

        if (quiz.sentiment.nationalSecurity == 0) {
            descriptionWithSentiment = 'You are neutral towards national security. You believe in a balance between liberty and government control.';
        } else if (quiz.sentiment.nationalSecurity < 0) {
            descriptionWithSentiment = 'You are generally disagreeable towards prioritizing security over freedom. You believe that your rights trump those of the government.';
        } else {
            descriptionWithSentiment = 'You are generally favorable towards prioritizing security over freedom. You believe the government has the right to control someone for the good of others.';
        }

        return Section(
            icon: 'assets/images/security.png',
            title: 'National Security',
            sentiment: quiz.sentiment.nationalSecurity,
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
                    sentimentQuestions: quiz.sentiment.natlSecQuestions,
                    sentimentKind: SentimentKind.nationalSecurity
                )
            ]
        );
    }
}