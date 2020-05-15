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

    

#tp MassageDurationPrice.last.massageTypes("Homme")


#     Massage.all.each do |massage|
#       category = [massage.name,[]]
#       massage.massage_types.each do |massage_type|
#         mtype = [massage_type.name,[]]
#         massage_type.massage_duration_prices.each do |price|
#           mtype[1].push([price.duration,price.exceptional_price,price.ordinary_price,price.exceptional_acompte,price.ordinary_acompte])
#         end
#         category[1].push(mtype)
#       end
#       @massages.push(category)
#     end

# tp MassageDurationPrice.find(3).massage_types.joins(:massage_massage_types).where(massage_massage_types:{massage_id:1})

# mh = Massage.find_by_name("Homme")
# mf = Massage.find_by_name("Femme")



  end

  # 2/2 Sauvegarder dans une session les données
  def saveSession
    puts "================"*4
    params["massages"].each do |k,v|
      puts "-------"
      puts "key en 2: #{k.split('|')}"
      puts "value : #{v}"
      puts "-------"
    end
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
