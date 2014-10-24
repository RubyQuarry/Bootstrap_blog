# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


handlerIn = ->
  $(this).animate({ backgroundColor: '#9dc6eb', borderRadius: '5px'})

handlerOut = ->
  $(this).animate({ backgroundColor: 'white', borderRadius: '0px'})



ready = ->
  $('#comments  #wallmessages').hover(handlerIn, handlerOut)



# on page ready...
$(document).ready(ready)
$(document).on('page:load', ready)