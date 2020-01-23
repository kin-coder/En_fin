Service.destroy_all
Category.destroy_all
Subcategory.destroy_all
Order.destroy_all
Country.destroy_all
Prestataire.destroy_all
Client.destroy_all
Admin.destroy_all

increment = 0

Admin.create(email:"admin@admin.com",password:"admin@admin.com")

s3 = Service.create(name:"Massage")
s4 = Service.create(name:"Location spa")

# =================== PRODUITS ========================== #

listProduits1 = ["HUILE VEGETALE DE RICIN BIO 100ML","PROPOS'NATURE HUILE VEGETALE DE RICIN BIO 100ML"  ,"Huile végétale de Ricin Bio  Ricinus communis","HUILE VEGETALE DE COCO BIO 100ML","PROPOS'NATURE HUILE VEGETALE DE COCO BIO 100ML","Huile végétale de Coco Bio  Coco nucifera","URGO CREME CHAUFFANTE MASSAGE 100ML","URGO URGO CREME CHAUFFANTE MASSAGE 100ML"]

listProduits1.each do |produit|
	Product.create(name: produit, price: rand(9.0 .. 30).to_s[0 .. 4].to_f, service: s3)
	puts increment+=1
end

Product.create(service: s4,name:"Décoration Romantique",description:"Ballons, pétales de roses, bougies, lumière tamisée",price:20)
Product.create(service: s4,name:"Décoration Anniversaire",description:"Ballons hélium & ballons normaux, confettis, lumière d’ambiance",price:25)
Product.create(service: s4,name:"Fontaine à chocolat",description:"(fournie avec chocolat)",price:23)
Product.create(service: s4,name:"Plateau de fruits frais",description:"(pour deux personnes)",price:21)
Product.create(service: s4,name:"Table de massage",description:"(fournie avec huile)",price:25)
Product.create(service: s4,name:"Cocktail",description:"Cocktail",price:20)
Product.create(service: s4,name:"Jeux ",description:"Ballons hélium & ballons normaux, confettis, lumière d’ambiance",price:25)
Product.create(service: s4,name:"Divers abimations",description:"Lorem ipsum dolor sit amet.
",price:23)

# ============== CREATION DE DEPARTEMENT ET PAYS ============= #
listdepartement = [[ "01", "Ain" ],[ "02", "Aisne" ],[ "03", "Allier" ],[ "04", "Alpes-de-Haute-Provence" ],[ "05", "Hautes-alpes" ],[ "06", "Alpes-maritimes" ],[ "07", "Ardèche" ],[ "08", "Ardennes" ],[ "09", "Ariège" ],[ "10", "Aube" ],[ "11", "Aude" ],[ "12", "Aveyron" ],[ "13", "Bouches-du-Rhône" ],[ "14", "Calvados" ],[ "15", "Cantal" ],[ "16", "Charente" ],[ "17", "Charente-maritime" ],[ "18", "Cher" ],[ "19", "Corrèze" ],[ "2a", "Corse-du-sud" ],[ "2b", "Haute-Corse" ],[ "21", "Côte-d'Or" ],[ "22", "Côtes-d'Armor" ],[ "23", "Creuse" ],[ "24", "Dordogne" ],[ "25", "Doubs" ],[ "26", "Drôme" ],[ "27", "Eure" ],[ "28", "Eure-et-loir" ],[ "29", "Finistère" ],[ "30", "Gard" ],[ "31", "Haute-garonne" ],[ "32", "Gers" ],[ "33", "Gironde" ],[ "34", "Hérault" ],[ "35", "Ille-et-vilaine" ],[ "36", "Indre" ],[ "37", "Indre-et-loire" ],[ "38", "Isère" ],[ "39", "Jura" ],[ "40", "Landes" ],[ "41", "Loir-et-cher" ],[ "42", "Loire" ],[ "43", "Haute-loire" ],[ "44", "Loire-atlantique" ],[ "45", "Loiret" ],[ "46", "Lot" ],[ "47", "Lot-et-garonne" ],[ "48", "Lozère" ],[ "49", "Maine-et-loire" ],[ "50", "Manche" ],[ "51", "Marne" ],[ "52", "Haute-marne" ],[ "53", "Mayenne" ],[ "54", "Meurthe-et-moselle" ],[ "55", "Meuse" ],[ "56", "Morbihan" ],[ "57", "Moselle" ],[ "58", "Nièvre" ],[ "59", "Nord" ],[ "60", "Oise" ],[ "61", "Orne" ],[ "62", "Pas-de-calais" ],[ "63", "Puy-de-dôme" ],[ "64", "Pyrénées-atlantiques" ],[ "65", "Hautes-Pyrénées" ],[ "66", "Pyrénées-orientales" ],[ "67", "Bas-rhin" ],[ "68", "Haut-rhin" ],[ "69", "Rhône" ],[ "70", "Haute-saône" ],[ "71", "Saône-et-loire" ],[ "72", "Sarthe" ],[ "73", "Savoie" ],[ "74", "Haute-savoie" ],[ "75", "Paris" ],[ "76", "Seine-maritime" ],[ "77", "Seine-et-marne" ],[ "78", "Yvelines" ],[ "79", "Deux-sèvres" ],[ "80", "Somme" ],[ "81", "Tarn" ],[ "82", "Tarn-et-garonne" ],[ "83", "Var" ],[ "84", "Vaucluse" ],[ "85", "Vendée" ],[ "86", "Vienne" ],[ "87", "Haute-vienne" ],[ "88", "Vosges" ],[ "89", "Yonne" ],[ "90", "Territoire de belfort" ],[ "91", "Essonne" ],[ "92", "Hauts-de-seine" ],[ "93", "Seine-Saint-Denis" ],[ "94", "Val-de-marne" ],[ "95", "Val-d'oise" ]]
country = Country.create(name: "France")

# ======================== PRESTATAIRES ====================== #
		#== creation département et prestataire ==#
listdepartement.each do |listdepartement|
  d = Department.create(code: listdepartement[0], namedepartment: listdepartement[1], country: country)
  rand(5).times do |i|
	p = Prestataire.create(email: Faker::Internet.free_email, first_name: Faker::Name.first_name, last_name: Faker::Name.middle_name , adresse: Faker::Address.full_address, tel: Faker::PhoneNumber.phone_number_with_country_code, raison_sociale: Faker::Commerce.department, siret: Faker::Number.leading_zero_number(digits: 10))
	# Selection du zone qu'il peut faire
	p.departments = [d]
	# Selection des services que le prestataire peut faire
	p.services = [Service.find(rand(1..2))]
	puts increment+=1
  end
end

# ====================== LOCATION SPA ========================== #
c = Category.create(name: "Location spa", service:s4)
puts increment+=1

i = 0
["24","48","72"].each do |value|
	Subcategory.create(name:value, price:100+(50*i), category:c)
	puts increment+=1
	i+=1
end

# ====================== MASSAGE =============================== #

c = []
["Homme","Femme"].each do |value|
	c.push(Category.create(name: value, service:s3))
	puts increment+=1
end

["30"].each do |heurs|
	subcategiesFemme = ["Pré natal","Plantaire","Réflexologie Plantaire","Assis","Deep Tissue"]
	subcategiesFemme.each do |value|
		Subcategory.create(name:value, hours:heurs, price:rand(9.0 .. 30).to_s[0 .. 4].to_f, category:c[1])
		puts increment+=1
	end

	subcategiesHomme = ["Découverte","Dos","Assis","Relaxant","Lomi-Lomi","Ayuvédique"]
	subcategiesHomme.each do |value|
		Subcategory.create(name:value, hours:heurs, price:rand(9.0 .. 30).to_s[0 .. 4].to_f, category:c[0])
		puts increment+=1
	end
end

# ====================== COMMANDE ============================= #

10.times do |i|
	c = Client.create(email: Faker::Internet.free_email, password:"email@mail.com",first_name: Faker::Name.first_name, last_name: Faker::Name.middle_name, adresse: Faker::Address.full_address, tel: Faker::PhoneNumber.phone_number_with_country_code)
	o = Order.create(client: c,service:s3)
	o.date = "20/01/20"
    o.hours = "12:30"
	o.adresse = c.adresse
	o.message = Faker::Quotes::Shakespeare.king_richard_iii_quote
	o.save
	o.department = Department.find(rand(Department.first.id .. Department.last.id))
	key = rand(2)
	orderCategory = OrderCategory.create(order: o, category: s3.categories[key])
	orderCategory.subcategories = s3.categories[key].subcategories[0..rand(4)]
	puts increment+=1
end
# ============================================================== #
