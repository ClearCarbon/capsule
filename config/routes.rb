Rails.application.routes.draw do
  root 'podcasts#index'

  resource :podcasts, except: [:index]
end
