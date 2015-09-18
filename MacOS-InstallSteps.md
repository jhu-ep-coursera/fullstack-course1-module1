# Fullstack Course 1: Module 1
Follow the steps bellow to set up your development environment. This version of the installation guide assumes you are running **OS X Yosemite 10.10.x**

### Installation

#### Install the required command-line tools
Open a new terminal session and type the following:
~~~
$ git --version
~~~
This will trigger the operating system to prompt you to install the Mac OS command line tools.

1. Click **Install** to install the tools (you don't need to install XCode at this point).
2. Read the terms and conditions, and click **Agree** to continue.

#### Install Homebrew on Mac OS X
These instructions assume that you have _administrative privilages_ on your Mac.

1. Open a browser and navigate to the [Homebrew](http://brew.sh) website.
2. Copy and paste the _curl_ command a a terminal prompt to install Homebrew.

#### Update git
Homebrew makes it very easy to keep everything up to date. Let's first check for updates.
~~~
$ brew update
~~~
Although Apple installs a version of **git** along with OS X, we want to make sure we are running the latest version.
~~~
$ git --version
git version 2.3.2 (Apple Git-55)
~~~

Let's install **git** with Homebrew
~~~
$ brew install git
~~~

If you try again to check the version again, you will see it hasn't changed.
~~~
$ git --version
git version 2.3.2 (Apple Git-55)
~~~

In order to make the change, we will have to open **.bash_profile** and edit it in your favorite text editor. In this case, I will use [Sublime Text](http://www.sublimetext.com/).
~~~
$ subl ~/.bash_profile
~~~
Update your .bash_profile file and create a variable:
~~~
export GIT_HOME='/usr/local/Cellar/git/2.5.2/bin'
~~~
Now add the new variable to the path.
~~~
PATH=$GIT_HOME:$PATH
~~~

Now back in the terminal you need to reload the .bash_profile
~~~
$ source .bash_profile
~~~

Now when you check your git version it should be up to date!
~~~
$ git --version
~~~

#### Install rbenv
***rbenv*** is an environment manager that allows you to easily switch Ruby versions for each project.

~~~
$ brew install rbenv ruby-build
~~~

Add rbenv to bash so that it loads every time you open a terminal
~~~
$ echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
$ source ~/.bash_profile
~~~

##### Install Ruby
~~~
$ rbenv install 2.2.3
~~~
Set the global version of Ruby.
~~~
$ rbenv global 2.2.3
~~~
Verify that the correct version has been set
~~~
$ ruby -v
~~~
You should see something like the follow, though your patch number may vary.
~~~
ruby 2.2.3p173 (2015-08-18 revision 51636) [x86_64-darwin14]
~~~

#### Install Ruby on Rails
~~~
$ gem install rails -v 4.2.3
~~~
Rails is installed, but we need **rbenv** to see it.
For that, we execute the **rehash** command. It is good practice to run the **rehash** comannd any time you install a new gem that provides terminal commands. See [here](https://github.com/sstephenson/rbenv#rbenv-rehash) for more details.
~~~
$ rbenv rehash
~~~
Verify that Ruby on Rails is now installed.
~~~
rails -v
~~~
#### Create a Test application
~~~
$ rails new test_app
~~~
Rails will now create

~~~
$ cd test_app
~~~

Now it's time to test your application. Start your server:
~~~
$ rails server
~~~
Open your favorite browser and type in **localhost:3000** into the address bar.
If everything works correctly, you see the welcome to Ruby on Rails page.

Click on **About your application's environment** to verify your Ruby and Rails versions.

#### Install PhantomJS
~~~
$ brew install phantomjs
~~~
Verify that PhantomJS is now installed.
~~~
$ phantomjs -v
~~~

#### Install Sublime Text 3
1. Open a browser and navigate to the [Sublime Text](http://www.sublimetext.com/3) website.
2. Download the OS X dmg file
3. Click it and drag it to Applications folder
4. Go to Spotlight and write "Sublime Text"

#### Set an Environment variable
This is needed for configuring your system for Coursera assignment submission

export WEB_URL='http://www.coursera.com'
