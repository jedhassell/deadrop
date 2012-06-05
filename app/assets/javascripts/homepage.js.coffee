$ ->
  $('#create_drop_button').click ->
    window.location = 'deadrop/' + $('#drop_name').val()

  $('#create_chat_room_button').click ->
    window.location = 'chat_room/' + $('#drop_name').val()
