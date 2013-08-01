class Subscription < ActiveRecord::Base
  belongs_to :plan
  validates_presence_of :plan_id
  validates_presence_of :email

  attr_accessor :stripe_card_token

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: name, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    else
      rescue Stripe::InvalidRequestError => e
        logger.error "Stripe error while creating customer: #{e.message}"
        errors.add :base, "There was a problem with your credit card."
        false
    end
  end
end


# the subscription controller? a rails convention for the routes?

#   def new
#     plan = Plan.find(params[:plan_id])
#     @subscription = plan.subscription.build
#   end

#   def create
#     @subscription = Subscription.new(params[:subscription])
#     if @subscription.save
#       redirect_to @subscription, :notice => "Thank you for subscribing."
#     else
#       render :new
#     end
#   end

#   def show
#     @subscription = Subscription.find(params[:id])
#   end