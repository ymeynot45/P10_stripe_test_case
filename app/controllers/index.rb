get '/' do
  erb :index
end

post '/' do
  @player1 = User.find_or_create_by_name(params[:user][:user_1])
  @player2 = User.find_or_create_by_name(params[:user][:user_2])
  erb :board
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
