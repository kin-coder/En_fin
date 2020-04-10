class PrestataireMailer < ApplicationMailer

  def new_candidate(candidate)
  	@candidate = candidate
  	@url = 'http://spamandona.herokuapp.com/'
  	# permet d'envoyer l'email à to: ...
  	mail(to: @candidate.email, subject: 'Bienvenue chez Cocooning Spa !')
  end

  def new_orderSpa(order_service)
    @oService = OrderService.find(order_service)
    @order = @oService.order
    @date = @order.prestation_date.split("/")
    @date = "#{@date[1]}/#{@date[0]}/#{@date[2]}"
    @prestataires = []
    if @order.department.nil?
      @prestataires = Prestataire.joins(:services).where(services:{name:"Location spa"}).joins(:countries).where(countries:{name:@order.country.name})
    else
      @prestataires = Prestataire.joins(:services).where(services:{name:"Location spa"}).joins(:departments).where(departments:{name:@order.department.name})
    end
    @prestataires.each do |prestataire|
      mail(to: prestataire.email, subject: 'Une nouvelle commande pour vous !')
    end
  end

  def new_orderMassage(order_service)
    @oService = OrderService.find(order_service)
    @order = @oService.order
    @date = @order.prestation_date.split("/")
    @date = "#{@date[1]}/#{@date[0]}/#{@date[2]}"
    @prestataires = []
    if @order.department.nil?
      @prestataires = Prestataire.joins(:services).where(services:{name:"Massage"}).joins(:countries).where(countries:{name:@order.country.name})
    else
      @prestataires = Prestataire.joins(:services).where(services:{name:"Massage"}).joins(:departments).where(departments:{name:@order.department.name})
    end
    @prestataires.each do |prestataire|
      mail(to: prestataire.email, subject: 'Une nouvelle commande pour vous !')
    end
  end

end
