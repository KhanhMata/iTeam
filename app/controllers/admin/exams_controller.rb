class Admin::ExamsController < ApplicationController
  before_action :verify_admin
  before_action :load_exam, only: [:show, :update]

  def index
    @exam = Exam.new
    @exams = Exam.latest_update.page(params[:page])
      .per_page Settings.pagination.per_page
    @subjects = Subject.all
  end

  def show
    @exam.exam_questions.each do |exam_question|
      exam_question.build_exam_answers
    end
  end

  def update
    if @exam.update_attributes exam_params
      @exam.update_status params[:checked]
      flash[:success] = t "flash.success.checked_exam"
    else
      flash[:danger] = t "flash.danger.checked_exam"
    end
    redirect_to admin_exams_path
  end

  private
  def exam_params
    params.require(:exam).permit :subject_id,
      exam_questions_attributes: [:id, :is_correct]
  end

  def load_exam
    @exam = Exam.find_by id: params[:id]
    unless @exam
      flash[:danger] = I18n.t "flash.danger.exam_not_found"
      redirect_to admin_root_path
    end
  end
end
