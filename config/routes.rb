Rails.application.routes.draw do
  #page d'acceul
  root 'static_page#index'
  
  # Page pour chaque service
  get '/reservation-massage', to:'static_page#massage', as: "massage"
  get '/location-spa', to:'static_page#spa', as: "spa"

  devise_for :clients
  
end
