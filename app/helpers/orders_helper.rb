module OrdersHelper
	def celementCategory(array_index)
		return @paniers[array_index]["category"]
	end

	def subcategories(array_index)
		# array_index l'index de l'element dans le @paniers[]
		return Category.find(celementCategory(array_index)[1]).subcategories
	end

	def helpsubcategories(category)
		return category.subcategories
	end

	def isincommandesubcategory(id,subcategory)
		return session[:prestation][id]["subcategory"] != nil && session[:prestation][id]["subcategory"].include?([subcategory.id,subcategory.name])
	end

	def countnumbre(nameCategory,id)
		num = 0
		session[:prestation].reverse_each do |presta|
	      if presta.value?([nameCategory,id])
	      	num += 1
	      end
	    end
	    return num
	end

	def totalprice
		total = 0
		session[:prestation].each do |cate|
			if cate["subcategory"] != nil
				cate["subcategory"].each do |value|
				  total += Subcategory.find(value[0]).price
				end
			end
		end
		return total
	end

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
