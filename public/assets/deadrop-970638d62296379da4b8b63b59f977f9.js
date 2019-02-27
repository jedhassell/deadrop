(function() {

  $(function() {
    $('#create_button').click(function() {
      var defaults, encrypted_text, password, text;
      password = $('#password').val();
      text = $('#text').val();
      defaults = {
        ks: 256,
        ts: 128
      };
      encrypted_text = sjcl.encrypt(password, text, defaults);
      $('#encrypted_object').val(encrypted_text);
      return $('#create_form').submit();
    });
    return $('#password').keyup(function() {
      var encrypted_object, password, plain_text;
      password = $('#password').val();
      encrypted_object = $('#encrypted_text').val();
      try {
        plain_text = sjcl.decrypt(password, encrypted_object);
        $('#password').attr('disabled', 'disabled');
        return $('#encrypted_text').val(plain_text);
      } catch (err) {

      }
    });
  });

}).call(this);
