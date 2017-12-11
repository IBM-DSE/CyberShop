#!/bin/bash

echo Travis Branch: $TRAVIS_BRANCH

if [[ ${TRAVIS_BRANCH} == "deploy-ibm-yp-us-south-"* ]]; then
    APP_URL="https://cybershop.mybluemix.net/"
elif [[ ${TRAVIS_BRANCH} == "deploy-ibm-yp-eu-gb-"* ]]; then
    APP_URL="https://cybershop.eu-gb.mybluemix.net"
elif [[ ${TRAVIS_BRANCH} == "deploy-ibm-yp-au-syd-"* ]]; then
    APP_URL="https://cybershop.au-syd.mybluemix.net"
fi

if [ ! -z "$APP_URL" ]; then
    export APP_URL
else
    APP_URL=localhost
fi
echo Testing Target: $APP_URL
