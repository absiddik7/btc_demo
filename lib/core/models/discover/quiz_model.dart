class Quiz {
  final int quizId; // Unique ID for each quiz
  final String title;  // Title of the quiz
  final List<Question> questions;

  Quiz({
    required this.quizId,
    required this.title,
    required this.questions,
  });
}

class Question {
  final int questionId; // Unique ID for each question
  final String question;
  final String? questionImageUrl; // Optional Image URL for the question
  final List<Answer> options; // Multiple choice options

  Question({
    required this.questionId,
    required this.question,
    this.questionImageUrl,
    required this.options,
  });
}

class Answer {
  final String answerText;
  final String? answerImageUrl; // Optional Image URL for the answer
  final bool isCorrect; // Indicates if this is the correct answer

  Answer({
    required this.answerText,
    this.answerImageUrl,
    required this.isCorrect,
  });
}
