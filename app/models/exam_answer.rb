class ExamAnswer < ApplicationRecord
  belongs_to :exam_question
  belongs_to :answer
end
