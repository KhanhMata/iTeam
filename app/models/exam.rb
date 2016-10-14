class Exam < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  has_many :exam_questions, dependent: :destroy
  has_many :questions, through: :exam_questions

  enum status: {start: 0, testing: 1, uncheck: 2, checked: 3}
  scope :newest, ->{order created_at: :desc}
  scope :latest_update, -> {order updated_at: :desc}
  scope :marks_check, -> {where is_correct: :true}

  before_create :create_exam_questions

  after_create :set_default

  accepts_nested_attributes_for :exam_questions

  def update_status is_finished_or_checked = false
    if self.start?
      self.testing!
      self.update started_at: Time.now
    elsif self.testing?
      if (get_remain_time < 0 || is_finished_or_checked)
        self.uncheck!
        calculate_mark
      end
      update_spent_time
    elsif self.uncheck? && is_finished_or_checked
      self.checked!
      ExamResultWorker.perform_async self
    end
  end

  def get_remain_time
     endtime = self.started_at + subject.duration.minutes
     seconds = endtime.to_i - Time.now.to_i
  end

  def marks
    exam_questions.where(is_correct: :true).count
  end

  private
  def create_exam_questions
    confirmed_questions = subject.questions.confirmed
    confirmed_questions.each do |question|
      self.exam_questions.build question_id: question.id,
        is_correct: Settings.exams.default_correct
    end
  end

  def set_default
    self.start!
    self.update marks: Settings.exams.default_marks,
      spent_time: Settings.exams.default_spent_time
  end

  def calculate_marks
    exam_questions.each do |exam_question|
      exam_question.check_correct
    end
  end

  def update_spent_time
    start_time = self.started_at
    seconds = self.updated_at.to_i - start_time.to_i
    seconds = subject.duration.minutes if seconds > subject.duration.minutes
    self.update spent_time: seconds
  end
end
