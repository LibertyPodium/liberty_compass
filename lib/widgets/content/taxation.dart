import 'package:flutter/material.dart';

import '../../quiz/quiz.dart';
import '../../quiz/sentiment.dart';
import '../layout/listing.dart';
import '../layout/section.dart';

class Taxation extends StatelessWidget {
    final Quiz quiz;

    const Taxation({
        required this.quiz,
        Key? key
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        String descriptionWithSentiment = '';

        if (quiz.sentiment.taxes == 0) {
            descriptionWithSentiment = 'You are neutral towards taxation. You believe in a balance between individualism and collective responsibility.';
        } else if (quiz.sentiment.taxes < 0) {
            descriptionWithSentiment = 'You are generally disagreeable towards taxation. You believe that taxation is non-consensual and is therefore theft.';
        } else {
            descriptionWithSentiment = 'You are generally favorable towards taxation. You believe that everyone is financially responsible for the good of the collective.';
        }

        return Section(
            icon: 'assets/images/taxes.png',
            title: 'Taxation',
            sentiment: quiz.sentiment.taxes,
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
                    sentimentQuestions: quiz.sentiment.taxationQuestions,
                    sentimentKind: SentimentKind.taxation
                )
            ]
        );
    }
}
