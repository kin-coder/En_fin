Rails.application.routes.draw do
  get 'notification/index'
  get 'notification/show'
  # Lien pour l'authentification du client, Logign, ...
  devise_for :clients, controllers: { registrations: "registrations",confirmations: 'confirmations' }
  # page pour le profil du client
  get '/client-profil', to: 'clients#profil', as: "client_profil"
  get '/client-profil/info', to: 'clients#personalInfo', as: "client_personal_info"
  get '/client/order/:id', to: 'clients#order', as: "client_order"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
  # Lien pour authentification admin
  devise_for :admins, path: 'admins',:skip => [:registrations], controllers: { 
    sessions: "admins/sessions"
  }

  # creation et gestion candidature
  get "/admin/candidates", to:"admins#allcandidate", as:"allcandidate"
  get "/admin/candidate/:id", to:"admins#showEditCandidat", as:"show_edit_candidate"
  patch "/admin/candidate-to-prestataire/", to:"admins#createCandidateToPrestataire", as:"create_candidate_prestataire"
  delete "/admin/delete-candidate/:id", to:"admins#cancelCandidat", as:"cancel_candidat"

  # Lien pour gerer les prestataire via l'admin
  get "admin/prestataires", to:"prestataires#index", as:"index_prestataires"
  get "admin/prestataires/:id", to:"prestataires#show", as:"show_prestataires"
  get "admin/prestataires-new", to:"prestataires#new", as:"new_prestataires"
  post "admin/prestataires-new", to:"prestataires#create", as:"create_prestataires"
  get "admin/prestataires/:id/edit", to:"prestataires#edit", as:"edit_prestataires"
  patch "admin/prestataires/:id", to:"prestataires#update", as:"update_prestataires"
  delete "admin/prestataires/:id", to:"prestataires#destroy", as:"delete_prestataires"


  # Lien pour gerer les prospect via l'admin
  get "admin/prospects", to:"admins#allprospect", as:"index_prospects"
  # Lien pour gerer les client via l'admin
  get "admin/clients", to:"admins#allclient", as:"index_clients"
  get "admin/clients/:id", to:"admins#show", as:"show_clients"
  get "admin/clients/:id/edit", to:"admins#edit", as:"edit_clients"
  patch "admin/clients/:id", to:"admins#update", as:"update_clients"
  delete "admin/clients/:id", to:"admins#destroy", as:"delete_clients"

  # Lien pour gerer la commande via l'admin
#================================================================================#
  get "/admin", to:'admin_order#index', as:"admin_order_index"
  get "/admin/commande-traitées", to:'admin_order#processed', as:"admin_order_processed"
  get "/admin/commande-non-traitées", to:'admin_order#notprocessed', as:"admin_order_not_processed"
#================================================================================#
  get "/admin/commande-numero/:id", to:'admin_order#show', as:"admin_order_show"
  #lien pour la modification de commande
  get "/admin/commande-numero/:id/edit", to:'admin_order#edit', as:"admin_order_edit"
  patch "/admin/:name/:order_id/modifier-prestataire/:id", to:"admin_order#afect_prestataire", as:"afect_prestataire_to_order"
  delete "/admin/:name/:order_id/retirer-prestataire/:id", to:"admin_order#delete_prestataire", as:"delete_prestataire_to_order"
#STATIC_PAGE_CONTROLLERS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
  # Lien pour les page static dans le static_page
  # page d'acceul
  root to:'static_page#index'
  get '/galery', to:'static_page#galery', as: "galery"
  get '/contact', to:'static_page#contact', as: "contact"
  get '/mentions-legales', to:'static_page#legalnotice', as: "legalnotice"
  get '/conditions-generales', to:'static_page#cgu', as: "cgu"
  get '/conditions-generales-to-pdf', to:'static_page#dataDowCgu', as: "data_cgu"
  get '/faq', to:'static_page#faq', as: "faq"
  get "/engagement", to:'static_page#engagement', as: "engagement"
  get "/qui-sommes-nous", to:'static_page#propos', as: "propos"

  #save candidature
  get "/devenir-partenaire", to:'static_page#partner', as: "partner"
  post "/devenir-partenaire/save", to:'static_page#savePartner', as: "save_partner"
  

# Page pour chaque service
get '/service', to:'static_page#service', as: "service"
get '/reservation-massage', to:'static_page#massage', as: "massage"
get '/location-spa', to:'static_page#location_spa', as: "spa"

# Save message and send email to admin
post '/admin/send-email', to:'static_page#save_message', as: "save_message"

#ORDERS_CONTROLLERS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
  # Lien pour les page tunelle d'achats dans le controller ORDERS
  post '/reservation-prestation/validate-zone', to:"orders#zone", as:"zone"
  get '/reservation-prestation', to:'orders#index', as: "reservation"
  post '/reservation-prestation/save', to:'orders#saveSession', as: "save_session"
  
  get '/reservation-prestation/info-livraison', to:'orders#delivery', as: "delivery"
  post '/reservation-prestation/info-livraison/save', to:'orders#saveDelivery', as: "save_delivery"
  
  get '/reservation-prestation/recapitulatif-commande', to:'orders#summary', as: "summary"
  #tokony post ito
  post '/reservation-prestation/paye-commande', to:'orders#payment', as: "payment"
  get '/reservation-prestation/payed-success', to:'orders#payedsuccess', as: "payedsuccess"
  get '/reservation-prestation/payed-errors', to:'orders#payederrors', as: "payederrors"

  post '/reservation-prestation/validate-code', to:"orders#code_promo", as:"code_promo"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
  # call back après accepte ou réfus d'une commande
  get "/accepter-une-commande/:os_id/:prestataire_id", to:"orders#acceptOrder", as:"accept_order_prestataires"
  get "/refuser-une-commande/:os_id/:prestataire_id", to:"orders#deniedOrder", as:"denied_order_prestataires"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
  get "/all/:id/notifications", to:"notification#index", as:"all_notifications"
  patch "/admin/notification/:id", to:"notification#update", as:"update_notifications"
  get "/admin/notification_all", to: "notification#update_all", as:"update_all_notifications"
end
