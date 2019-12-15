Service.destroy_all
Category.destroy_all
Subcategory.destroy_all
Order.destroy_all

Client.create(email: "email@mail.com", password:"email@mail.com",first_name: "Trump", last_name: "Donald", adresse: "Lot 34 Maparue 3009", tel: "03902094902403")

s3 = Service.create(name:"Massage")
s4 = Service.create(name:"Location spa")

# ====================== MASSAGE =============================#

c = []
["Homme","Femme"].each do |value|
	c.push(Category.create(name: value, service:s3))
	puts value
end

subcategiesFemme = ["Pré natal","Plantaire","Réflexologie Plantaire","Assis","Deep Tissue"]

subcategiesFemme.each do |value|
	Subcategory.create(name:value, price:rand(9.0 .. 30).to_s[0 .. 4].to_f, category:c[0])
	puts value
end

subcategiesHomme = ["Découverte","Dos","Assis","Relaxant","Lomi-Lomi","Ayuvédique"]

subcategiesHomme.each do |value|
	Subcategory.create(name:value, price:rand(9.0 .. 30).to_s[0 .. 4].to_f, category:c[1])
	puts value
end
