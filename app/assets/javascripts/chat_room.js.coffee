password_disabled = false

$ ->
  $('#create_chat').click ->
    password = $('#password').val()
    text = $('#text').val()
    encrypted_text = sjcl.encrypt(password, text)

    $('#encrypted_message').val(encrypted_text)
    $('#create_form').submit()

  $('#create_message').click ->
    password = $('#password').val()
    text = $('#text').val()
    encrypted_text = sjcl.encrypt(password, text)

    $('#encrypted_message').val(encrypted_text)
    $('#create_message_form').submit()

  $('#password').keyup () ->
    password = $('#password').val()

    $('.message').each (i, message) ->
      encrypted_object = $(message).val()
      try
        plain_text = sjcl.decrypt(password, encrypted_object)
        unless password_disabled
          $('#password').attr('disabled', 'disabled')
          password_disabled = true
        $(message).val(plain_text)
      catch err
