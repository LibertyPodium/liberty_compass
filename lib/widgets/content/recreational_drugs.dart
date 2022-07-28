import 'package:flutter/material.dart';

import '../../quiz/quiz.dart';
import '../../quiz/sentiment.dart';
import '../layout/listing.dart';
import '../layout/section.dart';

class RecreationalDrugs extends StatelessWidget {
    final Quiz quiz;

    const RecreationalDrugs({
        required this.quiz,
        Key? key
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        String descriptionWithSentiment = '';

        if (quiz.sentiment.drugLegalization == 0) {
            descriptionWithSentiment = 'You are neutral towards the use of recreational drugs. You believe in a balance between personal responsibility and public safety.';
        } else if (quiz.sentiment.drugLegalization < 0) {
            descriptionWithSentiment = 'You are generally disagreeable towards the use of recreational drugs. You believe that drugs are a mostly negative impact on public safety.';
        } else {
            descriptionWithSentiment = 'You are generally favorable towards the use of recreational drugs. You believe that personal responsibility and individual freedom trump public concern.';
        }

        return Section(
            icon: 'assets/images/drugs.png',
            title: 'Recreational Drugs',
            sentiment: quiz.sentiment.drugLegalization,
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
                    sentimentQuestions: quiz.sentiment.drugLawQuestions,
                    sentimentKind: SentimentKind.recreationalDrugs
                )
            ]
        );
    }
}