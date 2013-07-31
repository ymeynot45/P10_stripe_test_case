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


post '/create' do
  User.create(params[:user])

  redirect to '/'
end

# require "stripe"
# Stripe.api_key = "sk_test_mkGsLqEW6SLnZa487HYfJVLf"

# Stripe::Customer.create(
#   :description => "Customer for test@example.com",
#   :card => "tok_1RjFk2d1uLB2X2" # obtained with Stripe.js
# )