function printMessage(message) {
  var messageString = message.author + ": " + message.body;
  $('#messages').append(messageString + "<br>");
}

$(document).ready(function() {
    var chatChannel;

    function setupChannel() {
        chatChannel.join().catch(function(err) {
          console.error("Failed to join channel because " + err);
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

     $.post("/tokens", function(data) {
          Twilio.Chat.Client.create(data.token).then(client => {
            client.getPublicChannelDescriptors().then(function(paginator) {
              var channelDescriptor = paginator.items[0];
              client.getChannelByUniqueName(channelDescriptor.uniqueName).then(function(channelObj) {
                if(channelObj) {
                  chatChannel = channelObj;
                  setupChannel();
                } else {
                  console.error("Failed to find user's channel");
                }
              });
            });
          });
      });
});
