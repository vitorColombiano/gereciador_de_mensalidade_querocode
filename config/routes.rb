Rails.application.routes.draw do
  namespace :api do
	  namespace :v1 do
		resources :students, only: [:index]
	  end
	end
end
