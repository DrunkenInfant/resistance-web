#!/bin/sh
SECRET_FILE=.secret_token_file
DEVISE_SECRET_FILE=.devise_secret_file

if [ ! -f "$SECRET_FILE" ]; then
  rake secret > $SECRET_FILE
fi
if [ ! -f "$DEVISE_SECRET_FILE" ]; then
  rake secret > $DEVISE_SECRET_FILE
fi
DEVISE_SECRET=$(cat "$DEVISE_SECRET_FILE") SECRET_KEY_BASE=$(cat "$SECRET_FILE") RAILS_ENV=production rake assets:precompile
