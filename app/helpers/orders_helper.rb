module OrdersHelper
	def category(id)
		return @paniers[id]["category"]
	end
	def subcategories(id)
		return Category.find(category(id)[1]).subcategories
	end
	def helpsubcategories(category)
		return category.subcategories
	end
	def isincommandesubcategory(id,subcategory)
		return session[:prestation][id]["subcategory"] != nil && session[:prestation][id]["subcategory"].include?([subcategory.id,subcategory.name])
	end
	def countnumbre(namec,id)
		num = 0
		session[:prestation].reverse_each do |presta|
	      if presta.value?([namec,id])
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
end