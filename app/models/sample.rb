# This is to create accounts for people on the stripe website to handle the money on their end and so I could transfer money to them.
# This is currently not in use

# class Registration < ActiveRecord::Base

#   belongs_to :user

#   attr_accessible :session_id, :user_id, :session, :user, :stripe_payment_id
#   validates :user_id, :uniqueness => {:scope => :session_id}

#   def save_with_payment(user, stripe_card_token)
#     if valid?
#       if user.stripe_customer_id.present?
#         charge = Stripe::Charge.create(
#             :customer => user.stripe_customer_id,
#             :amount => self.session.price.to_i * 100,
#             :description => "Registration for #{self.session.name} (Id:#{self.session.id})",
#             :currency => 'cad'
#         )
#       else
#         customer = Stripe::Customer.create(
#             :email => user.email,
#             :card => stripe_card_token,
#             :description => user.name
#         )
#         charge = Stripe::Charge.create(
#             :customer => customer.id,
#             :amount => self.session.price.to_i * 100,
#             :description => "Registration for #{self.session.name} (Id:#{self.session.id})",
#             :currency => 'cad'
#         )
#         user.update_attribute(:stripe_customer_id, customer.id)
#       end
#       self.stripe_payment_id = charge.id
#       save!
#     end
#   rescue Stripe::CardError => e
#     body = e.json_body
#     err  = body[:error]
#     logger.debug "Status is: #{e.http_status}"
#     logger.debug "Type is: #{err[:type]}"
#     logger.debug "Code is: #{err[:code]}"
#     logger.debug "Param is: #{err[:param]}"
#     logger.debug "Message is: #{err[:message]}"
#   rescue Stripe::InvalidRequestError => e
#     # Invalid parameters were supplied to Stripe's API
#   rescue Stripe::AuthenticationError => e
#     # Authentication with Stripe's API failed
#     # (maybe you changed API keys recently)
#   rescue Stripe::APIConnectionError => e
#     # Network communication with Stripe failed
#   rescue Stripe::StripeError => e
#     # Display a very generic error to the user, and maybe send
#     # yourself an email
#   rescue => e
#     # Something else happened, completely unrelated to Stripe
#   end
# end
