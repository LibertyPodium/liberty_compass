import 'package:liberty_compass/question.dart';

enum QuizVariable {
  conservative,
  progressive,
  libertarian
}

typedef QuizScore = Map<QuizVariable, int>;

class Quiz {
  final List<Question> questions;
  final QuizScore score = {
    QuizVariable.conservative: 0,
    QuizVariable.progressive: 0,
    QuizVariable.libertarian: 0
  };

  double _getAuthoritarianScore() {
    final conservative = score[QuizVariable.conservative]!;
    final libertarian = score[QuizVariable.libertarian]!;
    final progressive = score[QuizVariable.progressive]!;
    final authoritarian = conservative + progressive;
    final total = authoritarian + libertarian;
    final max = questions.length * 2;

    if (libertarian == max) {
      return 0.0;
    }

    if (conservative == max || progressive == max) {
      return 1.0;
    }

    return ((total / 3) + (authoritarian * 0.9) - libertarian) / total;
  }

  double get authoritarianScore => _getAuthoritarianScore();

  Quiz(this.questions);
}

