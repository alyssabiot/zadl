Rails.application.routes.draw do
  scope '(:locale)', locale: /en/ do
    devise_for :users, :controllers => { registrations: 'registrations' }, skip: :omniauth_callbacks

    root to: 'pages#home'

    get 'pages/thanks' => 'pages#thanks'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :users do
      resources :events, only: [:new, :create]
    end

    get 'events/:id/calendar' => 'events#ics_export'
    resources :events, only: [:index, :show, :edit, :update, :destroy] do
      resources :bookings, only: [:create, :show] do
        resources :payments, only: [:new, :create]
      end
      resources :messages, only: [:create]
    end

    resources :bookings, only: [:index, :show, :edit, :update, :destroy]
    resources :messages, only: [:index, :show, :edit, :update, :destroy]
  end

  devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks' }, skip: [:registrations, :sessions]

end
