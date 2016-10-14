class ExamsController < ApplicationController
  before_action :load_exam, except: [:index, :new, :create]

  def index
    @exam = current_user.exams.new
    @subjects = Subject.all
    @exams = Exam.newest.page(params[:page])
      .per_page Settings.pagination.per_page
  end

  def new
  end

  def show
    @exam.update_status
    @exam.exam_questions.each do |exam_question|
    exam_question.build_exam_answers
    end
  end

  def create
    @exam = current_user.exams.new exam_params
    if @exam.save
      flash.now[:susscess] = "flash.susscess.create_exam"
    else
      flash.now[:danger] = t "flash.danger.created_exam"
      render :new
    end
    redirect_to user_exams_path(current_user)
  end

  def update
    if @exam.update_attributes exam_params
      flash.now[:success] = t "flash.success.updated_exam"
    else
      flash.now[:danger] = t "flash.danger.updated_exam"
    end
    redirect_to admin_exams_path
  end

  def destroy
    if @exam.destroy
      flash.now[:success] = t "flash.success.deleted_exam"
    else
      flash.now[:danger] = t "flash.danger.deleted_exam"
    end
    redirect_to admin_exams_path
  end

  private
  def exam_params
    params.require(:exam).permit :subject_id,
      exam_questions_attributes: [:id, exam_answers_attributes: [:id,
      :answer_id, :content_answer, :_destroy]]
  end

  def load_exam
    @exam = Exam.find_by id: params[:id]
    unless @exam
      flash.now[:danger] = t "flash.danger.exam_not_found"
      redirect_to exam_path
    end
  end
end
