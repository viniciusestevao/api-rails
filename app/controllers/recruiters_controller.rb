class RecruitersController < ApplicationController
  before_action :set_current_recruiter, only: %i[show update destroy]

  # GET /recruiters
  def index
    @recruiters = Recruiter.all

    render json: @recruiters
  end

  # GET /recruiters/1
  def show
    render json: @recruiter
  end

  # POST /recruiters
  def create
    @recruiter = Recruiter.new(resource_params)

    if @recruiter.save
      render json: @recruiter, status: :created, location: @recruiter
    else
      render json: @recruiter.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recruiters/1
  def update
    if @recruiter.update(resource_params)
      render json: @recruiter
    else
      render json: @recruiter.errors, status: :unprocessable_entity
    end
  end

  # DELETE /recruiters/1
  def destroy
    @recruiter.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_current_recruiter
    @recruiter = Recruiter.find(params[:id])
  end

  def resource_class
    Recruiter
  end
end
