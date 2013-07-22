(function() {
  var subscription;

  jQuery(function() {
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
    return subscription.setupForm();
  });

  subscription = {
    setupForm: function() {
      return $('#new_user').submit(function() {
        $('input[type=submit]').attr('disabled', true);
        return subscription.processCard();
      });
    },
    processCard: function() {
      var card;
      card = {
        number: $('#card_number').val(),
        cvc: $('#card_code').val(),
        expMonth: $('#card_month').val(),
        expYear: $('#card_year').val()
      };
      return Stripe.createToken(card, subscription.handleStripeResponse);
    },
    handleStripeResponse: function(status, response) {
      if (status === 200) {
        $('#user_stripe_card_token').val(response.id);
        var am = $('#user_plan_id').val();
        var pay;
        if(am == "1")
          {
            pay =  99
          }
          if(am == "1")
          {
            pay = 445
          }
          if(am == "20")
          {
            pay = 1580
          }
        var r=confirm("You will be paying" + pay + "$ per month. Click Ok to proceed")
             if (r==true)
                 {
                   $('input[type=submit]').attr('disabled', false);
                   return $('#submit_button').trigger('click');
                    }
                      else
                    {
                      location.reload();
                    }
        
      } else {
        $('#stripe_error').text(response.error.message);
        return $('input[type=submit]').attr('disabled', false);
      }
    }
  };

}).call(this);