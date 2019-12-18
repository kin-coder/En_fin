Service.destroy_all
Category.destroy_all
Subcategory.destroy_all
Order.destroy_all
Country.destroy_all
Prestataire.destroy_all

s3 = Service.create(name:"Massage")
s4 = Service.create(name:"Location spa")

# ============== CREATION DE DEPARTEMENT ET PAYS ============= #
listdepartement = [[ "01", "Ain" ],[ "02", "Aisne" ],[ "03", "Allier" ],[ "04", "Alpes-de-Haute-Provence" ],[ "05", "Hautes-alpes" ],[ "06", "Alpes-maritimes" ],[ "07", "Ardèche" ],[ "08", "Ardennes" ],[ "09", "Ariège" ],[ "10", "Aube" ],[ "11", "Aude" ],[ "12", "Aveyron" ],[ "13", "Bouches-du-Rhône" ],[ "14", "Calvados" ],[ "15", "Cantal" ],[ "16", "Charente" ],[ "17", "Charente-maritime" ],[ "18", "Cher" ],[ "19", "Corrèze" ],[ "2a", "Corse-du-sud" ],[ "2b", "Haute-Corse" ],[ "21", "Côte-d'Or" ],[ "22", "Côtes-d'Armor" ],[ "23", "Creuse" ],[ "24", "Dordogne" ],[ "25", "Doubs" ],[ "26", "Drôme" ],[ "27", "Eure" ],[ "28", "Eure-et-loir" ],[ "29", "Finistère" ],[ "30", "Gard" ],[ "31", "Haute-garonne" ],[ "32", "Gers" ],[ "33", "Gironde" ],[ "34", "Hérault" ],[ "35", "Ille-et-vilaine" ],[ "36", "Indre" ],[ "37", "Indre-et-loire" ],[ "38", "Isère" ],[ "39", "Jura" ],[ "40", "Landes" ],[ "41", "Loir-et-cher" ],[ "42", "Loire" ],[ "43", "Haute-loire" ],[ "44", "Loire-atlantique" ],[ "45", "Loiret" ],[ "46", "Lot" ],[ "47", "Lot-et-garonne" ],[ "48", "Lozère" ],[ "49", "Maine-et-loire" ],[ "50", "Manche" ],[ "51", "Marne" ],[ "52", "Haute-marne" ],[ "53", "Mayenne" ],[ "54", "Meurthe-et-moselle" ],[ "55", "Meuse" ],[ "56", "Morbihan" ],[ "57", "Moselle" ],[ "58", "Nièvre" ],[ "59", "Nord" ],[ "60", "Oise" ],[ "61", "Orne" ],[ "62", "Pas-de-calais" ],[ "63", "Puy-de-dôme" ],[ "64", "Pyrénées-atlantiques" ],[ "65", "Hautes-Pyrénées" ],[ "66", "Pyrénées-orientales" ],[ "67", "Bas-rhin" ],[ "68", "Haut-rhin" ],[ "69", "Rhône" ],[ "70", "Haute-saône" ],[ "71", "Saône-et-loire" ],[ "72", "Sarthe" ],[ "73", "Savoie" ],[ "74", "Haute-savoie" ],[ "75", "Paris" ],[ "76", "Seine-maritime" ],[ "77", "Seine-et-marne" ],[ "78", "Yvelines" ],[ "79", "Deux-sèvres" ],[ "80", "Somme" ],[ "81", "Tarn" ],[ "82", "Tarn-et-garonne" ],[ "83", "Var" ],[ "84", "Vaucluse" ],[ "85", "Vendée" ],[ "86", "Vienne" ],[ "87", "Haute-vienne" ],[ "88", "Vosges" ],[ "89", "Yonne" ],[ "90", "Territoire de belfort" ],[ "91", "Essonne" ],[ "92", "Hauts-de-seine" ],[ "93", "Seine-Saint-Denis" ],[ "94", "Val-de-marne" ],[ "95", "Val-d'oise" ]]
country = Country.create(name: "France")

# ======================== PRESTATAIRES ====================== #
listdepartement.each do |listdepartement|
  d = Department.create(code: listdepartement[0], namedepartment: listdepartement[1], country: country)
  puts listdepartement[0]
  rand(5).times do |i|
	p = Prestataire.create(email: Faker::Internet.free_email, first_name: Faker::Name.first_name, last_name: Faker::Name.middle_name , adresse: Faker::Address.full_address, tel: Faker::PhoneNumber.phone_number_with_country_code, raison_sociale: Faker::Commerce.department, siret: Faker::Number.leading_zero_number(digits: 10))
	# Selection du zone qu'il peut faire
	p.departments = [d]
	# Selection des services que le prestataire peut faire
	p.services = [Service.find(rand(1..2))]
	puts i
  end
end
# ====================== COMMANDE ============================= #

Client.create(email: "email@mail.com", password:"email@mail.com",first_name: "Trump", last_name: "Donald", adresse: "Lot 34 Maparue 3009", tel: "03902094902403")

# ====================== MASSAGE ============================== #

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
# ============================================================ #
