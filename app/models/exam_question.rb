class ExamQuestion < ApplicationRecord
  belongs_to :exam
  belongs_to :question

  has_many :exam_answers

  def check_correct
    if exam_answers.count == 0
      is_correct = false
    else
      if question.single_choice?
        is_correct = exam_answers.first.answer.is_correct
      case
        when question.multi_choice?
          number_correct = question.answers
            .where(is_correct: true).count
          is_correct = exam_answers.joins(:answer)
            .where(answers: {is_correct: true}).count == number_correct
        else
          content_answer = exam_answers
            .first.content_answer.downcase
          content = question.answers.first.content.downcase
          is_correct = content == content_answer
        end
      end
    end
    self.update is_correct: is_correct
  end
end
