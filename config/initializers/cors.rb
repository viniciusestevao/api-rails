# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://834e-186-233-17-149.ngrok-free.app' # Substitua pelo endereço da sua aplicação React Native
      resource '*', headers: :any, methods: %i[get post put patch delete options head]
    end
  end