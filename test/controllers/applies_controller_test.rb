require 'test_helper'

class AppliesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @apply = applies(:one)
  end

  test "should get index" do
    get applies_url, as: :json
    assert_response :success
  end

  test "should create apply" do
    assert_difference('Apply.count') do
      post applies_url, params: { apply: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show apply" do
    get apply_url(@apply), as: :json
    assert_response :success
  end

  test "should update apply" do
    patch apply_url(@apply), params: { apply: {  } }, as: :json
    assert_response 200
  end

  test "should destroy apply" do
    assert_difference('Apply.count', -1) do
      delete apply_url(@apply), as: :json
    end

    assert_response 204
  end
end
