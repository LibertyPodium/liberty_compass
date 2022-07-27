import 'package:flutter/material.dart';

import '../../quiz/quiz.dart';
import '../../quiz/sentiment.dart';
import '../layout/listing.dart';
import '../layout/section.dart';

class ParentalRights extends StatelessWidget {
    final Quiz quiz;

    const ParentalRights({
        required this.quiz,
        Key? key
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        String descriptionWithSentiment = '';

        if (quiz.sentiment.parentalRights == 0) {
            descriptionWithSentiment = 'You are neutral towards parental rights. You believe in a balance between parents and their communities.';
        } else if (quiz.sentiment.parentalRights < 0) {
            descriptionWithSentiment = 'You are generally disagreeable towards parental rights. You believe that the child\'s community should decide what is best.';
        } else {
            descriptionWithSentiment = 'You are generally favorable towards parental rights. You believe in allowing parents to raise their children how they see fit.';
        }

        return Section(
            icon: 'assets/images/parent.png',
            title: 'Parental Rights',
            sentiment: quiz.sentiment.parentalRights,
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
                    sentimentQuestions: quiz.sentiment.parentRightsQuestions,
                    sentimentKind: SentimentKind.parentalRights
                )
            ]
        );
    }
}