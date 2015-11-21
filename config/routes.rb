Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'sessions',registrations: "registrations"  }
  devise_scope :user do
    root 'devise/sessions#new'
  end

  get "welcome" => "welcome#index"
  get "ajax" => "welcome#ajax"

  resources :questions do
    resources :answers do
      patch :make_best, on: :member
    end
  end

end
