require 'test_helper'

class CandidateAnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @candidate_answer = candidate_answers(:one)
  end

  test "should get index" do
    get candidate_answers_url, as: :json
    assert_response :success
  end

  test "should create candidate_answer" do
    assert_difference('CandidateAnswer.count') do
      post candidate_answers_url, params: { candidate_answer: { answer: @candidate_answer.answer } }, as: :json
    end

    assert_response 201
  end

  test "should show candidate_answer" do
    get candidate_answer_url(@candidate_answer), as: :json
    assert_response :success
  end

  test "should update candidate_answer" do
    patch candidate_answer_url(@candidate_answer), params: { candidate_answer: { answer: @candidate_answer.answer } }, as: :json
    assert_response 200
  end

  test "should destroy candidate_answer" do
    assert_difference('CandidateAnswer.count', -1) do
      delete candidate_answer_url(@candidate_answer), as: :json
    end

    assert_response 204
  end
end
