class Admin::QuestionsController < ApplicationController
  before_action :load_subjects, except: [:show]
  before_action :load_question, only: [:edit, :update, :destroy]

  def index
    @subjects = Subject.all
    @search = Question.contributed.ransack params[:q]
    @statuses = Question.statuses
    @questions =  @search.result.page(params[:page]).per_page(Settings.pagination.per_page)
  end

  def new
    @question.answers.new
    @subjects = Subject.all
  end

  def create
    @question = current_user.questions.build question_params
    if @question.save
      flash.now[:success] = t "flash.success.created_question"
      redirect_to admin_subject_path @subject
    else
      @subjects = Subject.all
      flash.now[:danger] = t "flash.danger.created_question"
      render :new
    end
  end

  def edit
    @subjects = Subject.all
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "flash.danger.edit_question"
      redirect_to admin_subject_questions_path @subject
    else
      @subjects = Subject.all
      flash[:danger] = t "flash.danger.edit_question"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash.now[:success] = t "flash.success.deleted_question"
    else
      flash[:danger] = t "flash.danger.deleted_question"
    end
    redirect_to :back
  end

  private
  def load_subjects
    @subject =  Subject.find_by id: params[:subject_id]
    unless @subject
      flash[:danger] = t "subject_not_found"
      redirect_to admin_root_path
    end
  end

  def load_question
    @question = @subject.questions.find_by id: params[:id]
    unless @subject
      flash[:danger] = t "subject_not_found"
      redirect_to admin_root_path
    end
  end

  def question_params
    params.require(:question).permit :content, :answer_type, :subject_id,
      :user_id, answers_attributes: [:id, :content, :is_correct, :question_id]
  end
end
