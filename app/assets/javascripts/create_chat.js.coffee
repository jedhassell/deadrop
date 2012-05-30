$ ->
  $('#create_chat').click ->
    password = $('#password').val()
    text = $('#text').val()
    encrypted_text = sjcl.encrypt(password, text)

    $('#encrypted_message').val(encrypted_text)
    $('#create_form').submit()