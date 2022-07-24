import 'package:liberty_compass/quiz/answer.dart';
import 'package:liberty_compass/quiz/sentiment.dart';

class Question {
  final int originalIndex;
  final String content;
  final List<Answer> answers;
  final Sentiment sentiment;

  Answer? markedAnswer;

  Question(this.originalIndex, this.content, this.answers, this.sentiment);

  Map<String, dynamic> toMap() {
    return {
      "originalIndex": originalIndex,
      "content": content,
      "sentiment": sentiment.toMap(),
      "answers": answers.map((answer) => answer.toMap())
    };
  }

  void markAnswer(Answer answer) {
    markedAnswer = answer;
  }
}