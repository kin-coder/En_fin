module OrdersHelper

	def infosubcategory(id)
		Subcategory.find(id)
	end

	def prixTotal()
		total = 0
		session[:params_spa].uniq.each do |id|
			total += Subcategory.find(id).price * session[:params_spa].count(id)
		end
		return total
	end
end
