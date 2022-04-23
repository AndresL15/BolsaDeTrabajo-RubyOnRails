Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :companies do
    resources :work_notifications do
      resources :candidate_work_notifications, only: [:update, :destroy]
    end
  end  
  resources :candidates do
    resources :candidate_work_notifications
  end
end
