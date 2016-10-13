class Subject < ApplicationRecord
  belongs_to :user

  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50}
  validates :question_number, presence: true,
    numericality: {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :duration, presence: true, numericality: {only_integer: true}
  scope :newest, ->{order created_at: :desc}
end
