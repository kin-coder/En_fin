
increment = 0

Admin.create(email:'myadmin@gmail.com',password:'myadmin@gmail.com',first_name: "Vincent",last_name: "lae")

# =========================== CREE LES SERVICE =========================== #
s1 = Service.create(name:"Massage")
s2 = Service.create(name:"Location spa")
# ==================== CREATION DE DEPARTEMENT ET PAYS =================== #
listdepartement = [[ "01", "Ain" ],[ "02", "Aisne" ],[ "03", "Allier" ],[ "04", "Alpes-de-Haute-Provence" ],[ "05", "Hautes-alpes" ],[ "06", "Alpes-maritimes" ],[ "07", "Ardèche" ],[ "08", "Ardennes" ],[ "09", "Ariège" ],[ "10", "Aube" ],[ "11", "Aude" ],[ "12", "Aveyron" ],[ "13", "Bouches-du-Rhône" ],[ "14", "Calvados" ],[ "15", "Cantal" ],[ "16", "Charente" ],[ "17", "Charente-maritime" ],[ "18", "Cher" ],[ "19", "Corrèze" ],[ "2a", "Corse-du-sud" ],[ "2b", "Haute-Corse" ],[ "21", "Côte-d'Or" ],[ "22", "Côtes-d'Armor" ],[ "23", "Creuse" ],[ "24", "Dordogne" ],[ "25", "Doubs" ],[ "26", "Drôme" ],[ "27", "Eure" ],[ "28", "Eure-et-loir" ],[ "29", "Finistère" ],[ "30", "Gard" ],[ "31", "Haute-garonne" ],[ "32", "Gers" ],[ "33", "Gironde" ],[ "34", "Hérault" ],[ "35", "Ille-et-vilaine" ],[ "36", "Indre" ],[ "37", "Indre-et-loire" ],[ "38", "Isère" ],[ "39", "Jura" ],[ "40", "Landes" ],[ "41", "Loir-et-cher" ],[ "42", "Loire" ],[ "43", "Haute-loire" ],[ "44", "Loire-atlantique" ],[ "45", "Loiret" ],[ "46", "Lot" ],[ "47", "Lot-et-garonne" ],[ "48", "Lozère" ],[ "49", "Maine-et-loire" ],[ "50", "Manche" ],[ "51", "Marne" ],[ "52", "Haute-marne" ],[ "53", "Mayenne" ],[ "54", "Meurthe-et-moselle" ],[ "55", "Meuse" ],[ "56", "Morbihan" ],[ "57", "Moselle" ],[ "58", "Nièvre" ],[ "59", "Nord" ],[ "60", "Oise" ],[ "61", "Orne" ],[ "62", "Pas-de-calais" ],[ "63", "Puy-de-dôme" ],[ "64", "Pyrénées-atlantiques" ],[ "65", "Hautes-Pyrénées" ],[ "66", "Pyrénées-orientales" ],[ "67", "Bas-rhin" ],[ "68", "Haut-rhin" ],[ "69", "Rhône" ],[ "70", "Haute-saône" ],[ "71", "Saône-et-loire" ],[ "72", "Sarthe" ],[ "73", "Savoie" ],[ "74", "Haute-savoie" ],[ "75", "Paris" ],[ "76", "Seine-maritime" ],[ "77", "Seine-et-marne" ],[ "78", "Yvelines" ],[ "79", "Deux-sèvres" ],[ "80", "Somme" ],[ "81", "Tarn" ],[ "82", "Tarn-et-garonne" ],[ "83", "Var" ],[ "84", "Vaucluse" ],[ "85", "Vendée" ],[ "86", "Vienne" ],[ "87", "Haute-vienne" ],[ "88", "Vosges" ],[ "89", "Yonne" ],[ "90", "Territoire de belfort" ],[ "91", "Essonne" ],[ "92", "Hauts-de-seine" ],[ "93", "Seine-Saint-Denis" ],[ "94", "Val-de-marne" ],[ "95", "Val-d'oise" ],["971","Guadeloupe"],["972","Martinique"],["973","Guyane"],["974","La Réunion"],["976","Mayotte"]]
country = Country.create(name: "France")
listPays = []
["Belgique","Luxembourg","Suisse"].each do |pays|
	listPays.push(Country.create(name: pays))
end

Country.find_by(name:"Belgique").services = Service.all
Country.find_by(name:"Suisse").services = Service.all
Country.find_by(name:"Luxembourg").services = Service.all

# ======================== PRESTATAIRES ====================== #
# creation département et prestataire
listdepartement.each do |listdepartement|
	d = Department.create(code: listdepartement[0], name: listdepartement[1], country: country)
	d.services = Service.all
end

# ======================= CREE LES SERVICE MASSAGE ======================= #
massageTypeList = [["Massage Classique / Découverte","Le massage classique est un traitement qui agit sur chaque partie du corps les unes après les autres. Il se pratique par pétrissage, lissage, vibration ou par des mouvements plus petits et plus subtils sur les points de tension. Il s’agit d’un massage global relaxant qui en plus de soulager les tensions musculaires superficielles et profondes, possède de multiples actions thérapeutiques. Il permet de renforcer le système immunitaire, d’améliorer les fonctions digestives, de stimuler la vitalité des tissus, favoriser une bonne circulation sanguine et d’apaiser les tensions nerveuses. Le massage classique est recommandé pour les insomnies, les angoisses, le stress, la nervosité, la constipation, les migraines."],
["Massage Anti-stress / Relaxant","Le massage anti-stress est source de détente, en enlevant les nœuds musculaires et en optimisant la circulation sanguine et lymphatique. Il élimine stress et anxiété. Il élimine ainsi les toxines à l’origine des dépressions. Une fois les tensions dissipées, l’organisme se relaxe, les muscles et articulations retrouvent leur souplesse. Cette action se répercute directement sur le cerveau puisque l’évacuation des toxines optimise son oxygénation.
Son application régulière permet de réguler la tension artérielle, d’apaiser certains troubles liés aux maladies cardio-vasculaires, de soulager les problèmes respiratoires graves comme l’asthme, de mettre un terme à l’insomnie."],
["Massage Sportif","Par le massage de préparation, le masseur contribue à la mise en forme du sportif. Il lui permet d’affronter la compétition, d’éviter les blessures et de diminuer le trac. Par le massage de récupération, le masseur aide à une récupération plus rapide par le drainage des toxines, par une diminution de la fatigue.
Préserver son énergie et éviter les « coups de pompe » est un élément de la vie professionnelle d’aujourd’hui. Retrouver rapidement ses capacités physiques et sa vigilance après un effort est essentiel."],
["Réflexologie plantaire","La réflexologie plantaire est une thérapie manuelle fondée sur l’existence au niveau des pieds de zones réflexes représentant chaque organe du corps. Lorsque ces zones sont activées par simple pression, l’état de l’organe est amélioré ou redynamisé.
Nos pieds recueillant environ 7200 terminaisons nerveuses, il est possible, par simple pression des doigts à des endroits précis de la plante et du dos du pied, d’agir à distance sur certaines régions de l’organisme."],
["Massage Pieds & Mains","Les pieds supportent le poids de notre corps et sont sujets à de nombreuses agressions extérieures comme le sol dur ou des chaussures inconfortables. Ils sont composés d’une multitude de terminaisons nerveuses qui influent sur l’ensemble de notre organisme. Les mains font parties des endroits les plus sensibles de notre corps. Elles renferment de nombreuses terminaisons nerveuses qui sont en communication constante avec notre cerveau. Sollicitées en permanence, elles sont les premières victimes de nos stress et fatigues. Le massage des mains et des pieds contribue à l’élimination du stress, à la décontraction et aide à diminuer les émotions négatives. Il vous procurera une énorme sensation de bien-être et de détente."],
["Massage du Dos","Le massage du dos est source de relaxation et de détente après une journée éprouvante ou juste pour se faire plaisir une fois de temps en temps. Ses bienfaits sont innombrables, il permet notamment de tonifier, de relaxer et de stimuler le dos qui est une des zones du corps les plus sujettes aux tensions. En effet, de très nombreux et puissants muscles sont sollicités dans cette région et il est possible de les soulager en les massant. Le dos souffre de notre rythme de vie et de nos mauvaises postures, le dos est un peu l’endroit où tout notre stress et notre fatigue sont stockés. Ce massage permet d’évacuer le stress, de reposer votre dos et donc d’apporter une énergie nouvelle."],
["Massage Crâne, nuque & épaules","Ce massage sollicite particulièrement les zones soumises au stress de la vie quotidienne en stimulant les zones réflexes et énergétiques. Il dénoue et agit sur vos tensions accumulées au niveau des épaules, de la nuque et du cuir chevelu. Ce massage vous procure un bien-être physique et psychique. Vous vous sentirez complètement détendu(e). Le massage Crâne, Nuque & Épaules est spécialement recommandé si vous passez du temps devant l’ordinateur ou en voiture, car il rétablira les maux créés sur une région qui supporte le poids de votre tête ou une position pas toujours la mieux adaptée."]]
special = ["Massage prénatal","Les massages peuvent faire énormément de bien aux femmes enceintes et soulager les ventres douloureux. Ce qui est bon pour la maman est en général bon pour le foetus ! Les massages permettent à la maman de se détendre et de se sentir mieux."]

# ~~~~~~~ engregistrement de category de massage ~~~~~~~~ #
massageH = Massage.create(name:"Homme", service:s1)
massageF = Massage.create(name:"Femme", service:s1)
# ~~~~~~~~~~~~~~~~ enregistrement des prix ~~~~~~~~~~~~~~~~~ #
MassageDurationPrice.create(duration: 30, exceptional_price: 70, ordinary_price: 50, exceptional_acompte: 30, ordinary_acompte: 20)
MassageDurationPrice.create(duration: 60, exceptional_price: 90, ordinary_price: 70, exceptional_acompte: 30, ordinary_acompte: 20)
MassageDurationPrice.create(duration: 90, exceptional_price: 110, ordinary_price: 90, exceptional_acompte: 30, ordinary_acompte: 20)
MassageDurationPrice.create(duration: 120, exceptional_price: 130, ordinary_price: 110, exceptional_acompte: 30, ordinary_acompte: 20)

def addprice(nombre,sub) #ajouter les différents heurs possible a chaque type de massage
	if [1,4,6,7].include?(nombre)
		sub.massage_duration_prices = MassageDurationPrice.where(duration:[30,60,90,120])
	end
	if [2,3,5,8].include?(nombre)
		sub.massage_duration_prices = MassageDurationPrice.where(duration:[60,90,120])
	end
end

array_index = 1
massageTypeList.each do |su|
	typeDeMassage = MassageType.create(name:su[0], description:su[1])
	typeDeMassage.massages = Massage.all
	addprice(array_index,typeDeMassage)
	array_index += 1
end

typeDeMassage = MassageType.create(name:special[0], description:special[1])
typeDeMassage.massages = [massageF]
addprice(8,typeDeMassage)

# ========================= CREE LES SERVICE SPA ========================= #
SpaAmbiance.create(name:"Romantique", description: "Ballons, pétales de roses, bougies & spot lumineux", price: 20)
SpaAmbiance.create(name:"Anniversaire", description: "Ballons, confettis, accessoires anniversaire & spot lumineux", price: 20)
SpaAmbiance.create(name:"Personnalisée", description: "Event/Fête, décoration personnalisée pour nouvel an, noël, fête des pères/mères, EVJF, Girly, Zen, etc…", price: 30)
s = Spa.create(duration: 24, exceptional_price: 180, ordinary_price: 100, exceptional_acompte: 50, ordinary_acompte: 30, service: s2)
s.spa_ambiances = SpaAmbiance.all
s = Spa.create(duration: 48, exceptional_price: 230, ordinary_price: 150, exceptional_acompte: 65, ordinary_acompte: 45, service: s2)
s.spa_ambiances = SpaAmbiance.all
s = Spa.create(duration: 72, exceptional_price: 280, ordinary_price: 200, exceptional_acompte: 75, ordinary_acompte: 60, service: s2)
s.spa_ambiances = SpaAmbiance.all

# =========================================================================== #

# ~~~~~~~~~ idée cadeau
Product.create(name: "Fontaine chocolat", description: "Fournie avec chocolat", price: 20)
Product.create(name: "Petits fours", description: "gateau", price: 20)
Product.create(name: "Plateau de fruits frais", description: "Pour 2 personnes", price: 20)
Product.create(name: "Table de massage", description: "Fournie avec huile de massage", price: 25)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
	# Seed pour les comments
listavis = [
	#Accueil
[5,"accueil", "Très professionnelle, massage très agréable à mes attentes ! Merci beaucoup !", "Silvia"], 
[5,"accueil", "Merci beaucoup à Cocooningspa ! Très bon service !", "Alex"], 
[5,"accueil",  "Merci beaucoup pour cette prestation spa et massage à domicile, service professionnel et rapide, je recommande à 100%.", "Nicolas"], 
[5,"accueil",  "Merci beaucoup pour cette prestation spa au top, mon conjoint a adoré la surprise, c’était très réussi, je recommande mille fois !!", "Annabelle"], 
[5,"accueil",  "Super prestation ! Réponse rapide et efficace, Camille est très pro et bien équipée (serviette chauffante comprise !!), on en ressort totalement détendu... je recommande sans hésiter !", "Mohamed"], 
[5,"accueil",  "Praticienne et massage très pro. Je recommande ! ", "Alexandra"], 
[5,"accueil",  "Merci encore à Cocooning Spa ! Très bon service de spa et massage à domicile ! Qualité du prestataire, des masseurs et ponctualité !", "Mounir"], 
[5,"accueil",  "Massage de grande qualité. J’ai été massé par Mustapha qui est très professionnel, et très à l’écoute, précis dans ces gestes, bonheur retrouvé de ne plus avoir mal au dos. Mille merci !", "Myriam"],

#Spa
[5,"spa", "J’ai pris récemment une location de jacuzzi à domicile, c’était une première pour moi. Mon homme a adoré sa surprise, c’était comme à l’hôtel voir mieux. Cocooning Spa est une entreprise professionnelle, compréhensive, sociable et pointilleuse. Je recommande fortement.", "Chloé"],
[5,"spa", "Effet de surprise garantie avec cette location de spa ! 3 jours où nous avons apprécié ce moment de détente absolu chez soi. Équipe dynamique et commerciale ! À refaire très vite ! Je recommande vivement !", "Aïcha"],
[5,"spa", "Prestation au top ! Rapidité extrême, ayant réservé à 13h pour être en place à 19h ! Top qualité, 24h de bonheur dans son salon. Je recommande à ceux qui veulent passer un bon moment chez eux. Honnêtement c'est génial je recommencerai !", "Sami"],
[5,"spa", "24h de magie à domicile ! Ponctuel, professionnel, discret, n'hésitez pas à contacter Cocooning spa pour une surprise sur mesure. Nous avons passé des moments inoubliables dans l'intimité d'un chez soi, c'est mieux qu'à l'hôtel !", "Angélique"],
[5,"spa", "Rapidité, efficacité et service de qualité. L’équipe Cocooning Spa est à l’écoute et prend le temps de bien vous expliquer les règles de base. Merci encore pour cette prestation spa ! Je recommande ! À très bientôt ", "Nordine"],
[5,"spa", "Superbe prestation ! À recommander, surprise assurée ! Top du top !", "Charlotte"],
[5,"spa", "Excellent, juste parfait pour notre part ! Bonne organisation et montage propre rien à dire, nous avons passé un excellent moment à notre domicile avec le jacuzzi et la personne qui monte le jacuzzi est au top !!", "Toufik"],
[5,"spa", "Super prestation, effet de surprise garantie. Décoration exceptionnelle mais je tiens surtout à souligner le professionnalisme de cette société comme on en voit très peu de nos jours. Merci encore a toute l'équipe.", "Inès"],

#Massages

[5,"massage", "Très professionnelle, ponctuelle, bien équipée, souriante et massage relaxant au top !! Je la recontacterai c’est sur !! Bravo à Nathalie !! Et merci !", "Samir"],
[5,"massage", "Très professionnelle, massage très agréable à mes attentes ! Merci beaucoup !", "Silvia"],
[5,"massage", "Massage vraiment au top moment de détente absolue merciiii beaucoup", "Virginie"],
[5,"massage", "Amine a été très à l'écoute de mon fils à qui j'ai offert ce massage. Massage du dos de la tête et des bras au top.", "Viviane"],
[5,"massage", "Un vrai professionnel. Ponctuel et à l’écoute de ce qu’on lui demande. Il a su répondre à mes attentes, je vous le recommande les yeux fermés. Merci Adil et à très bientôt.", "Samantha"],
[5,"massage", "Prestation Top : une bonne découverte des besoins, finalement le massage choisi n’était pas adapté. Très pédagogue, bon massage, à refaire !", "Cyril"],
[5,"massage", "Super prestation ! Réponse rapide et efficace, Camille est très pro et bien équipée (serviette chauffante comprise !!), on en ressort totalement détendu... je recommande sans hésiter !", "Mohamed"],
[5,"massage", "Gwendoline a été parfaite ! Elle est aux petits soins et complètement à l'écoute de vos besoins. Merci encore !", "Hugo"],
[5,"massage", "Amandine est très professionnelle. Ponctuelle et agréable, elle m'a rapidement mise à l'aise pour une heure de massage. Très douce, je la recommande !!", "Fatima"]
]

listavis.each do |avis|
	c = Comment.create(note: avis[0], content: avis[2], user_name: avis[3], comment_for:avis[1])
	puts "Comment-#{c.comment_for}"
end

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
	# Creation d'exemple de code promo
["REDUCSPAJJ"].each do |code|
	puts "Code promoe -#{code}"
	CodePromo.create(code:code,reduction:10)
end


