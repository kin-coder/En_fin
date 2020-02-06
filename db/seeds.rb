Admin.destroy_all
Candidate.destroy_all
Client.destroy_all
Country.destroy_all
Department.destroy_all
Prestataire.destroy_all
PrestataireDepartment.destroy_all
PrestataireService.destroy_all
Service.destroy_all
Spa.destroy_all
MassageCa.destroy_all
MassageSu.destroy_all
MassageSuPrice.destroy_all
OtherSuPrice.destroy_all
Product.destroy_all
Order.destroy_all
OrderMassage.destroy_all
OrderProduct.destroy_all
OrderService.destroy_all
OrderSpa.destroy_all

increment = 0
Admin.create(email:"admin@admin.com",password:"admin@admin.com")
Client.create(email: "faly@google.fr", password:"faly@google.fr", first_name: "san", last_name: "goku", adresse: "Lot 404 Bassé", tel: "0239732768362", sexe: "homme")

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
sus = [["Massage Classique / découverte","Le massage classique est un traitement qui agit sur chaque partie du corps les unes après les autres. Il se pratique par pétrissage, lissage, vibration ou par des mouvements plus petits et plus subtils sur les points de tension. Il s’agit d’un massage global relaxant qui en plus de soulager les tensions musculaires superficielles et profondes, possède de multiples actions thérapeutiques. Il permet de renforcer le système immunitaire, d’améliorer les fonctions digestives, de stimuler la vitalité des tissus, favoriser une bonne circulation sanguine et d’apaiser les tensions nerveuses. Le massage classique est recommandé pour les insomnies, les angoisses, le stress, la nervosité, la constipation, les migraines."],
["Massage Anti-stress / relaxant","Le massage anti-stress est source de détente, en enlevant les nœuds musculaires et en optimisant la circulation sanguine et lymphatique. Il élimine stress et anxiété. Il élimine ainsi les toxines à l’origine des dépressions. Une fois les tensions dissipées, l’organisme se relaxe, les muscles et articulations retrouvent leur souplesse. Cette action se répercute directement sur le cerveau puisque l’évacuation des toxines optimise son oxygénation.
Son application régulière permet de réguler la tension artérielle, d’apaiser certains troubles liés aux maladies cardio-vasculaires, de soulager les problèmes respiratoires graves comme l’asthme, de mettre un terme à l’insomnie."],
["Massage Sportif","Par le massage de préparation, le masseur contribue à la mise en forme du sportif. Il lui permet d’affronter la compétition, d’éviter les blessures et de diminuer le trac. Par le massage de récupération, le masseur aide à une récupération plus rapide par le drainage des toxines, par une diminution de la fatigue.
Préserver son énergie et éviter les « coups de pompe » est un élément de la vie professionnelle d’aujourd’hui. Retrouver rapidement ses capacités physiques et sa vigilance après un effort est essentiel."],
["Réflexologie plantaire","La réflexologie plantaire est une thérapie manuelle fondée sur l’existence au niveau des pieds de zones réflexes représentant chaque organe du corps. Lorsque ces zones sont activées par simple pression, l’état de l’organe est amélioré ou redynamisé.
Nos pieds recueillant environ 7200 terminaisons nerveuses, il est possible, par simple pression des doigts à des endroits précis de la plante et du dos du pied, d’agir à distance sur certaines régions de l’organisme."],
["Massage Pieds & Mains","Les pieds supportent le poids de notre corps et sont sujets à de nombreuses agressions extérieures comme le sol dur ou des chaussures inconfortables. Ils sont composés d’une multitude de terminaisons nerveuses qui influent sur l’ensemble de notre organisme. Les mains font parties des endroits les plus sensibles de notre corps. Elles renferment de nombreuses terminaisons nerveuses qui sont en communication constante avec notre cerveau. Sollicitées en permanence, elles sont les premières victimes de nos stress et fatigues. Le massage des mains et des pieds contribue à l’élimination du stress, à la décontraction et aide à diminuer les émotions négatives. Il vous procurera une énorme sensation de bien-être et de détente."],
["Massage du Dos","Le massage du dos est source de relaxation et de détente après une journée éprouvante ou juste pour se faire plaisir une fois de temps en temps. Ses bienfaits sont innombrables, il permet notamment de tonifier, de relaxer et de stimuler le dos qui est une des zones du corps les plus sujettes aux tensions. En effet, de très nombreux et puissants muscles sont sollicités dans cette région et il est possible de les soulager en les massant. Le dos souffre de notre rythme de vie et de nos mauvaises postures, le dos est un peu l’endroit où tout notre stress et notre fatigue sont stockés. Ce massage permet d’évacuer le stress, de reposer votre dos et donc d’apporter une énergie nouvelle."],
["Massage Crâne, nuque & épaules","Ce massage sollicite particulièrement les zones soumises au stress de la vie quotidienne en stimulant les zones réflexes et énergétiques. Il dénoue et agit sur vos tensions accumulées au niveau des épaules, de la nuque et du cuir chevelu. Ce massage vous procure un bien-être physique et psychique. Vous vous sentirez complètement détendu(e). Le massage Crâne, Nuque & Épaules est spécialement recommandé si vous passez du temps devant l’ordinateur ou en voiture, car il rétablira les maux créés sur une région qui supporte le poids de votre tête ou une position pas toujours la mieux adaptée."],
["Massage assis","C’est un massage qui se pratique assis sur une table de massage adaptée. Il permet de profiter de tous les bienfaits d’un massage, même quand on est pressé. Ce massage est particulièrement bénéfique si vous ressentez des tensions dans le dos."]]
special = ["Massage pré natal","Les massages peuvent faire énormément de bien aux femmes enceintes et soulager les ventres douloureux. Ce qui est bon pour la maman est en général bon pour le foetus ! Les massages permettent à la maman de se détendre et de se sentir mieux."]
	# ~~~~~~~~~~~~~~~~ enregistrement des prix ~~~~~~~~~~~~~~~~~ #
#<MassageSuPrice id: nil, duration: nil, exceptional_price: nil, ordinary_price: nil, exceptional_acompte: nil, ordinary_acompte: nil, created_at: nil, updated_at: nil>
MassageSuPrice.create(duration: 30, exceptional_price: 70, ordinary_price: 50, exceptional_acompte: 30, ordinary_acompte: 20)

MassageSuPrice.create(duration: 60, exceptional_price: 90, ordinary_price: 70, exceptional_acompte: 30, ordinary_acompte: 20)

MassageSuPrice.create(duration: 90, exceptional_price: 110, ordinary_price: 90, exceptional_acompte: 30, ordinary_acompte: 20)

MassageSuPrice.create(duration: 120, exceptional_price: 130, ordinary_price: 110, exceptional_acompte: 30, ordinary_acompte: 20)

puts increment+=1

#<MassageCa id: nil, name: nil, service_id: nil, created_at: nil, updated_at: nil>
ca1 = MassageCa.create(name:"Homme", service:s1)
ca2 = MassageCa.create(name:"Femme", service:s1)
#<MassageSu id: nil, name: nil, description: nil, massage_ca_id: nil, created_at: nil, updated_at: nil>

def addprice(nombre,sub)
	if [1,4,6,7].include?(nombre)
		sub.massage_su_prices = MassageSuPrice.where(duration:[30,60,90,120])
	end
	if [2,3,5,9].include?(nombre)
		sub.massage_su_prices = MassageSuPrice.where(duration:[60,90,120])
	end
	if nombre == 8
		sub.massage_su_prices = MassageSuPrice.where(duration:30)
	end
end
i = 1
sus.each do |su|
	sub = MassageSu.create(name:su[0], description:su[1], massage_ca:ca1)
	addprice(i,sub)
	i += 1
	puts increment+=1
end
sufemme = MassageSu.create(name:special[0], description:special[1], massage_ca:ca2)
addprice(9,sufemme)
# ========================= CREE LES SERVICE SPA ========================= #
Spa.create(duration: 24, exceptional_price: 180, ordinary_price: 100, exceptional_acompte: 50, ordinary_acompte: 30, service: s2)
Spa.create(duration: 48, exceptional_price: 230, ordinary_price: 150, exceptional_acompte: 65, ordinary_acompte: 45, service: s2)
Spa.create(duration: 72, exceptional_price: 280, ordinary_price: 200, exceptional_acompte: 75, ordinary_acompte: 60, service: s2)

Product.create(name: "Décoration romantique", description: "la décoration romantique est composée de ballons, pétales de roses, bougies, lumière tamisée & spot lumineux dans le spa.", price: 20, is_option_spa: true)
Product.create(name: "Décoration anniversaire / fête", description: "la décoration anniversaire/fête est composée de ballons, masques anniversaire/fête, lumière d’ambiance & spot lumineux dans le spa.", price: 20, is_option_spa: true)
Product.create(name: "Fontaine chocolat (fournie avec chocolat)", description: "fournie avec chocolat", price: 20, is_option_spa: true)
Product.create(name: "Plateau de fruits frais (pour 2p)", description: "pour 2 personnes", price: 20, is_option_spa: true)
Product.create(name: "Table de massage (fournie avec huile de massage)", description: "fournie avec huile de massage", price: 25, is_option_spa: true)
 # ~~~~~~~~~ idée cadeau
Product.create(name: "Cadeau 1", description: "#####", price: 20)
Product.create(name: "Cadeau 2", description: "#####", price: 20)
Product.create(name: "Cadeau 3", description: "#####", price: 20)
Product.create(name: "Cadeau 4", description: "#####", price: 20)
# ===================== ENREGISTREMENT D'UNE COMMANDE ===================== #

# Order
# OrderMassage
# OrderProduct
# OrderService
# OrderSpa

# ~~~~~ Order 1
o1 = Order.create(prestation_date: Date.new, prestation_time: Time.now, billing_pays: "Madagascar", billing_ville: "Antananarivo", billing_code_postal: "301", billing_adresse: "Lot Ter Mandona JS", delivery_pays: "Madagascar", delivery_ville: "Antananarivo", delivery_code_postal: "490", delivery_adresse: "Lot KDD 34 ld", message: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam", client: Client.first, department: Department.first, praticien:"Homme")
OrderService.create(order: o1, service: Service.first)
OrderMassage.create(order: o1, massage_ca:MassageSu.first.massage_ca, massage_su: MassageSu.first, massage_su_price: MassageSu.first.massage_su_prices[0])
OrderMassage.create(order: o1, massage_ca:MassageSu.first.massage_ca, massage_su: MassageSu.first, massage_su_price: MassageSu.first.massage_su_prices[1])
OrderProduct.create(number: 4, product: Product.find(6), order: o1)
OrderProduct.create(number: 1, product: Product.find(7), order: o1)
# ~~~~~ Order 2
o2 = Order.create(prestation_date: Date.new, prestation_time: Time.now, billing_pays: "France", billing_ville: "Paris", billing_code_postal: "301", billing_adresse: "Lot Ter Mandona JS", delivery_pays: "France", delivery_ville: "Paris", delivery_code_postal: "490", delivery_adresse: "Lot KDD 34 ld", message: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam", client: Client.first, department: Department.first, praticien:"Femme")
OrderService.create(order: o2, service: Service.first)
OrderService.create(order: o2, service: Service.last)
OrderMassage.create(order: o2, massage_ca:MassageSu.last.massage_ca, massage_su: MassageSu.last, massage_su_price: MassageSu.last.massage_su_prices[0])
OrderMassage.create(order: o2, massage_ca:MassageSu.last.massage_ca, massage_su: MassageSu.last, massage_su_price: MassageSu.last.massage_su_prices[0])
OrderProduct.create(number: 2, product: Product.last, order: o2)
# ~~~~~ Reservation Spa
os1 = OrderSpa.create(logement: "Maison", installation: "Interieur", syteme_eau: "eau chaude", order: o2, spa: Spa.first)
os2 = OrderSpa.create(logement: "Villa", installation: "Exterieur", syteme_eau: "eau froide", order: o2, spa: Spa.last)
# ~~~~~ Sauvegrde option Spa
OrderProduct.create(number: 4, product: Product.find(6), order: o1, order_spa:os1)
OrderProduct.create(number: 4, product: Product.find(7), order: o1, order_spa:os1)
OrderProduct.create(number: 4, product: Product.find(8), order: o1, order_spa:os1)
OrderProduct.create(number: 1, product: Product.find(7), order: o1, order_spa:os2)

=begin

Liste des table
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Admin
Candidate
Client
Country
Department

Prestataire
PrestataireDepartment
PrestataireService
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Service

Spa

MassageCa
MassageSu
MassageSuPrice
OtherSuPrice
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Product
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Order
OrderMassage
OrderProduct
OrderService
OrderSpa
~~~~~~~~~~~~~~~~~~~~~~~~~~~

=end