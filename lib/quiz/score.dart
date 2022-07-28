import 'dart:math';

import 'package:liberty_compass/quiz/quiz.dart';

const String conservativeLabel = 'Conservative';
const String libertarianLabel = 'Libertarian';
const String progressiveLabel = 'Progressive';

const double socialNormMultiplier = 0.9;

class Score {
  final Quiz? quiz;

  double conservative;
  double libertarian;
  double progressive;

  double _inferAuthoritarianScore() {
    final maxPossible = (quiz?.questions.length ?? 1) * 2;

    if (libertarian == maxPossible) {
      return 0.0;
    }

    if (conservative == maxPossible || progressive == maxPossible) {
      return 1.0;
    }

    final authoritarian = conservative + progressive;
    final total = authoritarian + libertarian;
    final startingPoint = total / 3;
    final authoritarianWithinSocialNorms = authoritarian * socialNormMultiplier;
    final inferredAuthoritarian = startingPoint + authoritarianWithinSocialNorms - libertarian;

    return max(min(inferredAuthoritarian / total, 1.0), 0.0);
  }

  double get authoritarian => _inferAuthoritarianScore();

  Score(this.quiz, {
    this.conservative = 0.0,
    this.libertarian = 0.0,
    this.progressive = 0.0
  });

  Map<String, dynamic> toMap() {
    return {
      "conservative": conservative,
      "libertarian": libertarian,
      "progressive": progressive
    };
  }

  static Score parseString(String scoreText) {
    var conservative = 0.0;
    var libertarian = 0.0;
    var progressive = 0.0;

    List<String> scoreTextSplit = scoreText.split(RegExp(r",(?:\s+)?"));

    for (int i = 0; i < scoreTextSplit.length; ++i) {
      List<String> scoreEntrySplit = scoreTextSplit[i].split(RegExp(r"(?:\s+)?\+"));

      switch (scoreEntrySplit[0]) {
        case conservativeLabel: conservative = double.parse(scoreEntrySplit[1]); break;
        case libertarianLabel: libertarian = double.parse(scoreEntrySplit[1]); break;
        case progressiveLabel: progressive = double.parse(scoreEntrySplit[1]); break;
      }
    }

    return Score(
      null,
      conservative: conservative,
      libertarian: libertarian,
      progressive: progressive
    );
  }
}