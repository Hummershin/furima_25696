Rails.application.routes.draw do
  # get 'cards/index' 追加実装のカードのところで勝手にできたやつ
  # get 'cards/new'
  # get 'cards/create'
  # get 'cards/destroy'
  resources :cards, only: [:index, :new, :create, :destroy]

  get 'comments/create'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }

  devise_scope :user do
    get 'users/new_address_preset', to: 'users/registrations#new_address_preset'
    post 'users/create_address_preset', to: 'users/registrations#create_address_preset'
  end

  
  root to: "items#index"
  resources :items do
    resources :transactions, only: [:index, :new, :create]
    resources :comments, only: :create
    member do
      get :purchase_confirm
      post :purchase
    end
  end

end