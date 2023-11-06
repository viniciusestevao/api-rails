Rails.application.routes.draw do
  resources :right_answers
  resources :candidate_answers
  resources :tests
  resources :questions
  resources :applies
  resources :users
  resources :candidates
  resources :recruiters
  
  resources :applies do
    get 'tests', on: :member
  end

  resources :tests do
    get 'questions', on: :member
  end

  post '/login', to: 'login#create'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
