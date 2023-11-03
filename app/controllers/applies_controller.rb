class AppliesController < ApplicationController
  before_action :set_current_apply, only: %i[show update destroy tests]

  # GET /applies
  def index
    @applies = Apply.all.as_json(include: { recruiter: { only: [:name]}, candidate: { only: [:name] } })
    render json: @applies
  end

  # GET /applies/:id/tests
  def tests
    linked_tests = @apply.apply_tests.pluck(:test_id)
    @tests = Test.all.map do |test|
      {
        id: test.id,
        title: test.title,
        status: linked_tests.include?(test.id) ? 3 : 1
      }
    end

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
        test_ids= params[:tests].each(&:permit!)
                                .map(&:to_h)
                                .map { |item| item['id'] }
        create_apply_test(test_ids)
      end

      render json: @apply, status: :created, location: @apply
    else
      render json: @apply.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applies/1
  def update
    if @apply.update(resource_params)
      update_apply_tests
  
      render json: @apply
    else
      render json: @apply.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /applies/1
  def destroy
    # if can_destroy_apply?(@apply)
    #   test_items_to_destroy = @apply.apply_tests.map { |apply_test| apply_test.test_items }.flatten
    #   test_items_to_destroy.each(&:destroy)
      
      @apply.apply_tests.destroy_all
      @apply.destroy
    #   head :no_content
    # else
    #   render json: { message: 'Não é possível excluir a aplicação, porque um dos questionários já foi respondido pelo candidato.' }, status: :unprocessable_entity
    # end
  end

  
  private

  def update_apply_tests
    existing_test_ids = @apply.apply_tests.pluck(:test_id)
    tests_to_add = params[:tests].select { |test| test['status'] == 2 }
    tests_to_add_ids = tests_to_add.map { |test| test['id'] }
    
    received_test_ids = params[:tests].map { |test| test['id'] }
    tests_to_remove_ids = existing_test_ids - received_test_ids
    
    create_apply_test(tests_to_add_ids)  
    if tests_to_remove_ids.any?
      @apply.apply_tests.where(test_id: tests_to_remove_ids).destroy_all
    end
  end

  def can_destroy_apply?(apply)
    !apply.apply_tests.any? { |apply_test| apply_test.test_items.any? { |test_item| test_item.candidate_answers.any? } }
  end

  def create_apply_test(tests_to_add)
    @apply.create_apply_test(tests_to_add)
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
