require 'sinatra'
require 'sqlite3'
require 'sinatra/cors'
require 'json'
require_relative 'puzzle_handler'

# Initialize Bundler
require 'bundler'
Bundler.require

# CORS
configure do
  enable :cors
  
  set :allow_origin, "*"
  set :allow_methods, "GET,HEAD,POST,PUT,DELETE,OPTIONS"
  set :allow_headers, "content-type,if-modified-since,accept,origin,authorization"
  set :expose_headers, "location,link"
  set :allow_credentials, true
  
  options "*" do
    response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept, Authorization"
    200
  end
end

# TODO phase out username to use real auth from lichess

# Setup db connection for tactics
db = SQLite3::Database.new('tactics-subset.db')

get '/api' do
  "hello"
end
# Gets 10 random puzzles for a certain theme
get '/api/puzzles/:theme' do
  content_type :json
  puzzles = PuzzleHandler.find_puzzles(db, params[:theme], 10)
  response = []  
  for puzzle in puzzles
    response.append({

      name: "sample",
      difficulty: "1200",
      fen: puzzle[1],
      correctMoves: puzzle[2].split(" "),
      theme: puzzle[4]
    })
  end
  response.to_json
end

# Gets a set of themes and subsequent puzzles for a user
get '/api/puzzles_for_user/:username' do
  # TODO find specific puzzles for certain users
  puzzles = PuzzleHandler.find_puzzles(db, params[:username], 10)
  "#{puzzles}"
end

get '/api/puzzle_training' do
  content_type :json
  response = [
    { 
      date: "12/27/2024",
      day: "Monday",
      improvement: "+230",
      theme: "endgame",
      isPremium: true
    },
    { 
      date: "12/28/2024",
      day: "Tuesday",
      improvement: "+30",
      theme: "check mate",
      isPremium: false
    },
    { date: "12/29/2024",
      day: "Wednesday",
      improvement: "+200",
      theme: "middlegame",
      isPremium: false
    },
    { 
      date: "12/30/2024",
      day: "Thursday",
      improvement: "+20",
      theme: "forks",
      isPremium: true 
    },
  ]
  response.to_json
end