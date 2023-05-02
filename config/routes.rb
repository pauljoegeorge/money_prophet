Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :passwords, :registrations], controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  namespace :api do
    namespace :v1 do
      resources :expenses, only: [:index]
    end
  end
end
