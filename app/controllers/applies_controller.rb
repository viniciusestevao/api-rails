class AppliesController < ApplicationController
  before_action :set_current_apply, only: %i[show update destroy]

  # GET /applies
  def index
    @applies = Apply.joins("LEFT JOIN people AS candidates ON applies.candidate_id = candidates.id AND candidates.type = 'Candidate'")
                    .joins("LEFT JOIN people AS recruiters ON applies.recruiter_id = recruiters.id AND recruiters.type = 'Recruiter'")
                 .select('applies.*, candidates.name AS candidate_name, recruiters.name AS recruiter_name') 
    render json: @applies
  end

  # GET /applies/:id/tests
  def tests
    @apply = Apply.find(params[:id])
    @tests = @apply.tests
    render json: @tests
  end

  # GET /applies/1
  def show
    render json: @apply
  end

  # POST /applies
  def create
    @apply = Apply.new(resource_params)
    
    if @apply.save
      if params[:tests].present?
        create_apply_test
      end

      render json: @apply, status: :created, location: @apply
    else
      render json: @apply.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applies/1
  def update
    if @apply.update(resource_params)
      render json: @apply
    else
      render json: @apply.errors, status: :unprocessable_entity
    end
  end

  # DELETE /applies/1
  def destroy
    @apply.destroy
  end

  private

  def test_ids
    params[:tests].each(&:permit!)
                  .map(&:to_h)
                  .map { |item| item['id'] }
  end

  def create_apply_test
    @apply.create_apply_test(test_ids)
  end

  def permitted_params
    resource_class.columns.map(&:name).map(&:to_sym) + [:tests]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_current_apply
    @apply = Apply.find(params[:id])
  end

  def resource_class
    Apply
  end
end
