Rails.application.routes.draw do
  # Authentication: Keycloak (OIDC) ผ่าน Devise omniauthable — ไม่มี password ในระบบ
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  get "sign_in", to: "sessions#new", as: :new_user_session
  delete "sign_out", to: "sessions#destroy", as: :destroy_user_session

  namespace :admin do
    root "dashboard#show"
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#show"
end
