require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question = questions(:one)
  end

  test "should get index" do
    get questions_url, as: :json
    assert_response :success
  end

  test "should create question" do
    assert_difference('Question.count') do
      post questions_url, params: { question: { can_copy: @question.can_copy, description: @question.description, option_a: @question.option_a, option_b: @question.option_b, option_c: @question.option_c, option_d: @question.option_d, option_e: @question.option_e, tag: @question.tag } }, as: :json
    end

    assert_response 201
  end

  test "should show question" do
    get question_url(@question), as: :json
    assert_response :success
  end

  test "should update question" do
    patch question_url(@question), params: { question: { can_copy: @question.can_copy, description: @question.description, option_a: @question.option_a, option_b: @question.option_b, option_c: @question.option_c, option_d: @question.option_d, option_e: @question.option_e, tag: @question.tag } }, as: :json
    assert_response 200
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete question_url(@question), as: :json
    end

    assert_response 204
  end
end
