jQuery ->
  $('body').prepend('<div id="fb-root"></div>')
  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true
  

window.fbAsyncInit = ->
  FB.init(appId: '125644104300196',  channelUrl: 'http://icodethings.com/channel.html', status: true, cookie: true, xfbml: true)
  FB.Event.subscribe "edge.create", (response) ->
    window.location = '/liked' if response

  $('#sign_out').click (e) ->
    FB.getLoginStatus (response) ->
      FB.logout() if response.authResponse
    true


