get '/' do
  erb :index
end

post '/' do
  @player1 = User.find_by_email(params[:user][:player_1])
  @player2 = User.find_by_email(params[:user][:player_2])
  @bet = params[:bet].to_i * 100
  if @player1 && @player2

    if @player1.balance < @bet
      @error = "#{@player1.email} doesn't have enough money in their account."
    end

    if @player2.balance < @bet
      @error = "#{@player2.email} doesn't have enough money in their account."
    end

  else
    @error = "If you don't have an account you need to create one."
  end

  if @error
    erb :index
  else
    the_pot = 0 #put this all into a method later. Doing this on the front end is call puting the breakage to the house.
    User.update(@player1.id, :balance => (@player1.balance - @bet))
    the_pot += @bet
    User.update(@player2.id, :balance => (@player2.balance - @bet))
    the_pot += @bet
    house_take = the_pot * 0.1
    User.update(1, :balance => house_take)
    @the_pot = (the_pot - house_take)
    erb :board
  end
end


get '/results/:game_id' do
  @game = Game.find(params[:game_id])
  @winner = @game.winner
  erb :results
end

get '/create' do
  erb :stripe_form
end

post '/create' do
  User.create(params[:user])

  redirect to '/'

end

post '/winner' do
  @game= Game.create(winner: params[:winner])
  redirect to "/results/#{@game.id}"
end

post '/charge' do

  @user = User.find_or_create_by_email(params[:user][:email])

  if @user
    # Amount in cents
    @amount = (params[:user][:cents].to_i * 100)

    customer = Stripe::Customer.create(
      :email => params[:user][:email],
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :amount      => @amount,
      :description => 'JS Racer',
      :currency    => 'usd',
      :customer    => customer.id
    )

    @amount += @user.balance 
    User.update(@user.id, :balance => @amount)
    
    redirect  '/'
  else
    @error = "I could not process your request."
    erb :stripe_form
  end
end

error Stripe::CardError do
  env['sinatra.error'].message
end

















  # the form that matches the above post.
 # <form action="/charge" method="post">
 #    <article>
 #      <label class="amount">
 #        <span>Amount: $5.00</span>
 #      </label>
 #    </article>




# require "stripe"
# Stripe.api_key = "sk_test_mkGsLqEW6SLnZa487HYfJVLf"

# Stripe::Customer.create(
#   :description => "Customer for test@example.com",
#   :card => "tok_1RjFk2d1uLB2X2" # obtained with Stripe.js
# )