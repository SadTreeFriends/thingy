module IdeasHelper
	def content_excerpt(content)
		max = 150
		if content.length > max
			content[0..max] + ' ...'
		else
			content
		end
	end
end
