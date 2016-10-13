Rails.application.routes.draw do

  namespace :admin do
    resources :subjects
    root "subjects#index"
    resources :questions
    resources :subjects do
      resources :questions
    end
    resources :users
    resources :exams
  end
  root "sessions#new"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  get "contribute" => "static_pages#contribute"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  get "signup" => "users#new"
  resources :users do
    root "exams#index"
    resources :exams
    resources :questions
  end
  resources :exams

end
