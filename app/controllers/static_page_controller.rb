class StaticPageController < ApplicationController
#page d'acceuil
  def index
  end
#Differents service {+ Page Service Par Departement}
  def massage
    @massages = MassageSu.all
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
