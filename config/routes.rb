Rails.application.routes.draw do
  resources :runnings
  get 'runnings/dynamic', to: 'runnings#dynamic'
  post 'runnings/update_lap', to: 'runnings#update_lap'
  root to: 'runnings#index'
end
