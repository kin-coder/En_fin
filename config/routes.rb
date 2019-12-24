Rails.application.routes.draw do
  
  # Lien pour authentification admin
  devise_for :admins

  get "/admin", to: "admins#admin_page", as: "admin_page"
 


  devise_for :prestataires
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
  
  #Enregistrement des donnés du commande dans les table
  get '/confirmer-commande', to:'submitorders#save', as: "saved_commande"

  # Autre page
  get '/contact', to:'static_page#contact', as: "contact"
  get '/galerie-photo', to:'static_page#galerie', as: "galerie"
  get '/help/faq', to:'static_page#faq', as: "faq"
  get '/mentions-legales', to:'static_page#legalnotice', as: "legalnotice"
  get '/conditions-generales', to:'static_page#cgu', as: "cgu"


  #routes page comment ca marche
  get '/comment-ca-marche', to:'static_page#comment_ca_marche', as: "comment_ca_marche"

  #routes page produit
  get '/all_produit', to:'static_page#all_produit', as: "all_produit"
end
