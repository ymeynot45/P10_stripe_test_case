function Player(name) {
  this.name = name;
}

function Game() {
  this.winner = "";
}

$(document).ready(function(){
    var player1 = new Player($('#player1').text());
    var player2 = new Player($('#player2').text());
    debugger;
  $(document).bind('keyup', function(keystroke){
    
    var current_position_1 = $("#player1_strip > .active");
    var current_position_2 = $("#player2_strip > .active");

    var url = "/winner";

    if(keystroke.keyCode == 81){
      current_position_1.removeClass('active').next().addClass('active');
    }
    else if(keystroke.keyCode == 80){
      current_position_2.removeClass('active').next().addClass('active');
    }

    if ($('#player1_strip td:last-child').attr('class') == "active"){
      $(document).unbind('keyup');

      $.post(url, {"winner": player1.name}, function(response) {
        var new_body = $(response).filter('#result-container');
        $(document).find('#container').html(new_body);
      });
    }
    else if ($('#player2_strip td:last-child').attr('class') == "active"){
      $(document).unbind('keyup');
      $.post(url, {"winner": player2.name}, function(response) {
        var new_body = $(response).filter('#result-container');
        $(document).find('#container').html(new_body);
      });
    }
  });
  
  jQuery(function($) {
    $('#payment-form').submit(function(event) {
      var $form = $(this);

      // Disable the submit button to prevent repeated clicks
      $form.find('button').prop('disabled', true);

      Stripe.createToken($form, stripeResponseHandler);

      // Prevent the form from submitting with the default action
      return false;
    });
  });
});
