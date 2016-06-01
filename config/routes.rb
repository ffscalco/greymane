Rails.application.routes.draw do
  root to: 'home#index'

  resources :home, only: [:index]

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }, :skip => [:sessions]
  devise_scope :user do
    delete "/users/sign_out", :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
end
