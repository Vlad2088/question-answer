class AnswersController < ApplicationController
  before_action :find_question, only: [:new, :create]
  before_action :load_answer, only: [:edit, :update, :destroy]

  def new
    @answer = @question.answer.new
  end

  def edit; end

  def create
    @answer = @question.answer.new(answer_params)

    if @answer.save
      redirect_to question_path(@answer.question)
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to question_path(@answer.question)   
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to questions_path
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
