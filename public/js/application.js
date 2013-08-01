function Player(email) {
  this.email = email;
}

function Game() {
  this.winner = "";
}

$(document).ready(function(){
    var player1 = new Player($('#player1').text());
    var player2 = new Player($('#player2').text());
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

      $.post(url, {"winner": player1.email}, function(response) {
        var new_body = $(response).filter('#result-container');
        $(document).find('#container').html(new_body);
      });
    }
    else if ($('#player2_strip td:last-child').attr('class') == "active"){
      $(document).unbind('keyup');

      $.post(url, {"winner": player2.email}, function(response) {
        var new_body = $(response).filter('#result-container');
        $(document).find('#container').html(new_body);
      });
    }
  });
  

// -----------------------------------------

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



// --------------------------------------
var subscription;

subscription.setupForm();

subscription = {
  setupForm: function() {
    return $('#new_subscription').submit(function() {
      $('input[type=submit]').attr('disabled', true);
      subscription.processCard();
      return false;
    });
  }
};

({
  processCard: function() {
    var card;
    return card = {
      number: $('#card_number').val(),
      cvc: $('#card_code').val(),
      expMonth: $('#card_month').val(),
      expYear: $('#card_year').val()
      // Stripe.createToken(card, amount, subscription.handleStripeResponse) //??? unsure about this one.
    };
  }
});




({
  handleStripeResponse: function(status, response) {
    if (status === 200) {
      alert(response.id);
      $('#subscription_stripe_card_token').val(response.id);
      $('#new_subscription')[0].submit();
    } else {
      alert(response.error.message);
      $('stripe_error').text(response.error.message);
      $('input[type=submit').attr('disabled', false);
    }
    return end;
  }
});
