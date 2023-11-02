class LoginController < ApplicationController
  skip_before_action :check_token, only: :create

  def create
    username = params.require(:username)
    password = params.require(:password)

    user = User.find_by(username:, password:)
    # usar o devise depois
    if user.present?
      token = create_token(user)
      render json: { message: 'Autenticação bem-sucedida.', token: }, status: :ok
    else
      render json: { message: 'Credenciais inválidas.' }, status: :unauthorized
    end
  end

  private

  def create_token(user)
    token = UserToken.valid.where(user_id: user.id).first
    return token if token.present?

    token = SecureRandom.urlsafe_base64(64)
    user.user_tokens.create(token:, token_type: '', expires_at: Time.zone.now + 24.hour)
  end
end
