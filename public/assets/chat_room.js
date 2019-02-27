(function() {
  var clear_messenger_timers, counter, decrypt_messages, focus_state, get_new_messages, in_ajax_request, messenger_timer, new_message_alert, password_correct, password_disabled;

  password_disabled = false;

  focus_state = 'focus';

  messenger_timer = [];

  in_ajax_request = false;

  counter = 0;

  $(function() {
    setInterval(get_new_messages, 1000);
    $('#create_message').attr('disabled', 'disabled');
    $('#create_message').click(function() {
      var defaults, params, password, text;
      if (password_disabled) {
        text = $('#text').val();
        $('#text').val('');
        if (!(text.trim() === '')) {
          password = $('#password').val();
          defaults = {
            ks: 256,
            ts: 128
          };
          params = {
            encrypted_message: sjcl.encrypt(password, text, defaults),
            username: $('#username_display').val(),
            key: $('#chat_room_name').val()
          };
          return $.post('create_message', params);
        }
      }
    });
    $('#password').keyup(decrypt_messages);
    $(window).focus(function() {
      return focus_state = 'focus';
    });
    $(window).blur(function() {
      return focus_state = 'blur';
    });
    return $('#text').keyup(function(event) {
      if (event.keyCode === 13) {
        return $('#create_message').click();
      }
    });
  });

  password_correct = function() {
    if (!password_disabled) {
      $('#password').attr('disabled', 'disabled');
      $('#create_message').removeAttr('disabled');
      return password_disabled = true;
    }
  };

  get_new_messages = function() {
    var messages_count, params;
    counter += 1;
    if (!(in_ajax_request || counter > 60)) {
      counter = 0;
      in_ajax_request = true;
      messages_count = $('.message').length;
      params = {
        message_count: messages_count,
        key: $('#chat_room_name').val()
      };
      return $.post('get_new_messages', params, function(data) {
        in_ajax_request = false;
        $('#messages').prepend(data);
        if (password_disabled && data !== '') {
          decrypt_messages();
          new_message_alert();
          return messenger_timer.push(setInterval(new_message_alert, 1000));
        }
      });
    }
  };

  decrypt_messages = function() {
    var password;
    password = $('#password').val();
    return $('.message').each(function(i, message) {
      var encrypted_object, plain_text;
      encrypted_object = $(message).html();
      try {
        plain_text = sjcl.decrypt(password, encrypted_object);
        password_correct();
        return $(message).html(plain_text);
      } catch (err) {

      }
    });
  };

  new_message_alert = function() {
    if (focus_state === 'focus') {
      document.title = $('#chat_room_name').val();
      return clear_messenger_timers();
    } else if (focus_state === 'blur') {
      if (document.title === "MESSAGE!") {
        return document.title = $('#chat_room_name').val();
      } else {
        return document.title = "MESSAGE!";
      }
    }
  };

  clear_messenger_timers = function() {
    var timer, _i, _len;
    for (_i = 0, _len = messenger_timer.length; _i < _len; _i++) {
      timer = messenger_timer[_i];
      clearInterval(timer);
    }
    return messenger_timer = [];
  };

}).call(this);
