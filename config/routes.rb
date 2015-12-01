Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'sessions', registrations: "registrations", omniauth_callbacks: 'omniauth_callbacks' }

  devise_scope :user do
    root 'devise/sessions#new'
  end

  get "welcome" => "welcome#index"
  get "ajax" => "welcome#ajax"

  resources :attachments, only: :destroy
  resources :comments, only: [:create, :destroy]

  concern :votable do
    member do
      patch :upvote
      patch :downvote
      patch :unvote
    end
  end

  resources :questions, concerns: :votable do
    resources :comments, only: :create, defaults: {commentable: 'questions'}

    resources :answers, shallow: true, concerns: :votable do
      resources :comments, only: :create, defaults: {commentable: 'questions'}
      patch :make_best, on: :member
    end
  end

end

