import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:liberty_compass/quiz/quiz.dart';

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
            descriptionWithSentiment = 'You are neutral towards the use of recreational drugs. You believe in a balance between personal responsibility and public safety.';
        } else if (quiz.sentiment.freeSpeech < 0) {
            descriptionWithSentiment = 'You are generally disagreeable towards prioritizing security over freedom. You believe that your rights trump those of the government.';
        } else {
            descriptionWithSentiment = 'You are generally favorable towards individual freedom. You believe in an individualistic approach to society.';
        }

        final questions = quiz.sentiment.freeSpeechQuestions;
        final positiveQuestions = questions.where((question) => question.markedAnswer!.index > 4).toList(growable: false);
        final negativeQuestions = questions.where((question) => question.markedAnswer!.index < 4).toList(growable: false);
        final shouldRenderSpacer = positiveQuestions.isNotEmpty || negativeQuestions.isNotEmpty;

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
                SizedBox(height: shouldRenderSpacer ? 8 : 0),
                ...positiveQuestions.map((question) => Container(
                    padding: EdgeInsets.only(top: 8),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Icon(Icons.thumb_up, color: Colors.lightBlue, size: 20,),
                            SizedBox(width: 8),
                            Flexible(child: SelectableText(
                                question.content,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 12,
                                    height: 1.33,
                                    overflow: TextOverflow.ellipsis,
                                )
                            ))
                        ]
                    )
                )),
                ...negativeQuestions.map((question) => Container(
                    padding: EdgeInsets.only(top: 8),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Icon(Icons.thumb_down, color: Colors.white.withOpacity(0.66), size: 20,),
                            SizedBox(width: 8),
                            Flexible(child: SelectableText(
                                question.content,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 12,
                                    height: 1.33,
                                    overflow: TextOverflow.ellipsis,
                                )
                            ))
                        ]
                    )
                ))
            ]
        );
    }
}