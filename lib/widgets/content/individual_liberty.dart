import 'package:flutter/material.dart';

import '../../quiz/quiz.dart';
import '../../quiz/sentiment.dart';
import '../layout/listing.dart';
import '../layout/section.dart';

class IndividualLiberty extends StatelessWidget {
  final Quiz quiz;

    const IndividualLiberty({
        required this.quiz,
        Key? key
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        String descriptionWithSentiment = '';

        if (quiz.sentiment.liberty == 0) {
            descriptionWithSentiment = 'You are neutral towards individual freedom. You believe in a balance between liberty and government control.';
        } else if (quiz.sentiment.liberty < 0) {
            descriptionWithSentiment = 'You are generally disagreeable towards individual freedom. You believe some people should control the actions of others.';
        } else {
            descriptionWithSentiment = 'You are generally favorable towards individual freedom. You believe in an individualistic and free approach to society.';
        }

        return Section(
            icon: 'assets/images/torch.png',
            title: 'Individual Freedom',
            sentiment: quiz.sentiment.liberty,
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
                    sentimentKind: SentimentKind.individualFreedom,
                    sentimentQuestions: quiz.sentiment.libertyQuestions,
                ),
            ]
        );
    }
}