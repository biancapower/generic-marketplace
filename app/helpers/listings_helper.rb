module ListingsHelper
	def format_condition(condition)
		# convert symbol_formatting_like_this to string
		# capitalizes each word
		condition.split("_").map {|word| word.capitalize}.join(" ")
	end
end
