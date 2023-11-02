class CandidatesController < ApplicationController
  before_action :set_current_candidate, only: %i[show update destroy]

  # GET /candidates
  def index
    @candidates = Candidate.all

    render json: @candidates
  end

  # GET /candidates/1
  def show
    render json: @candidate
  end

  # POST /candidates
  def create
    @candidate = Candidate.new(resource_params)

    if @candidate.save
      render json: @candidate, status: :created, location: @candidate
    else          
      render json: @candidate.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /candidates/1
  def update
    if @candidate.update(resource_params)
      render json: @candidate
    else
      render json: @candidate.errors, status: :unprocessable_entity
    end
  end

  # DELETE /candidates/1
  def destroy
    @candidate.destroy
  end

  private

  def resource_class
    Candidate
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_current_candidate
    @candidate = Candidate.find(params[:id])
  end
end
