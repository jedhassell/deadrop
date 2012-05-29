$ ->
  $('#create_button').click ->
    password = $('#password').val()
    text = $('#text').val()
    encrypted_text = sjcl.encrypt(password, text)

    $('#encrypted_object').val(encrypted_text)
    $('#create_form').submit()

  $('#password').keyup () ->
    password = $('#password').val()
    encrypted_object = $('#encrypted_text').val()
    try
      plain_text = sjcl.decrypt(password, encrypted_object)
      $('#password').attr('disabled', 'disabled')
      $('#encrypted_text').val(plain_text)
    catch err

#window.onbeforeunload = ->
#  alert 'hello'

#    alert password
#  test = sjcl.encrypt("password", "this is the test data for the test")
#  alert test
#
#  decrypted = sjcl.decrypt "password", test

  #alert decrypted