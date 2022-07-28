import 'package:flutter/material.dart';

import '../../quiz/question.dart';
import '../../quiz/sentiment.dart';

class Listing extends StatelessWidget {
    final List<Question> sentimentQuestions;
    final SentimentKind sentimentKind;

    const Listing({
        required this.sentimentQuestions,
        required this.sentimentKind,
        Key? key,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        final agreedQuestions = sentimentQuestions.where((question) => question.markedAnswer!.index > 4).toList(growable: false);
        final disagreedQuestions = sentimentQuestions.where((question) => question.markedAnswer!.index < 4).toList(growable: false);

        return Column(
            children: [
                SizedBox(height: sentimentQuestions.isNotEmpty ? 8 : 0),
                ...agreedQuestions.map((question) => Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Icon(
                                question.sentiment.get(sentimentKind) < 0 ? Icons.remove : Icons.add,
                                color: Colors.white.withOpacity(0.33),
                                size: 20,
                            ),
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
                            Icon(
                                question.sentiment.get(sentimentKind) > 0 ? Icons.remove : Icons.add,
                                color: Colors.white.withOpacity(0.33),
                                size: 20,
                            ),
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
                )),
            ],
        );
    }
}
