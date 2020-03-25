class StaticPageController < ApplicationController
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
    @candidate.services = params["service"].join('|')
    @candidate.countries = params["countries"].join('|')
    if params["countries"].include?("France")
      if params["departments"]
        @candidate.developments = params["departments"].join('|')
      else
        redirect_to partner_path
      end
    end
    if @candidate.save
      redirect_to contact_path, notice: "Votre inscription a été envoyer avec succès! En attente de validation par l'administrateur du site."
    else
      redirect_to partner_path
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

end
