class QuestionsController < ApplicationController
  before_action :load_all_subject
  before_action :load_question, only: [:destroy, :edit, :update]

  def index
    @questions = current_user.questions.alphabet
      .page(params[:page]).per_page Settings.pagination.per_page
  end

  def new
    @question = current_user.questions.new
    @question.answers.new
  end

  def show
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

  def edit
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "flash.success.updated_contributed_question"
      redirect_to user_questions_path
    else
      flash[:danger] = t "flash.danger.updated_contributed_question"
      load_all_subject
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = t "flash.success.deleted_contributed_question"
    else
      flash[:danger] = t "flash.danger.deleted_contributed_question"
    end
    redirect_to user_questions_path
  end

  private
  def question_params
    params.require(:question).permit :id, :content, :answer_type,
      :subject_id, answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_all_subject
    @subjects =  Subject.all
  end

  def load_question
    @question = Question.find_by id: params[:id]
    unless @question
      flash.now[:danger] = t "flash.danger.question_not_found"
      redirect_to question_path
    end
  end
end
