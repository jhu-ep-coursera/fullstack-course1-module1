
# These are the suggested installation instructions for Ubuntu for class. There is 
# lengthy compilation step in the middle of these procedures, so please plan on 
# 30min break to complete the "rbenv install" command.

# The instructions start with a visit to the official Rails site (http://rubyonrails.org).
# The download page (http://rubyonrails.org/download/)
# recommends that we install the rbenv installation manager to manage our ruby installation
# and supplies a link to git://github.com/sstephenson/rbenv.git
# There are more words about the rbenv, ruby, and rails installation on the Ubuntu page
# https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-14-04
# we will mix into the instructions.

#exit if we encounter an error
set -e

#before we start -- make sure your packages are up-to-date and has some necessary tools

#update installed packages before adding new ones
sudo apt-get update -y

# install Git required to clone source repositories and work with ourselves
sudo apt-get install -y git gitk git-gui

# install C-compiler and libraries required by rbenv to build ruby binaries for your platform
sudo apt-get install -y gcc build-essential libpq-dev libssl-dev libreadline-dev libsqlite3-dev zlib1g-dev

# Now follow the rbenv instructtions on the Github site
# https://github.com/sstephenson/rbenv
#clone the rbenv git repo into ~/.rbenv
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv

# provide example of how to set an environment variable
echo 'export RECIPEPUPPY_HOSTPORT=www.recipepuppy.com:80' >> ~/.bashrc
set +e
source ~/.bashrc
set -e
echo $RECIPEPUPPY_HOSTPORT
chrome http://$RECIPEPUPPY_HOSTPORT

#add ~/.rbenv to your $PATH for access to rbenv command-line utility
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
tail ~/.bashrc

#add "rbenv init" to your shell to enable shims and autocompletion
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
tail ~/.bashrc

#add the contents of the modified .bashrc to your current shell
set +e
source ~/.bashrc
set -e
which rbenv
rbenv help

#add the install command to rbenv
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
tail ~/.bashrc

#source the new path location into the current shell and verify we now have an "install" command
set +e
source ~/.bashrc
set -e
rbenv help | grep install

# we can not mesh in the instructions from
# https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-14-04

# install a Ruby version (could be others)
rbenv install -v 2.2.2
# set the global version of Ruby to use
rbenv global 2.2.2
ruby -v

#set the default to not have gems generate local documentation (and eat space and time)
echo "gem: --no-document" > ~/.gemrc
gem install bundler

#this step will take a ~5min to complete (as it warns)
gem install rails -v 4.2.3
rails -v

# install shims for newly installed Ruby gems that provide commands
rbenv rehash

#install Node.js -- we have to jump over to some github instructions
sudo apt-get install -y software-properties-common python-software-properties
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update -y
sudo apt-get install -y nodejs


#install phantomJS
sudo apt-get install -y bzip2
export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64"
cd /tmp
curl -L https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 | tar xvjf -
sudo mv $PHANTOM_JS /usr/local/share
sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin
phantomjs --version


#install sablime text
cd /tmp
curl http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2%20x64.tar.bz2 | tar -xjf -
sudo mv 'Sublime Text 2' /opt/SublimeText2
echo export PATH='$PATH:/opt/SublimeText2' >> ~/.bashrc


#inspect installation
tree ~/ -L 1
tree ~/.rbenv -L 1

