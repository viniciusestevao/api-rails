class ApplicationController < ActionController::API
  before_action :check_token
  # skip_before_action :check_token, only: :index

  private

  def check_token
    token = UserToken.valid.find_by(token: params.require(:token))
    if token.present?
      @token = token
      set_user
    end

    render json: { message: 'Token de acesso expirado' }, status: :unauthorized if token.blank?
  end

  def set_user
    @current_user = @token.user
  end

  def resource_class
    raise 'Override me'
  end

  def permitted_params
    resource_class.columns.map(&:name).map(&:to_sym)
  end

  def resource_params
    params.require(resource_class.to_s.downcase.to_sym).permit(permitted_params)
  end
end
