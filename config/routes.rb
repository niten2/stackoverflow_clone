Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'sessions',registrations: "registrations"  }
  devise_scope :user do
    root 'devise/sessions#new'
  end

  get "welcome" => "welcome#index"
  get "ajax" => "welcome#ajax"

  resources :attachment, only: :destroy

  concern :votable do
    member do
      patch :upvote
      patch :downvote
      patch :unvote
    end
  end

  resources :questions, concerns: :votable do
    resources :answers, shallow: true, concerns: :votable do
      patch :make_best, on: :member
    end
  end

end

