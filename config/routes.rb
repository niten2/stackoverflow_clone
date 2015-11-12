Rails.application.routes.draw do
  root "welcome#index"

  resources :questions do
    resources :answers
  end

end
