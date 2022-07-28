import 'package:flutter/material.dart';

import '../../quiz/quiz.dart';
import '../../quiz/sentiment.dart';
import '../layout/listing.dart';
import '../layout/section.dart';

class MandatoryMedicine extends StatelessWidget {
    final Quiz quiz;

    const MandatoryMedicine({
        required this.quiz,
        Key? key
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        String descriptionWithSentiment = '';

        if (quiz.sentiment.mandatoryMedicine == 0) {
            descriptionWithSentiment = 'You are neutral towards the enforcement of medical treatments. You believe that sometimes you should take a risk on behalf of the collective.';
        } else if (quiz.sentiment.mandatoryMedicine < 0) {
            descriptionWithSentiment = 'You are generally disagreeable towards the enforcement of medical treatments. You believe that your bodily autonomy and ability to think freely trump public concern.';
        } else {
            descriptionWithSentiment = 'You are generally favorable towards the enforcement of medical treatments. You believe that government agencies have the right to control citizens\' bodies.';
        }

        return Section(
            icon: 'assets/images/vaccine.png',
            title: 'Mandatory Medicine',
            sentiment: quiz.sentiment.mandatoryMedicine,
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
                    sentimentQuestions: quiz.sentiment.medicineQuestions,
                    sentimentKind: SentimentKind.mandatoryMedicine
                )
            ]
        );
    }
}