Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/auth/google', to: 'auth/google/oauth#google_auth'
      get '/auth/google/callback', to: 'auth/google/oauth#google_auth_callback'

      resources :expenses, only: [:index]
      resources :fixed_expenses, only: %i[index] do
        collection do
          put :update
        end
      end
      resources :unexpected_expenses, only: %i[index] do
        collection do
          put :update
        end
      end
      resources :incomes, only: %i[index] do
        collection do
          put :update
        end
      end
    end
  end
end
