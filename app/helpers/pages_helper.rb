module PagesHelper

	require 'net/http'
	def facebook_likes
	  uri = URI("http://graph.facebook.com/40796308305")
	  data = Net::HTTP.get(uri)
	  @likes = JSON.parse(data)['likes']
	end
end
