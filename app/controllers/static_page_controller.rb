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

  #page comment-ca-marche
  def ccm
  end
  #page faq
  def faq
  end

  def engagement
  end

  def propos
  end

  def service
  end
end
