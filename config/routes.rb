Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    confirmations: "users/confirmations" 
  }

  resources :blog_posts do
    resources :comments, only: [:create, :destroy]
    member do
      post 'like'
      delete 'unlike'
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
  root "blog_posts#index"
end
