class Answer < ApplicationRecord
  belongs_to :question, optional: true

  has_many :exam_answers

  validates :content, presence: true
end
