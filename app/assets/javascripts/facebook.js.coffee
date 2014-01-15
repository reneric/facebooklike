# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('body').prepend('<div id="fb-root"></div>')
  window.fbAsyncInit = ->
  	FB.init(appId: '125644104300196', cookie: true)
  	FB.Event.subscribe 'edge.create', (href, widget) ->
  		alert href
  	FB.Event.subscribe 'auth.statusChange', (response) ->
  		if response.status == "connected"
  			console.log "connected"
  		else if response.status == "not_authorized"
  			console.log "not_authorized"
  		else
  			console.log "Not logged in"

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true



  
    

  $('#sign_in').click (e) ->
    e.preventDefault()
    FB.login (response) ->
    	FB.api 'me/likes/223083117703325', (fbdata) ->
      		if fbdata.data.length == 1
      			window.location = '/auth/facebook/callback' if response.authResponse
      		else
      			$('#user-widget').html('<iframe src="//www.facebook.com/plugins/like.php?href=https%3A%2F%2Fwww.facebook.com%2FBaconSocialMedia&amp;width=100px&amp;layout=button_count&amp;action=like&amp;show_faces=false&amp;share=false&amp;height=21&amp;appId=125644104300196" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:100pxpx; height:21px;" allowTransparency="true"></iframe>')
      

  $('#sign_out').click (e) ->
    FB.getLoginStatus (response) ->
      FB.logout() if response.authResponse
    true