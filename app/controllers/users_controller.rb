class UsersController < ApplicationController
  before_action :set_current_user, only: %i[show update destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    user_params = resource_params.except(:token)
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(resource_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    if @user.candidates.present?
      render json: { message: 'Não é possível excluir este usuário, pois ele está vinculado a um ou mais candidatos.' }, status: :unprocessable_entity
    elsif @user.recruiters.present? 
      render json: { message: 'Não é possível excluir este usuário, pois ele está vinculado a um ou mais recrutadores.' }, status: :unprocessable_entity
    else
      @user.destroy
      head :no_content
    end
  end

  private

  def resource_class
    User
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_current_user
    @user = User.find(params[:id])
  end
end
