#!/bin/bash

sudo apt install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc

wget https://raw.githubusercontent.com/techAPJ/install-rails/master/linux
sudo bash linux
git clone https://github.com/discourse/discourse.git ~/discourse
sudo -u postgres createuser -s techapj
cd ~/discourse
source ~/.bashrc
bundle install
bundle exec rake db:create db:migrate
RAILS_ENV=test bundle exec rake db:create db:migrate
bundle exec rake autospec
bundle exec rails server
bundle exec rails server --binding=0.0.0.0
RAILS_ENV=development bundle exec rake admin:create
mailcatcher --http-ip 0.0.0.0
