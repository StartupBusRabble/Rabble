var userEmailToName;

function printMessage(message) {
  var messageString = userEmailToName[message.author] + ": " + message.body;
  $('#messages').append(messageString + "<br>");
}

$(document).ready(function() {
  var chatChannel;
  userEmailToName = $('.group_information').data('useremailtoname');

  function setupChannel() {
    chatChannel.join().catch(function(err) {
      console.error("Failed to join channel " + chatChannel.uniqueName + " because " + err);
    });
    chatChannel.getMessages().then(function(messages) {
      for (i=0; i<messages.items.length; i++) {
        printMessage(messages.items[i]);
      }
    });
    chatChannel.on('messageAdded', function(message) {
        printMessage(message);
     });
  }

  var $input = $('#chat-input');
  $input.on('keydown', function(e) {
    if (e.keyCode == 13) {
      chatChannel.sendMessage($input.val());
      $input.val('');
    }
  });

  $("#submit-button").on('click', function(e) {
    e.preventDefault();
    chatChannel.sendMessage($input.val());
    $input.val('');
  });

  var channelName = $('.group_information').data('chatname');
  if (channelName !== undefined) {
    $.post("/tokens", function(data) {
      Twilio.Chat.Client.create(data.token).then(client => {
        client.getChannelByUniqueName(channelName.toString()).then(function(channelObj) {
          chatChannel = channelObj;
          setupChannel();
        }).catch(function(err) {
          client.createChannel({uniqueName: channelName}).then(function(newChannel) {
            chatChannel = newChannel;
            setupChannel();
          });
        });
      });
    });
  }
});
