# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('body').prepend('<div id="fb-root"></div>')
  window.fbAsyncInit = ->
  	FB.init(appId: '125644104300196', cookie: true)
  	FB.Event.subscribe 'edge.create', (href, widget) ->
  		alert 'success'

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
      			$('#user-widget').html('<fb:like href="https://www.facebook.com/BaconSocialMedia" width="300" layout="button_count" action="like" show_faces="false" share="false"></fb:like>');
      
  $('#sign_out').click (e) ->
    FB.getLoginStatus (response) ->
      FB.logout() if response.authResponse
    true