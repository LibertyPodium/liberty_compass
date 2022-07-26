import 'package:flutter/material.dart';

import '../../quiz/quiz.dart';
import '../../quiz/sentiment.dart';
import '../listing.dart';
import '../section.dart';

class FreedomOfSpeech extends StatelessWidget {
    final Quiz quiz;

    const FreedomOfSpeech({
        required this.quiz,
        Key? key
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        String descriptionWithSentiment = '';

        if (quiz.sentiment.freeSpeech == 0) {
            descriptionWithSentiment = 'You are neutral towards free speech. You believe that some speech may be dangerous, but other speech may be useful.';
        } else if (quiz.sentiment.freeSpeech < 0) {
            descriptionWithSentiment = 'You are generally disagreeable towards free speech. You believe that the government should regulate harmful or incorrect language.';
        } else {
            descriptionWithSentiment = 'You are generally favorable towards free speech. You believe that your right to free speech trumps the feelings of others.';
        }

        return Section(
            icon: 'assets/images/speech.png',
            title: 'Freedom of Speech',
            sentiment: quiz.sentiment.freeSpeech,
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
                  sentimentQuestions: quiz.sentiment.freeSpeechQuestions,
                  sentimentKind: SentimentKind.freedomOfSpeech
              )
            ]
        );
    }
}