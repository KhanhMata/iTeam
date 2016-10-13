class QuestionsController < ApplicationController
  before_action :load_all_subject

  def index
    @questions = current_user.questions.alphabet
      .page(params[:page]).per_page Settings.pagination.per_page
  end

  def new
    @question = current_user.questions.new
    @question.answers.new
  end

  def create
    @question = current_user.questions.new question_params
    if @question.save
      flash[:success] = t "flash.success.contributed_question"
      redirect_to user_questions_path
    else
      flash[:danger] = t "flash.danger.contributed_question"
      render :new
    end
  end

  private
  def question_params
    params.require(:question).permit :id, :content, :answer_type,
      :subject_id, answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_all_subject
    @subjects =  Subject.all
  end
end
