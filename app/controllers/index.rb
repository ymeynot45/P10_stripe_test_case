get '/' do
  erb :index
end

post '/' do
  @player1 = User.find_by_name(params[:user][:user_1])
  @player2 = User.find_by_name(params[:user][:user_2])
  if @player1 && @player2
    erb :board
  else
    erb :index
  end  
end

post '/winner' do
  @game= Game.create(winner: params[:winner])
  redirect to "/results/#{@game.id}"
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

post '/charge' do
  # Amount in cents
  @amount = 500

  customer = Stripe::Customer.create(
    :email => 'customer@example.com',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :amount      => @amount,
    :description => 'Sinatra Charge',
    :currency    => 'usd',
    :customer    => customer.id
  )

  redirect "/"
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