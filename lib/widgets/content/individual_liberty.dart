import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:liberty_compass/quiz/quiz.dart';

import '../section.dart';

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
            descriptionWithSentiment = 'You are generally disagreeable towards individual freedom. You believe some people should control the actions others.';
        } else {
            descriptionWithSentiment = 'You are generally favorable towards individual freedom. You believe in an individualistic approach to society.';
        }

        final questions = quiz.sentiment.libertyQuestions;
        final agreedQuestions = questions.where((question) => question.markedAnswer!.index > 4).toList(growable: false);
        final disagreedQuestions = questions.where((question) => question.markedAnswer!.index < 4).toList(growable: false);
        final shouldRenderSpacer = agreedQuestions.isNotEmpty || disagreedQuestions.isNotEmpty;

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
                SizedBox(height: shouldRenderSpacer ? 8 : 0),
                ...agreedQuestions.map((question) => Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Icon(question.sentiment.liberty < 0 ? Icons.remove : Icons.add, color: Colors.white.withOpacity(0.33), size: 20,),
                            const SizedBox(width: 8),
                            const Icon(Icons.thumb_up, color: Colors.lightBlue, size: 20,),
                            const SizedBox(width: 8),
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
                ...disagreedQuestions.map((question) => Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Icon(question.sentiment.liberty > 0 ? Icons.remove : Icons.add, color: Colors.white.withOpacity(0.33), size: 20,),
                            const SizedBox(width: 8),
                            Icon(Icons.thumb_down, color: Colors.white.withOpacity(0.66), size: 20,),
                            const SizedBox(width: 8),
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