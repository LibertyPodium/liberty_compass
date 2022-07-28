import 'package:flutter/material.dart';

import '../../quiz/quiz.dart';
import '../../quiz/sentiment.dart';
import '../layout/listing.dart';
import '../layout/section.dart';

class FreedomOfReligion extends StatelessWidget {
    final Quiz quiz;

    const FreedomOfReligion({
        required this.quiz,
        Key? key
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        String descriptionWithSentiment;

        if (quiz.sentiment.freedomOfReligion == 0) {
            descriptionWithSentiment = 'You are neutral towards religious freedom. You believe that certain belief systems may be harmful to society.';
        } else if (quiz.sentiment.freedomOfReligion < 0) {
            descriptionWithSentiment = 'You are generally disagreeable towards religious freedom. You believe that religion is a mostly negative impact on society.';
        } else {
            descriptionWithSentiment = 'You are generally favorable towards religious freedom. You believe in allowing others to think for themselves.';
        }

        return Section(
            icon: 'assets/images/religion.png',
            title: 'Freedom of Religion',
            sentiment: quiz.sentiment.freedomOfReligion,
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
                    sentimentQuestions: quiz.sentiment.religionQuestions,
                    sentimentKind: SentimentKind.freedomOfReligion
                )
            ]
        );
    }
}
