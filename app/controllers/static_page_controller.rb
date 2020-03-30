class StaticPageController < ApplicationController
  before_action :authenticate_client!, only: [:client_profil]
#page profil client
  def client_profil
    @client = current_client
  end

#page d'acceuil
  def index
    @comments = Comment.all
  end
#Differents service {+ Page Service Par Departement}
  def massage
    @massages = MassageSu.all
    @comments = Comment.all
  end

  def location_spa
  end
# Devenir partenaire inscription prestataire
  def partner
    @candidate = Candidate.new
    @services = Service.all
    @countries = Country.all
    @departments = Department.all
  end

  def savePartner

    @candidate = Candidate.new

    @candidate.sexe = params["sex"]
    @candidate.first_name = params["first_name"]
    @candidate.last_name = params["last_name"]
    @candidate.date_of_birth = params["date"]
    @candidate.raison_sociale = params["raison_sociale"]
    @candidate.siret = params["siret"]
    @candidate.email = params["email"]
    @candidate.telephone = params["tel"]
    @candidate.adresse = params["adresse"]
    @candidate.zip_code = params["zip_code"]
    @candidate.ville = params["town"]
    @candidate.country = params["country"]

    # if params["countries"] && params["countries"].include?("France")
    #   if params["departments"]
    #     @candidate.developments = params["departments"].join('|')
    #   else
    #     flash[:danger] = "Votre zone de prestations"
    #     redirect_back(fallback_location: root_path)
    #   end
    # end

    # @candidate.services = params["service"].join('|')
    # @candidate.countries = params["countries"].join('|')

    if @candidate.save
      flash[:notice] = "Votre inscription a été envoyer avec succès! En attente de validation par l'administrateur du site."
      redirect_back(fallback_location: root_path)
    else
      @message = "dsqfdsfsdfsdf"
      redirect_to partner_path
      redirect_back(fallback_location: root_path)
    end
  end

#Autre page
  def contact
  end

  def legalnotice
  end

  def cgu
  end
  # telechargement du doc cgu en pdf
  def dataDowCgu
    send_file(
      "#{Rails.root}/public/data_cgu/CGU_CCSPA.pdf",
      filename: "cgu_cocooning_spa.pdf",
      type: "application/pdf"
    )
  end

  #page faq
  def faq
  end

  def engagement
  end

  def propos
  end

  def save_message
    @message = Message.new
    @message.first_name = params["first_name"]
    @message.last_name = params["last_name"]
    @message.email = params["email"]
    @message.tel = params["mobile"]
    @message.name_corp = params["corp_name"]
    @message.content = params["content"]
    if @message.save
      flash[:success] = "Votre message a été bien envoyer en vous contactera très bientôt"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = @message.errors.messages
      redirect_back(fallback_location: root_path)
    end
  end

end
