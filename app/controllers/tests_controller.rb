class TestsController < ApplicationController
  before_action :set_current_test, only: %i[show update destroy]

  # GET /tests
  def index
    @tests = Test.all

    render json: @tests
  end

  # GET /tests/1
  def show
    render json: @test
  end

  # POST /tests
  def create
    @test = Test.new(resource_params)

    if @test.save
      render json: @test, status: :created, location: @test
    else
      render json: @test.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tests/1
  def update
    if @test.update(resource_params)
      render json: @test
    else
      render json: @test.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tests/1
  def destroy
    @test.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_current_test
    @test = Test.find(params[:id])
  end

  def resource_class
    Test
  end
end
