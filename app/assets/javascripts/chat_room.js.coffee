password_disabled = false
focus_state = 'focus'

$ ->
  setTimeout(get_new_messages, 1000)

  $('#create_message').attr('disabled', 'disabled')

  $('#create_message').click ->
    text = $('#text').val()
    unless(text == '')
      password = $('#password').val()

      defaults =
        ks: 256
        ts: 128

      params =
        encrypted_message: sjcl.encrypt(password, text, defaults)
        username: $('#username_display').val()
        key: $('#chat_room_name').val()
      $.post('create_message', params, ->
        $('#text').val('')
      )

  $('#password').keyup(decrypt_messages)

  $(window).focus(->
    focus_state = 'focus'
  )

  $(window).blur(->
    focus_state = 'blur'
  )

password_correct = ->
  unless password_disabled
    $('#password').attr('disabled', 'disabled')
    $('#create_message').removeAttr('disabled')
    password_disabled = true

get_new_messages = ->
  messages_count = $('.message').length
  params =
    message_count: messages_count
    key: $('#chat_room_name').val()

  $.post('get_new_messages', params, (data) ->
    $('#messages').prepend(data)
    if(password_disabled && data != '')
      decrypt_messages()
      new_message_alert()

    window.setTimeout(get_new_messages, 1000)
  )


decrypt_messages = ->
  password = $('#password').val()
  $('.message').each (i, message) ->
    encrypted_object = $(message).html()
    try
      plain_text = sjcl.decrypt(password, encrypted_object)
      password_correct()
      $(message).html(plain_text)
    catch err

new_message_alert = ->
  if(focus_state == 'focus')
    document.title = "Deadrop"
  else if (focus_state == 'blur')
    if(document.title == "MESSAGE!")
      document.title = "message!"
    else
      document.title = "MESSAGE!"

    window.setTimeout(new_message_alert, 1000)
