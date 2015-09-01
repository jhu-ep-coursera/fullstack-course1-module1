
# verification steps
git --version
phantomjs -v
ruby -v
rails -v
rails new test_install -q
(cd test_install; rails server)
(cd test_install; sublime_text) > /dev/null
chrome http://localhost:3000 > /dev/null
firefox http://localhost:3000 > /dev/null
