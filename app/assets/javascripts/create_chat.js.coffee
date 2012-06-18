$ ->
  $('#create_chat').click ->
    password = $('#password').val()
    text = $('#text').val()

    defaults =
      ks: 256
      ts: 128
    encrypted_text = sjcl.encrypt(password, text, defaults)

    $('#encrypted_message').val(encrypted_text)
    $('#username').val($('#username_display').val())
    $('#create_form').submit()