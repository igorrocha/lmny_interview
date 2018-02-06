Rails.application.routes.draw do
  root to: 'static_pages#home'

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
  }

  resources :offers, only: [:index, :new, :create, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
