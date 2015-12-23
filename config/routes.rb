require 'sidekiq/web'
Rails.application.routes.draw do

  authenticate :user, lambda { |user| user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper
  devise_for :users, controllers: { sessions: 'sessions', registrations: "registrations", omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    root 'devise/sessions#new'
    # post '/finish_sign_up' => 'registrations#finish_sign_up'
    post '/finish_sign_up' => 'omniauth_callbacks#finish_sign_up'
  end

  get "welcome" => "welcomes#index"
  get "ajax" => "welcome#ajax"

  get "search" => "search#search"
  get "find" => "search#find"

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
    patch :subscribe, on: :member
    patch :unsubscribe, on: :member
    resources :comments, only: :create, defaults: {commentable: 'questions'}

    resources :answers, shallow: true, concerns: :votable do
      resources :comments, only: :create, defaults: {commentable: 'questions'}
      patch :make_best, on: :member
    end
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [:index] do
        get :me, on: :collection
      end

      resources :questions do
        resources :answers
      end

    end
  end

end

