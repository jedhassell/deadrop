(function() {

  $(function() {
    $('#create_drop_button').click(function() {
      return window.location = 'deadrop/' + $('#drop_name').val();
    });
    return $('#create_chat_room_button').click(function() {
      return window.location = 'chat_room/' + $('#drop_name').val();
    });
  });

}).call(this);
