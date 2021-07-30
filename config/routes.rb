Rails.application.routes.draw do
  resources :scenes do
    resources :messages
  end

  resources :achievements

  resources :webhooks, only: [] do
    post :line, on: :collection
  end

  resource :instance_config, controller: 'instance_config', only: %i[edit update]

  root to: "scenes#index"
end
