Rails.application.routes.draw do
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
  # Lien pour authentification admin
  devise_for :admins
  get "/admin", to:"admins#admin_page", as:"admin_page"
  get "/admin/prestataire", to:"admins#prestataire", as:"admin_prestataire"
  # Lien pour gerer les prestataire via l'admin
  get "admin/prestataires", to:"prestataires#index", as:"index_prestataires"
  get "admin/prestataires/:id", to:"prestataires#show", as:"show_prestataires"
  get "admin/prestataires-new", to:"prestataires#new", as:"new_prestataires"
  post "admin/prestataires-new", to:"prestataires#create", as:"create_prestataires"
  get "admin/prestataires/:id/edit", to:"prestataires#edit", as:"edit_prestataires"
  patch "admin/prestataires/:id", to:"prestataires#update", as:"update_prestataires"
  delete "admin/prestataires/:id", to:"prestataires#destroy", as:"delete_prestataires"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
  #Gerer les commande dans le B-O Admin
  get "admin/orders", to:"admin_order#index", as:"index_admin_order"
  get "admin/orders/:id", to:"admin_order#show", as:"show_admin_order"
  get "admin/orders/:id/edit", to:"admin_order#edit", as:"edit_admin_order"
  patch "admin/orders/:id", to:"admin_order#update", as:"update_admin_order"
  delete "admin/orders/:id", to:"admin_order#destroy", as:"destroy_admin_order"
  #Accepter ou retire un prestataire pour la commande
  put "admin/accepter-commande/", to:"admin_order#accept", as:"accept_order"
  put "admin/waiting-commande/", to:"admin_order#waiting", as:"waiting_order"
  delete "admin/supprimer-in-commande/", to:"admin_order#remove_order", as:"remove_order"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#


  #routes page comment ca marche
  get '/comment-ca-marche', to:'static_page#comment_ca_marche', as: "comment_ca_marche"

  #routes page TOUT produit
  get '/all_produit', to:'static_page#all_produit', as: "all_produit"

  # routes page UN produit
  get '/show_produit', to:'static_page#show_produit', as: "show_produit"

  # routes page Location SPA
  get '/location_spa', to:'static_page#location_spa', as: "location_spa"

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

end
