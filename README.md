# This is the primary backend for the chess puzzles

# Running the server
1) bundle install
2) bundle exec rackup -p 4567

# Deploying
1) ssh into server
2) cd /home/mern/Tactics-API
3) bundle install
4) pm2 start "bundle exec rackup -p 4567" --name "ruby-server"