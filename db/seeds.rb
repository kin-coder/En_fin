Service.destroy_all
Category.destroy_all
Subcategory.destroy_all
Country.destroy_all
Prestataire.destroy_all
Client.destroy_all
Admin.destroy_all

increment = 0
Admin.create(email:"admin@admin.com",password:"admin@admin.com")

# =========================== CREE LES SERVICE =========================== #
s1 = Service.create(name:"Massage")
s2 = Service.create(name:"Location spa")

# ==================== CREATION DE DEPARTEMENT ET PAYS =================== #
listdepartement = [[ "01", "Ain" ],[ "02", "Aisne" ],[ "03", "Allier" ],[ "04", "Alpes-de-Haute-Provence" ],[ "05", "Hautes-alpes" ],[ "06", "Alpes-maritimes" ],[ "07", "Ardèche" ],[ "08", "Ardennes" ],[ "09", "Ariège" ],[ "10", "Aube" ],[ "11", "Aude" ],[ "12", "Aveyron" ],[ "13", "Bouches-du-Rhône" ],[ "14", "Calvados" ],[ "15", "Cantal" ],[ "16", "Charente" ],[ "17", "Charente-maritime" ],[ "18", "Cher" ],[ "19", "Corrèze" ],[ "2a", "Corse-du-sud" ],[ "2b", "Haute-Corse" ],[ "21", "Côte-d'Or" ],[ "22", "Côtes-d'Armor" ],[ "23", "Creuse" ],[ "24", "Dordogne" ],[ "25", "Doubs" ],[ "26", "Drôme" ],[ "27", "Eure" ],[ "28", "Eure-et-loir" ],[ "29", "Finistère" ],[ "30", "Gard" ],[ "31", "Haute-garonne" ],[ "32", "Gers" ],[ "33", "Gironde" ],[ "34", "Hérault" ],[ "35", "Ille-et-vilaine" ],[ "36", "Indre" ],[ "37", "Indre-et-loire" ],[ "38", "Isère" ],[ "39", "Jura" ],[ "40", "Landes" ],[ "41", "Loir-et-cher" ],[ "42", "Loire" ],[ "43", "Haute-loire" ],[ "44", "Loire-atlantique" ],[ "45", "Loiret" ],[ "46", "Lot" ],[ "47", "Lot-et-garonne" ],[ "48", "Lozère" ],[ "49", "Maine-et-loire" ],[ "50", "Manche" ],[ "51", "Marne" ],[ "52", "Haute-marne" ],[ "53", "Mayenne" ],[ "54", "Meurthe-et-moselle" ],[ "55", "Meuse" ],[ "56", "Morbihan" ],[ "57", "Moselle" ],[ "58", "Nièvre" ],[ "59", "Nord" ],[ "60", "Oise" ],[ "61", "Orne" ],[ "62", "Pas-de-calais" ],[ "63", "Puy-de-dôme" ],[ "64", "Pyrénées-atlantiques" ],[ "65", "Hautes-Pyrénées" ],[ "66", "Pyrénées-orientales" ],[ "67", "Bas-rhin" ],[ "68", "Haut-rhin" ],[ "69", "Rhône" ],[ "70", "Haute-saône" ],[ "71", "Saône-et-loire" ],[ "72", "Sarthe" ],[ "73", "Savoie" ],[ "74", "Haute-savoie" ],[ "75", "Paris" ],[ "76", "Seine-maritime" ],[ "77", "Seine-et-marne" ],[ "78", "Yvelines" ],[ "79", "Deux-sèvres" ],[ "80", "Somme" ],[ "81", "Tarn" ],[ "82", "Tarn-et-garonne" ],[ "83", "Var" ],[ "84", "Vaucluse" ],[ "85", "Vendée" ],[ "86", "Vienne" ],[ "87", "Haute-vienne" ],[ "88", "Vosges" ],[ "89", "Yonne" ],[ "90", "Territoire de belfort" ],[ "91", "Essonne" ],[ "92", "Hauts-de-seine" ],[ "93", "Seine-Saint-Denis" ],[ "94", "Val-de-marne" ],[ "95", "Val-d'oise" ]]
country = Country.create(name: "France")

# ======================== PRESTATAIRES ====================== #
		#creation département et prestataire
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

# ======================= CREE LES SERVICE MASSAGE ======================= #
#<Category id: nil, name: nil, service_id: nil, created_at: nil, updated_at: nil>
h = Category.create(name:"Homme", service:s1)
f = Category.create(name:"Femme", service:s1)
#<Subcategory id: nil, name: nil, description: nil, price: nil, duration: nil, category_id: nil, created_at: nil, updated_at: nil>




# ========================= CREE LES SERVICE SPA ========================= #


# ======================== ENREGISTREMENT DES PRIX ======================= #








=begin
Liste des table

Service

Category

Subcategory

Country

Department

Client

Candidate

PrestataireDepartment

PrestataireService

Prestataire

Admin

Order

OrderService

OrderServiceCa

OrderServiceCaSu

OrderServiceCaSpa

Product

DevisPrestation

DevisPrestationSubcategory



Homme
Classique / découverte (30min, 60min, 90min, 120min)
Anti-stress / relaxant (60min, 90min, 120min)
Sportif (60min, 90min, 120min)
Réflexologie plantaire (30min, 60min, 90min, 120min)
Pieds & Mains (60min, 90min, 120min)
Dos (30min, 60min, 90min, 120min)
Crâne, nuque & épaules (30min, 60min, 90min, 120min)
Massage assis (30min)

Femme
Classique / découverte (30min, 60min, 90min, 120min)
Anti-stress / relaxant (60min, 90min, 120min)
Sportif (60min, 90min, 120min)
Réflexologie plantaire (30min, 60min, 90min, 120min)
Pieds & Mains (60min, 90min, 120min)
Dos (30min, 60min, 90min, 120min)
Crâne, nuque & épaules (30min, 60min, 90min, 120min)
Massage assis (30min)
Pré natal (60min, 90min, 120min)

=end