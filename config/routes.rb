Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'cocktails/spirit/:spirit', to: 'cocktails#specify', as: :specify
  resources :cocktails, only: [:index, :show, :new, :create]  do
    resources :doses, only: [:new, :create]
  end
  resources :doses, only: :destroy
  root to: 'cocktails#index'

end
