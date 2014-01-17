class PagesController < ApplicationController
require 'net/http'
  def home
   	session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/callback')
		@auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"read_stream") 	
		puts session.to_s + "<<< session"

  	respond_to do |format|
		 format.html {  }
	 end
	 
  end

def callback
  	if params[:code]
  		# acknowledge code and get access token from FB
	  session[:access_token] = session[:oauth].get_access_token(params[:code])
	end		
	
    	
		 # auth established, now do a graph call:
	  
	@api = Koala::Facebook::API.new(session[:access_token])
	begin
		@me = @api.get_object("/me")
		unless @me.nil?
			session[:user_id] = @me["id"]
			user = User.where(:id => session[:user_id])
			unless user.exists?
				User.create(name: @me["name"], id: session[:user_id])
			end
		end
		@graph_data = @api.get_object("/me/likes/223083117703325")
		# session[:liked] = @graph_data.length
		if @graph_data.length == 1
			session[:liked] = true
			
		else
			session[:liked] = nil
			
		end
		redirect_to root_url
	end
	

	respond_to do |format|
	 format.html {   }			 
	end
		
end


  def rules
  end
end
