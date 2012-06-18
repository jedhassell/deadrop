password_disabled = false
focus_state = 'focus'
messenger_timer = []
in_ajax_request = false

$ ->
  setInterval(get_new_messages, 1000)

  $('#create_message').attr('disabled', 'disabled')

  $('#create_message').click ->
    if password_disabled
      text = $('#text').val()
      $('#text').val('')
      unless(text.trim() == '')
        password = $('#password').val()

        defaults =
          ks: 256
          ts: 128

        params =
          encrypted_message: sjcl.encrypt(password, text, defaults)
          username: $('#username_display').val()
          key: $('#chat_room_name').val()
        $.post('create_message', params)

  $('#password').keyup(decrypt_messages)

  $(window).focus(->
    focus_state = 'focus'
  )

  $(window).blur(->
    focus_state = 'blur'
  )

  $('#text').keyup((event) ->
    if (event.keyCode == 13)
      $('#create_message').click()
  )


password_correct = ->
  unless password_disabled
    $('#password').attr('disabled', 'disabled')
    $('#create_message').removeAttr('disabled')
    password_disabled = true

get_new_messages = ->
  unless(in_ajax_request)
    in_ajax_request = true
    messages_count = $('.message').length
    params =
      message_count: messages_count
      key: $('#chat_room_name').val()

    $.post('get_new_messages', params, (data) ->
      in_ajax_request = false
      $('#messages').prepend(data)
      if(password_disabled && data != '')
        decrypt_messages()
        new_message_alert()
        messenger_timer.push(setInterval(new_message_alert, 1000))
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
    document.title = $('#chat_room_name').val()
    clear_messenger_timers()
  else if (focus_state == 'blur')
    if(document.title == "MESSAGE!")
      document.title = $('#chat_room_name').val()
    else
      document.title = "MESSAGE!"

clear_messenger_timers = ->
  for timer in messenger_timer
    clearInterval(timer)
  messenger_timer = []