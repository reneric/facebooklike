class PagesController < ApplicationController
require 'net/http'
  def home
  	@status = "unknown"
   	session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/authorized')
		@auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"read_stream") 	
		puts session.to_s + "<<< session"

  	respond_to do |format|
		 format.html {  }
	 end
	 if session[:status]
	 	@status = session[:status]
	 else
	 	@status = "unknown"
	 end
  end

def authorized
  	if params[:code]
		session[:access_token] = session[:oauth].get_access_token(params[:code])
	end
	@api = Koala::Facebook::API.new(session[:access_token])	
	begin
		@me = @api.get_object("/me")

		unless @me.nil?
			session[:user_id] = @me["id"]
			user = User.where(:uid => session[:user_id])
			unless user.exists?
				User.create(name: @me["name"], uid: session[:user_id])
			end
		end
		@graph_data = @api.get_object("/me/likes/223083117703325")
		if @graph_data.length == 1
			session[:status] = "authorized"
		else
			session[:status] = "gated"
		end
		redirect_to root_url
	end
	respond_to do |format|
	 format.html {   }
	 format.js		 
	end
end

def gated
	session[:status] = "gated"
	@status = session[:status]
	respond_to do |format|
	 	format.html {   }
	 	format.js		 
	end
	redirect_to root_url
end



def liked
	session[:status] = "authorized"
	@status = session[:status]
	respond_to do |format|
	 	format.html {   }
	 	format.js		 
	end
	redirect_to root_url
end

def rules
end

end
