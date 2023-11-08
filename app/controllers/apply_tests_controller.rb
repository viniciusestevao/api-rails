class ApplyTestsController < ApplicationController
    before_action :set_current_apply_test, only: %i[show update destroy]

    # GET /apply_tests
    # def index
    #   # @apply_tests = ApplyTest.includes(:test_items).all
    #   @apply_tests = ApplyTest.includes(:test_items).includes(:apply).all
    #   render json: @apply_tests, include: [:apply, :test_items]
    # end
    def index
      sql = <<~SQL
        SELECT apply_tests.*, candidates.name as candidate_name, recruiters.name as recruiter_name,
               array_agg(json_build_object(
                 'id', test_items.id,
                 'apply_test_id', test_items.apply_test_id,
                 'question_id', test_items.question_id,
                 'description', test_items.description,
                 'question_type', test_items.question_type,
                 'body', test_items.body,
                 'answer', test_items.answer,
                 'candidate_answer', test_items.candidate_answer,
                 'created_at', test_items.created_at,
                 'updated_at', test_items.updated_at
               )) as test_items
        FROM apply_tests
        INNER JOIN applies ON apply_tests.apply_id = applies.id
        INNER JOIN people AS candidates ON applies.candidate_id = candidates.id
        INNER JOIN people AS recruiters ON applies.recruiter_id = recruiters.id
        LEFT JOIN test_items ON test_items.apply_test_id = apply_tests.id
        GROUP BY apply_tests.id, candidates.name, recruiters.name
      SQL
    
      @apply_tests = ApplyTest.find_by_sql(sql)
    
      render json: @apply_tests
    end

    # GET /apply_tests/1
    def show
      render json: @apply_test, include: :test_items
    end
  
    # POST /apply_tests
    def create
      @apply_test = ApplyTest.new(apply_test_params)
  
      if @apply_test.save
        render json: @apply_test, status: :created
      else
        render json: @apply_test.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /apply_tests/1
    def update
      if @apply_test.update(apply_test_params)
        render json: @apply_test
      else
        render json: @apply_test.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /apply_tests/1
    def destroy
      @apply_test.destroy
      head :no_content
    end
  

    private

  
    def set_apply_test
      @apply_test = ApplyTest.find(params[:id])
    end
  
    def apply_test_params
      params.require(:apply_test).permit(:apply_id, :test_id, test_items_attributes: [:id, :candidate_answer])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_current_apply_test
      @apply_test = ApplyTest.find(params[:id])
    end
  
    def resource_class
      ApplyTest
    end

end
