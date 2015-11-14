Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'sessions',registrations: "registrations"  }
  devise_scope :user do
    root 'devise/sessions#new'
  end

  # root "welcome#index"

  resources :questions do
    resources :answers
  end

end
