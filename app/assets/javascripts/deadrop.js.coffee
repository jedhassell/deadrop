# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

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

#    alert password
#  test = sjcl.encrypt("password", "this is the test data for the test")
#  alert test
#
#  decrypted = sjcl.decrypt "password", test

  #alert decrypted