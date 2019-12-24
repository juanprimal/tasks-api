Rails.application.routes.draw do
  resources :users do
    resources :user_tasks
  end
end
