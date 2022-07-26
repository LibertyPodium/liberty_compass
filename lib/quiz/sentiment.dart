import 'package:liberty_compass/quiz/question.dart';

enum SentimentKind {
    individualFreedom,
    nationalSecurity,
    rightToBearArms,
    immigration,
    parentalRights,
    freedomOfSpeech,
    freedomOfReligion,
    taxation,
    recreationalDrugs,
    mandatoryMedicine
}

class Sentiment {
  int liberty;
  int nationalSecurity;
  int drugLegalization;
  int freedomOfReligion;
  int rightToBearArms;
  int freeSpeech;
  int parentalRights;
  int taxes;
  int mandatoryMedicine;
  int immigration;

  final List<Question> libertyQuestions = [];
  final List<Question> natlSecQuestions = [];
  final List<Question> drugLawQuestions = [];
  final List<Question> religionQuestions = [];
  final List<Question> bearArmsQuestions = [];
  final List<Question> freeSpeechQuestions = [];
  final List<Question> parentRightsQuestions = [];
  final List<Question> taxationQuestions = [];
  final List<Question> medicineQuestions = [];
  final List<Question> immigrationQuestions = [];

  Sentiment({
    this.liberty = 0,
    this.nationalSecurity = 0,
    this.drugLegalization = 0,
    this.freedomOfReligion = 0,
    this.rightToBearArms = 0,
    this.freeSpeech = 0,
    this.parentalRights = 0,
    this.taxes = 0,
    this.mandatoryMedicine = 0,
    this.immigration = 0
  });

  int get(SentimentKind kind) {
    switch (kind) {
      case SentimentKind.individualFreedom: return liberty;
      case SentimentKind.nationalSecurity: return nationalSecurity;
      case SentimentKind.rightToBearArms: return rightToBearArms;
      case SentimentKind.immigration: return immigration;
      case SentimentKind.parentalRights: return parentalRights;
      case SentimentKind.freedomOfSpeech: return freeSpeech;
      case SentimentKind.freedomOfReligion: return freedomOfReligion;
      case SentimentKind.taxation: return taxes;
      case SentimentKind.recreationalDrugs: return drugLegalization;
      case SentimentKind.mandatoryMedicine: return mandatoryMedicine;
    }
  }

  Map<String, dynamic> toMap() {
      return {
        "liberty": liberty,
        "libertyQuestionIndexes": libertyQuestions.map((question) => {
          "questionIndex": question.originalIndex,
          "answerIndex": question.markedAnswer?.index ?? -1
        }),
        "nationalSecurity": nationalSecurity,
        "nationalSecurityQuestionIndexes": natlSecQuestions.map((question) => {
          "questionIndex": question.originalIndex,
          "answerIndex": question.markedAnswer?.index ?? -1
        }),
        "rightToBearArms": rightToBearArms,
        "rightToBearArmsQuestionIndexes": bearArmsQuestions.map((question) => {
          "questionIndex": question.originalIndex,
          "answerIndex": question.markedAnswer?.index ?? -1
        }),
        "immigration": immigration,
        "immigrationQuestionIndexes": immigrationQuestions.map((question) => {
          "questionIndex": question.originalIndex,
          "answerIndex": question.markedAnswer?.index ?? -1
        }),
        "parentalRights": parentalRights,
        "parentalRightsQuestionIndexes": parentRightsQuestions.map((question) => {
          "questionIndex": question.originalIndex,
          "answerIndex": question.markedAnswer?.index ?? -1
        }),
        "freedomOfSpeech": freeSpeech,
        "freedomOfSpeechQuestionIndexes": freeSpeechQuestions.map((question) => {
          "questionIndex": question.originalIndex,
          "answerIndex": question.markedAnswer?.index ?? -1
        }),
        "freedomOfReligion": freedomOfReligion,
        "freedomOfReligionQuestionIndexes": religionQuestions.map((question) => {
          "questionIndex": question.originalIndex,
          "answerIndex": question.markedAnswer?.index ?? -1
        }),
        "taxation": taxes,
        "taxationQuestionIndexes": taxationQuestions.map((question) => {
          "questionIndex": question.originalIndex,
          "answerIndex": question.markedAnswer?.index ?? -1
        }),
        "recreationalDrugs": drugLegalization,
        "recreationalDrugsQuestionIndexes": drugLawQuestions.map((question) => {
          "questionIndex": question.originalIndex,
          "answerIndex": question.markedAnswer?.index ?? -1
        }),
        "mandatoryMedicine": mandatoryMedicine,
        "mandatoryMedicineQuestionIndexes": medicineQuestions.map((question) => {
          "questionIndex": question.originalIndex,
          "answerIndex": question.markedAnswer?.index ?? -1
        }),
      };
  }

  static Sentiment parseString(String sentimentText) {
    final Sentiment sentiment = Sentiment();
    final List<String> sentimentTextSplit = sentimentText.split(RegExp(r",(?:\s+)?"));

    for (int whichSentiment = 0; whichSentiment < sentimentTextSplit.length; ++whichSentiment) {
      final String whichSentimentText = sentimentTextSplit[whichSentiment];
      final List<String> whichSentimentSplit = whichSentimentText.split(RegExp(r"(\s)(?=[+-]$)"));
      final String whichSentimentName = whichSentimentSplit[0];
      final String whichSentimentValue = whichSentimentSplit[1];
      final int whichSentimentScore = whichSentimentValue == '+' ? 1 : -1;

      switch (whichSentimentName) {
        case 'Liberty': sentiment.liberty += whichSentimentScore; break;
        case 'National Security': sentiment.nationalSecurity += whichSentimentScore; break;
        case 'Drug Legalization': sentiment.drugLegalization += whichSentimentScore; break;
        case 'Freedom of Religion': sentiment.freedomOfReligion += whichSentimentScore; break;
        case 'Right to Bear Arms': sentiment.rightToBearArms += whichSentimentScore; break;
        case 'Free Speech': sentiment.freeSpeech += whichSentimentScore; break;
        case 'Parental Rights': sentiment.parentalRights += whichSentimentScore; break;
        case 'Taxes': sentiment.taxes += whichSentimentScore; break;
        case 'Mandatory Medicine': sentiment.mandatoryMedicine += whichSentimentScore; break;
        case 'Immigration': sentiment.immigration += whichSentimentScore; break;
      }
    }

    return sentiment;
  }

  void adoptQuestionSentiment(Question question) {
    if (question.sentiment.liberty != 0) {
      libertyQuestions.add(question);

      if (question.markedAnswer!.index < 4) {
        liberty += question.sentiment.liberty * -1;
      } else if (question.markedAnswer!.index > 4) {
        liberty += question.sentiment.liberty;
      }
    }

    if (question.sentiment.nationalSecurity != 0) {
      natlSecQuestions.add(question);

      if (question.markedAnswer!.index < 4) {
        nationalSecurity += question.sentiment.nationalSecurity * -1;
      } else if (question.markedAnswer!.index > 4) {
        nationalSecurity += question.sentiment.nationalSecurity;
      }
    }

    if (question.sentiment.drugLegalization != 0) {
      drugLawQuestions.add(question);

      if (question.markedAnswer!.index < 4) {
        drugLegalization += question.sentiment.drugLegalization * -1;
      } else if (question.markedAnswer!.index > 4) {
        drugLegalization += question.sentiment.drugLegalization;
      }
    }

    if (question.sentiment.freedomOfReligion != 0) {
      religionQuestions.add(question);

      if (question.markedAnswer!.index < 4) {
        freedomOfReligion += question.sentiment.freedomOfReligion * -1;
      } else if (question.markedAnswer!.index > 4) {
        freedomOfReligion += question.sentiment.freedomOfReligion;
      }
    }

    if (question.sentiment.rightToBearArms != 0) {
      bearArmsQuestions.add(question);

      if (question.markedAnswer!.index < 4) {
        rightToBearArms += question.sentiment.rightToBearArms * -1;
      } else if (question.markedAnswer!.index > 4) {
        rightToBearArms += question.sentiment.rightToBearArms;
      }
    }

    if (question.sentiment.freeSpeech != 0) {
      freeSpeechQuestions.add(question);

      if (question.markedAnswer!.index < 4) {
        freeSpeech += question.sentiment.freeSpeech * -1;
      } else if (question.markedAnswer!.index > 4) {
        freeSpeech += question.sentiment.freeSpeech;
      }
    }

    if (question.sentiment.parentalRights != 0) {
      parentRightsQuestions.add(question);

      if (question.markedAnswer!.index < 4) {
        parentalRights += question.sentiment.parentalRights * -1;
      } else if (question.markedAnswer!.index > 4) {
        parentalRights += question.sentiment.parentalRights;
      }
    }

    if (question.sentiment.taxes != 0) {
      taxationQuestions.add(question);

      if (question.markedAnswer!.index < 4) {
        taxes += question.sentiment.taxes * -1;
      } else if (question.markedAnswer!.index > 4) {
        taxes += question.sentiment.taxes;
      }
    }

    if (question.sentiment.mandatoryMedicine != 0) {
      medicineQuestions.add(question);

      if (question.markedAnswer!.index < 4) {
        mandatoryMedicine += question.sentiment.mandatoryMedicine * -1;
      } else if (question.markedAnswer!.index > 4) {
        mandatoryMedicine += question.sentiment.mandatoryMedicine;
      }
    }

    if (question.sentiment.immigration != 0) {
      immigrationQuestions.add(question);

      if (question.markedAnswer!.index < 4) {
        immigration += question.sentiment.immigration * -1;
      } else if (question.markedAnswer!.index > 4) {
        immigration += question.sentiment.immigration;
      }
    }
  }
}