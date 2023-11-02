class CandidateAnswersController < ApplicationController
  before_action :set_candidate_answer, only: [:show, :update, :destroy]

  # GET /candidate_answers
  def index
    @candidate_answers = CandidateAnswer.all

    render json: @candidate_answers
  end

  # GET /candidate_answers/1
  def show
    render json: @candidate_answer
  end

  # POST /candidate_answers
  def create
    @candidate_answer = CandidateAnswer.new(resource_params)

    if @candidate_answer.save
      render json: @candidate_answer, status: :created, location: @candidate_answer
    else
      render json: @candidate_answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /candidate_answers/1
  def update
    if @candidate_answer.update(resource_params)
      render json: @candidate_answer
    else
      render json: @candidate_answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /candidate_answers/1
  def destroy
    @candidate_answer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate_answer
      @candidate_answer = CandidateAnswer.find(params[:id])
    end

    def resource_class
      CandidateAnswer
    end
end
