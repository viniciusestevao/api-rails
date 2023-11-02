require 'test_helper'

class RightAnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @right_answer = right_answers(:one)
  end

  test "should get index" do
    get right_answers_url, as: :json
    assert_response :success
  end

  test "should create right_answer" do
    assert_difference('RightAnswer.count') do
      post right_answers_url, params: { right_answer: { description: @right_answer.description } }, as: :json
    end

    assert_response 201
  end

  test "should show right_answer" do
    get right_answer_url(@right_answer), as: :json
    assert_response :success
  end

  test "should update right_answer" do
    patch right_answer_url(@right_answer), params: { right_answer: { description: @right_answer.description } }, as: :json
    assert_response 200
  end

  test "should destroy right_answer" do
    assert_difference('RightAnswer.count', -1) do
      delete right_answer_url(@right_answer), as: :json
    end

    assert_response 204
  end
end
