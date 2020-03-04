Rails.application.routes.draw do
  # Lien pour l'authentification du client, Logign, ...
  devise_for :clients
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
#STATIC_PAGE_CONTROLLERS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
  # Lien pour les page static dans le static_page
  # page d'acceul
  root 'static_page#index'

  get '/contact', to:'static_page#contact', as: "contact"
  get '/mentions-legales', to:'static_page#legalnotice', as: "legalnotice"
  get '/conditions-generales', to:'static_page#cgu', as: "cgu"
  get '/conditions-generales-to-pdf', to:'static_page#dataDowCgu', as: "data_cgu"
  get '/faq', to:'static_page#faq', as: "faq"
  get "/engagement", to:'static_page#engagement', as: "engagement"
  get "/qui-sommes-nous", to:'static_page#propos', as: "propos"

  get "/devenir-partenaire", to:'static_page#partner', as: "partner"

# Page pour chaque service
  get '/service', to:'static_page#service', as: "service"
  get '/reservation-massage', to:'static_page#massage', as: "massage"
  get '/location-spa', to:'static_page#location_spa', as: "spa"

#ORDERS_CONTROLLERS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
  # Lien pour les page tunelle d'achats dans le controller ORDERS
  post 'filter' => 'controller_name#filter'
  post 'validate-zone', to:"orders#zone", as:"zone"
  get '/reservation-prestation', to:'orders#index', as: "reservation"
  get '/reservation-prestation/info-livraison', to:'orders#delivery', as: "delivery"

  

  post '/reservation-prestation/save', to:'orders#saveSession', as: "save_session"

  post '/reservation-prestation/recapitulatif-commande', to:'orders#summary', as: "summary"

  post 'validate-code', to:"orders#code_promo", as:"code_promo"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#


end

