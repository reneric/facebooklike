class PagesController < ApplicationController
require 'net/http'
  def home
  	uri = URI("http://graph.facebook.com/23430787")
	 data = Net::HTTP.get(uri)
	 @likes = JSON.parse(data)['likes']
  end

  def rules
  end
end
