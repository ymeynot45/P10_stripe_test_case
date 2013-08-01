get '/' do
  erb :index
end

post '/' do
  @player1 = User.find_by_email(params[:user][:user_1])
  @player2 = User.find_by_email(params[:user][:user_2])
  if @player1 && @player2

    if @player1.balance < 500
      @error = "#{@player1.email} doesn't have enough money in their account."
    end

    if @player2.balance < 500
      @error = "#{@player2.email} doesn't have enough money in their account."
    end

  else
    @error = "If you don't have an account you need to create one."
  end

  if @error
    erb :index
  else
    erb :board
  end
end


get '/results/:game_id' do
  @game = Game.find(params[:game_id])
  @winner = @game.winner
  erb :results
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

post '/winner' do
  @game= Game.create(winner: params[:winner])
  redirect to "/results/#{@game.id}"
end

get '/create' do
  erb :stripe_form
end

post '/create' do
  User.create(params[:user])

  redirect to '/'

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