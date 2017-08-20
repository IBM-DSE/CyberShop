#!/bin/bash

echo Travis Branch: $TRAVIS_BRANCH

if [[ ${TRAVIS_BRANCH} == "deploy-ibm-yp-us-south-"* ]]; then
    APP_URL="https://cybershop.mybluemix.net/"
fi

if [ ! -z "$APP_URL" ]; then
    export APP_URL
else
    APP_URL=localhost
    bin/rails db:migrate RAILS_ENV=test
fi
echo Testing Target: $APP_URL
