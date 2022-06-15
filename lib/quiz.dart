import 'dart:math';

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
    final maxPossible = questions.length * 2;

    if (libertarian == maxPossible) {
      return 0.0;
    }

    if (conservative == maxPossible || progressive == maxPossible) {
      return 1.0;
    }

    return max(min(((total / 3) + (authoritarian * 0.9) - libertarian) / total, 1.0), 0.0);
  }

  double get authoritarianScore => _getAuthoritarianScore();

  Quiz(this.questions);
}

