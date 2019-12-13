Rails.application.routes.draw do
  #page d'acceul
  root 'static_page#index'
  
  #Lien pour l'authentification du client, Logign, ...
  devise_for :clients

  # Page pour chaque service
  get '/reservation-massage', to:'static_page#massage', as: "massage"
  get '/location-spa', to:'static_page#spa', as: "spa"
  
  #lien pour le panier dynamique
  get ':name/prix-reservation', to:'orders#index', as:"reservation"
  get '/addcategory/:id', to: "orders#addcategory", as:"addcategory"
  get '/deletecategory/:id', to: "orders#delcategory", as:"deletecategory"
  put '/subcategory', to: "orders#subcategory", as:"subcategory"
  
  # Autre page
  get '/contact', to:'static_page#contact', as: "contact"
  get '/galerie-photo', to:'static_page#galerie', as: "galerie"
  get '/help/faq', to:'static_page#faq', as: "faq"
  get '/mentions-legales', to:'static_page#legalnotice', as: "legalnotice"
  get '/conditions-generales', to:'static_page#cgu', as: "cgu"

end
