class RightAnswersController < ApplicationController
  before_action :set_right_answer, only: [:show, :update, :destroy]

  # GET /right_answers
  def index
    @right_answers = RightAnswer.all

    render json: @right_answers
  end

  # GET /right_answers/1
  def show
    render json: @right_answer
  end

  # POST /right_answers
  def create
    @right_answer = RightAnswer.new(resource_params)

    if @right_answer.save
      render json: @right_answer, status: :created, location: @right_answer
    else
      render json: @right_answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /right_answers/1
  def update
    if @right_answer.update(resource_params)
      render json: @right_answer
    else
      render json: @right_answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /right_answers/1
  def destroy
    @right_answer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_right_answer
      @right_answer = RightAnswer.find(params[:id])
    end

    def resource_class
      RightAnswer
    end
end
