class TestsController < ApplicationController
  before_action :set_current_test, only: %i[show update destroy questions]

  # GET /tests
  def index
    @tests = Test.all
    render json: @tests
  end

  # GET /tests/:id/questions
  def questions
    linked_questions = @test.apply_tests.map(&:test_items).flatten

    @questions = Question.all.map do |question|
      {
        id: question.id,
        title: question.description,
        question_type: question.question_type,
        status: linked_questions.include?(question.id) ? 3 : 1
      }
    end

    render json: @questions
  end

  # GET /tests/1
  def show
    render json: @test
  end

  # POST /tests
  def create
    @test = Test.new(resource_params)

    if @test.save
      handle_test_creation if params[:questions].present?

      render json: @test, status: :created, location: @test
    else
      render json: @test.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tests/1
  def update
    if @test.update(resource_params)
      update_test_items

      render json: @test
    else
      render json: @test.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tests/1
  def destroy
    # Obtenha os test_items associados a este teste
    test_items_to_destroy = @test.apply_tests.map { |apply_test| apply_test.test_items }.flatten
    # Exclua os test_items associados
    test_items_to_destroy.each(&:destroy)
    # Agora você pode excluir o próprio teste
    @test.destroy
    # Adicione o código de resposta apropriado, por exemplo:
    head :no_content
  end

  private

  def update_test_items
    existing_question_ids = @test.apply_tests.map(&:test_items).flatten.pluck(:question_id)
    questions_to_add = params[:questions].select { |question| question['status'] == 2 }
    questions_to_add_ids = questions_to_add.map { |question| question['id'] }

    received_question_ids = params[:questions].map { |question| question['id'] }
    questions_to_remove_ids = existing_question_ids - received_question_ids

    create_test_items(questions_to_add_ids)
    return unless questions_to_remove_ids.any?

    @test.test_items.where(question_id: questions_to_remove_ids).destroy_all
  end

  def handle_test_creation
    question_ids = params[:questions].each(&:permit!)
                                     .map(&:to_h)
                                     .map { |item| item['id'] }
    create_test_items(question_ids)
  end

  def create_test_items(questions_to_add)
    new_apply_test = @test.apply_tests.new
    return unless new_apply_test.save

    question_ids = Question.where(id: questions_to_add).pluck(:id)
    attributes_for_question = questions_attributes(question_ids)
    return if attributes_for_question.blank?

    attributes_for_test_item = test_items_attributes(attributes_for_question, new_apply_test.id)
    return if attributes_for_test_item.blank?

    TestItem.create(attributes_for_test_item)
  end

  def questions_attributes(question_ids)
    Question.where(id: question_ids).map do |question|
      question.attributes.except('tag', 'can_copy', 'created_at', 'updated_at', 'answer').transform_keys do |key|
        key == 'id' ? "question_#{key}" : key
      end
    end
  end

  def test_items_attributes(questions_attributes, new_apply_test_id)
    questions_attributes.map do |attributes|
      attributes.merge('apply_test_id' => new_apply_test_id)
    end
  end

  def permitted_params
    resource_class.columns.map(&:name).map(&:to_sym) + [:questions]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_current_test
    @test = Test.find(params[:id])
  end

  def resource_class
    Test
  end
end
