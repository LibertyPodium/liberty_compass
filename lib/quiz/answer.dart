import 'package:liberty_compass/quiz/score.dart';

class Answer {
  final int index;
  final Score score;

  String _inferAnswerContent() {
    switch (index) {
      case 1: return 'Strongly Disagree';
      case 2: return 'Disagree';
      case 3: return 'Slightly Disagree';
      case 4: return 'No Opinion';
      case 5: return 'Slightly Agree';
      case 6: return 'Agree';
      case 7: return 'Strongly Agree';
      default: return '';
    }
  }

  String get content => _inferAnswerContent();

  Answer(this.index, this.score);

  Map<String, dynamic> toMap() {
    return {
      "index": index,
      "content": content,
      "score": score.toMap()
    };
  }
}
