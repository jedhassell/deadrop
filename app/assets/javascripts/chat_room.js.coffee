password_disabled = false

$ ->
  $('#create_message').attr('disabled', 'disabled')

  $('#create_message').click ->
    text = $('#text').val()
    unless(text == '')
      password = $('#password').val()
      defaults = ks:256, ts:128
      encrypted_text = sjcl.encrypt(password, text, defaults)
      $('#encrypted_message').val(encrypted_text)
      $('#create_message_form').submit()

  $('#password').keyup () ->
    password = $('#password').val()
    $('.message').each (i, message) ->
      encrypted_object = $(message).val()
      try
        plain_text = sjcl.decrypt(password, encrypted_object)
        password_correct()
        $(message).val(plain_text)
      catch err

password_correct = ->
  unless password_disabled
    $('#password').attr('disabled', 'disabled')
    $('#create_message').removeAttr('disabled')
    password_disabled = true