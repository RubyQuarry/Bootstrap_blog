#!/bin/sh
rake assets:precompile;
git add .;
git commit -am "push to heroku"
git push heroku master --force;
heroku run rake db:migrate;