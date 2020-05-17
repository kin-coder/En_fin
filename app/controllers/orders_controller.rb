class OrdersController < ApplicationController
# ~~~~~~~Accepter une commande par emails~~~~~~~~~~~
  def acceptOrder
  end

  def deniedOrder
  end

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  # 1/2 Selection du zone de prestation
  def zone
  end

  def code_promo
  end

  # 1/2 Selection des prestation
  def index
    @massagesDuration = MassageDurationPrice.all
    @spas = Spa.all
    @spa_ambiances = SpaAmbiance.all
=begin
    tp MassageDurationPrice.last.massageTypes("Homme")
    tp MassageDurationPrice.find(3).massage_types.joins(:massage_massage_types).where(massage_massage_types:{massage_id:1})
    mh = Massage.find_by_name("Homme")
    mf = Massage.find_by_name("Femme")
=end
  end

  # 2/2 Sauvegarder dans une session les données
  def saveSession
    puts "================"*4
    puts params.inspect
    puts "================"*4




    






  end
  
  # 2 Selection des adresse de livraison et facturation
  def delivery
  end

  def saveDelivery
  end

  # 3 Affiche la recapitulatif de commande
  def summary
  end

  # 4 Le Payement
  def payment
  end

  def payedsuccess
  end

  def payederrors
  end

end
