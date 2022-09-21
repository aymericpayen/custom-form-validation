Rails.application.routes.draw do
  # get 'questionnaires/new'
  # get 'questionnaires/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :questionnaires,  only: [:new, :create, :show]
end
