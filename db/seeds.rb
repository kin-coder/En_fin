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
Comment.destroy_all

increment = 0
Admin.create(email:"admin@admin.com",password:"admin@admin.com")

# =========================== CREE LES SERVICE =========================== #
s1 = Service.create(name:"Massage")
s2 = Service.create(name:"Location spa")
allServices = [s1,s2]
# ==================== CREATION DE DEPARTEMENT ET PAYS =================== #
listdepartement = [[ "01", "Ain" ],[ "02", "Aisne" ],[ "03", "Allier" ],[ "04", "Alpes-de-Haute-Provence" ],[ "05", "Hautes-alpes" ],[ "06", "Alpes-maritimes" ],[ "07", "Ardèche" ],[ "08", "Ardennes" ],[ "09", "Ariège" ],[ "10", "Aube" ],[ "11", "Aude" ],[ "12", "Aveyron" ],[ "13", "Bouches-du-Rhône" ],[ "14", "Calvados" ],[ "15", "Cantal" ],[ "16", "Charente" ],[ "17", "Charente-maritime" ],[ "18", "Cher" ],[ "19", "Corrèze" ],[ "2a", "Corse-du-sud" ],[ "2b", "Haute-Corse" ],[ "21", "Côte-d'Or" ],[ "22", "Côtes-d'Armor" ],[ "23", "Creuse" ],[ "24", "Dordogne" ],[ "25", "Doubs" ],[ "26", "Drôme" ],[ "27", "Eure" ],[ "28", "Eure-et-loir" ],[ "29", "Finistère" ],[ "30", "Gard" ],[ "31", "Haute-garonne" ],[ "32", "Gers" ],[ "33", "Gironde" ],[ "34", "Hérault" ],[ "35", "Ille-et-vilaine" ],[ "36", "Indre" ],[ "37", "Indre-et-loire" ],[ "38", "Isère" ],[ "39", "Jura" ],[ "40", "Landes" ],[ "41", "Loir-et-cher" ],[ "42", "Loire" ],[ "43", "Haute-loire" ],[ "44", "Loire-atlantique" ],[ "45", "Loiret" ],[ "46", "Lot" ],[ "47", "Lot-et-garonne" ],[ "48", "Lozère" ],[ "49", "Maine-et-loire" ],[ "50", "Manche" ],[ "51", "Marne" ],[ "52", "Haute-marne" ],[ "53", "Mayenne" ],[ "54", "Meurthe-et-moselle" ],[ "55", "Meuse" ],[ "56", "Morbihan" ],[ "57", "Moselle" ],[ "58", "Nièvre" ],[ "59", "Nord" ],[ "60", "Oise" ],[ "61", "Orne" ],[ "62", "Pas-de-calais" ],[ "63", "Puy-de-dôme" ],[ "64", "Pyrénées-atlantiques" ],[ "65", "Hautes-Pyrénées" ],[ "66", "Pyrénées-orientales" ],[ "67", "Bas-rhin" ],[ "68", "Haut-rhin" ],[ "69", "Rhône" ],[ "70", "Haute-saône" ],[ "71", "Saône-et-loire" ],[ "72", "Sarthe" ],[ "73", "Savoie" ],[ "74", "Haute-savoie" ],[ "75", "Paris" ],[ "76", "Seine-maritime" ],[ "77", "Seine-et-marne" ],[ "78", "Yvelines" ],[ "79", "Deux-sèvres" ],[ "80", "Somme" ],[ "81", "Tarn" ],[ "82", "Tarn-et-garonne" ],[ "83", "Var" ],[ "84", "Vaucluse" ],[ "85", "Vendée" ],[ "86", "Vienne" ],[ "87", "Haute-vienne" ],[ "88", "Vosges" ],[ "89", "Yonne" ],[ "90", "Territoire de belfort" ],[ "91", "Essonne" ],[ "92", "Hauts-de-seine" ],[ "93", "Seine-Saint-Denis" ],[ "94", "Val-de-marne" ],[ "95", "Val-d'oise" ],["971","guadeloupe"],["972","martinique"],["973","guyane"],["974","La Réunion"],["976","Mayotte"]]

["Belgique","Luxembourg","Suisse"].each do |pays|
	Country.create(name: pays)
end

Country.find_by(name:"Belgique").services = [s1]
Country.find_by(name:"Suisse").services = [s2]

country = Country.create(name: "France")
# ======================== PRESTATAIRES ====================== #
		#creation département et prestataire
listdepartement.each do |listdepartement|
	d = Department.create(code: listdepartement[0], name: listdepartement[1], country: country)
	d.services = allServices[rand(2)..rand(2)]
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
["Massage Crâne, nuque & épaules","Ce massage sollicite particulièrement les zones soumises au stress de la vie quotidienne en stimulant les zones réflexes et énergétiques. Il dénoue et agit sur vos tensions accumulées au niveau des épaules, de la nuque et du cuir chevelu. Ce massage vous procure un bien-être physique et psychique. Vous vous sentirez complètement détendu(e). Le massage Crâne, Nuque & Épaules est spécialement recommandé si vous passez du temps devant l’ordinateur ou en voiture, car il rétablira les maux créés sur une région qui supporte le poids de votre tête ou une position pas toujours la mieux adaptée."]]
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
	if [2,3,5,8].include?(nombre)
		sub.massage_su_prices = MassageSuPrice.where(duration:[60,90,120])
	end
end
i = 1
sus.each do |su|
	sub = MassageSu.create(name:su[0], description:su[1], massage_ca:ca1)
	addprice(i,sub)
	sub = MassageSu.create(name:su[0], description:su[1], massage_ca:ca2)
	addprice(i,sub)
	i += 1
	puts increment+=1
end
sufemme = MassageSu.create(name:special[0], description:special[1], massage_ca:ca2)
addprice(8,sufemme)
# ========================= CREE LES SERVICE SPA ========================= #
Spa.create(duration: 24, exceptional_price: 180, ordinary_price: 100, exceptional_acompte: 50, ordinary_acompte: 30, service: s2)
Spa.create(duration: 48, exceptional_price: 230, ordinary_price: 150, exceptional_acompte: 65, ordinary_acompte: 45, service: s2)
Spa.create(duration: 72, exceptional_price: 280, ordinary_price: 200, exceptional_acompte: 75, ordinary_acompte: 60, service: s2)
	# ~~~~~~~~~ idée option pour spa
r = Product.create(name:"Romantique", description: "Ballons, pétales de roses, bougies & spot lumineux", price: 20, is_option_spa: true)
a = Product.create(name:"Anniversaire", description: "Ballons, confettis, accessoires anniversaire & spot lumineux", price: 20, is_option_spa: true)
Product.create(name:"Personnalisée", description: "Event/Fête, décoration personnalisée pour nouvel an, noël, fête des pères/mères, EVJF, Girly, Zen, etc…", price: 30, is_option_spa: true)
	# ~~~~~~~~~ idée cadeau
Product.create(name: "Fontaine chocolat", description: "Fournie avec chocolat", price: 20)
Product.create(name: "Petits fours", description: "gateau", price: 20)
Product.create(name: "Plateau de fruits frais", description: "Pour 2 personnes", price: 20)
Product.create(name: "Table de massage", description: "Fournie avec huile de massage", price: 25)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
	# Seed pour les comments
listavis = [
	[5, "Super prestation effet de surprise garantie Décoration exceptionnelle mais je tiens surtout à souligner le professionnalisme de cette société Comme On en voit très peu de nos jours. Merci encore a toutes l'équipe.", "Vanessa Guez"], 
	[5, "Prestation au top.. rapidité extrême. Ayant réservé à 13h pour être en place à 19h.. top qualité, 24h de bonheur dans son salon. Je recommande à ceux qui veulent passer un bon moment chez eux. Honnêtement c'est génial je recommencerais.", "Sami Tessier"],
	[5,"Idée originale, très bon service et efficace","Michouu Moukengué"],
	[5, "Excellent juste parfait pour notre part ! Bonne organisation et montage propre rien à dire ,nous avons passés un excellent moment à notre domicile avec le j'acuzzi et la personne qui monte le j'acuzzi est au top !!", "Cameron LO RE"], 
	[5, "24h de magie à domicile . Ponctuel, professionnel, discret, n'hésitez pas à contacter Cocooning spa pour une surprise sur mesure. Nous avons passé des moments inoubliables dans l'intimité d'un chez soi, c'est mieux qu'à l'hôtel !", "Angé Lique"],
	[5, "Effet de surprise garantie pour ce pack cocooning. 3 jours ou nous avons apprécié ce moment de détente absolu chez soi. A refaire très vite!! Equipe dynamique et commerciale!!! A recommander vivement", "Silvia La Toune"], 
	[5, "Merci beaucoup pour cette prestation, service professionnel et rapide, je recommande à 100%.", "Nicolas Altenburger"]
]
listavis.each do |avis|
	c = Comment.create(note: avis[0], content: avis[1], user_name: avis[2])
	puts "Comment-#{c.id}"
end

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
	# Creation d'exemple de code promo
["HULK","SPACADEAU","GRENOUILLE","PINOK","GANA"].each do |code|
	puts "Code promoe -#{code}"
	CodePromo.create(code:code)
end
 
=begin

(les services spa et massage s’affichent si activés dans la zone, les produits upsell s’affichent tout le temps pour n’importe quelle zone géographique)
Selection pays : France, Belgique, Luxembourg ou suisse
Si France sélectionné, selection du département (tous les dpts du 01 au 95 et dom tom : 971 guadeloupe, 972martinique, 973 guyane, 974 La Réunion, 976 Mayotte)

Affichage des services en fonction de la zone sélectionnée

LES SERVICES NE S’AFFICHENT QUE SI ILS SONT PRESENTS DANS LA ZONE SELECTIONNEE. Si seulement l’un ou l’autre est present, n’afficher que celui ci. Si aucun service dans la zone, afficher le message suivant : 

“ Oups, le service n’est pas disponible actuellement dans votre zone ! Nous oeuvrons pour qu’il le soit prochainement. “

Texte en dessous en petit : Notre service massage à domicile est 
disponible partout en France, Belgique, Luxembourg & Suisse
Alors n’attendez plus, nous ne sommes pas loin de chez vous !


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