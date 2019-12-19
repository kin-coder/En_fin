Rails.application.routes.draw do
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
  # Lien pour authentification admin
  devise_for :admins
  get "/admin", to:"admins#admin_page", as:"admin_page"
  get "/admin/prestataire", to:"admins#prestataire", as:"admin_prestataire"
  # Lien pour gerer les prestataire via l'admin
  get "admin/prestataires", to:"prestataires#index", as:"index_prestataires"
  post "admin/prestataires", to:"prestataires#create", as:"create_prestataires"
  get "admin/prestataires/new", to:"prestataires#new", as:"new_prestataires"
  get "admin/prestataires/:id/edit", to:"prestataires#edit", as:"edit_prestataires"
  get "admin/prestataires/:id", to:"prestataires#show", as:"show_prestataires"
  put "admin/prestataires/:id", to:"prestataires#update", as:"update_prestataires"
  delete "admin/prestataires/:id", to:"prestataires#destroy", as:"delete_prestataires"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
  # page d'acceul
  root 'static_page#index'
  # Lien pour l'authentification du client, Logign, ...
  devise_for :clients
  # Page pour chaque service
  get '/reservation-massage', to:'static_page#massage', as: "massage"
  get '/location-spa', to:'static_page#spa', as: "spa"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
  # lien pour le panier dynamique
  get ':name/prix-reservation', to:'orders#index', as:"reservation"
  get '/addcategory/:id', to: "orders#addcategory", as:"addcategory"
  get '/deletecategory/:id', to: "orders#delcategory", as:"deletecategory"
  put '/subcategory', to: "orders#subcategory", as:"subcategory"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
  #Enregistrement des donnés du commande dans les table
  get '/confirmer-commande', to:'submitorders#save', as: "saved_commande"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
  # Autre page
  get '/contact', to:'static_page#contact', as: "contact"
  get '/galerie-photo', to:'static_page#galerie', as: "galerie"
  get '/mentions-legales', to:'static_page#legalnotice', as: "legalnotice"
  get '/conditions-generales', to:'static_page#cgu', as: "cgu"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
end
