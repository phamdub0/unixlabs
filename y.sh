#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

. ${DIR}/util.sh

sudo apt-get install -y mc nodejs npm apache2 || fatal "ERROR: apt get"
sudo npm install -g wintersmith || fatal "ERROR: npm"
sudo ln -s /usr/bin/nodejs /usr/bin/node
wintersmith new mysite
cd mysite
wintersmith build
sudo cp -r build/* /var/www/html

# open port???

