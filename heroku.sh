#!/bin/sh
rake assets:precompile;
git add .;
git commit -am "push to heroku"
git push heroku master;
heroku run rake db:schema:load;