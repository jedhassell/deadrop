(function() {

  $(function() {
    return $('#create_chat').click(function() {
      var defaults, encrypted_text, password, text;
      password = $('#password').val();
      text = $('#text').val();
      defaults = {
        ks: 256,
        ts: 128
      };
      encrypted_text = sjcl.encrypt(password, text, defaults);
      $('#encrypted_message').val(encrypted_text);
      $('#username').val($('#username_display').val());
      return $('#create_form').submit();
    });
  });

}).call(this);
