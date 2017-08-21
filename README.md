# CyberShop

[![Build Status](https://travis.ibm.com/ATAT/CyberShop.svg?token=Lsphg5poC1bTwtG8aZmF&branch=master)](https://travis.ibm.com/ATAT/CyberShop)

## Installation

### Manual

* [**Install Ruby**](https://www.ruby-lang.org/en/documentation/installation/) version **2.3.4**

* **Install Bundler:** `gem install bundler`

* **Install package dependencies:** `bundle install`

* **Database creation:** `rake db:migrate`

* **Configure Environment:** copy `.env.example` to `.env` in your working directory and fill it in with your values

* **Database initialization:** `rake db:seed`

* **Test suite:** `bundle exec rake`

* **Run the app:** `rails server`

### Docker

#### Configure Environment
copy `.env.example` to `.env` in your working directory and fill it in with your values

#### Quick Deploy in Development Mode
Build and run with standard Docker:
```bash
docker build -t cybershop_dev https://github.ibm.com/ATAT/CyberShop.git
docker run -it -p 3000:3000 --env-file .env cybershop_dev
```
Or clone the code and use Docker Compose:
```bash
git clone https://github.ibm.com/ATAT/CyberShop.git && cd CyberShop && mv ../.env .
docker-compose up
```
Visit [http://localhost:3000](http://localhost:3000) from a browser

#### Local Development with Live Reload
Clone the code, then Docker build and run:
```bash
git clone https://github.ibm.com/ATAT/CyberShop.git && cd CyberShop && mv ../.env .
docker build -t cybershop_dev .
docker run -it -p 3000:3000 --env-file .env -v `pwd`:`pwd` -w `pwd` cybershop_dev rails db:migrate && rails server
```
Visit [http://localhost:3000](http://localhost:3000) from a browser</br>
Modify any files in `/app` and refresh browser to view updates

#### Production
(These instructions are for Ubuntu, other OSes may be different)
- Get a domain name and point it to your server
- Open ports 80 and 443
- [Install NGINX](https://www.nginx.com/resources/wiki/start/topics/tutorials/install/) on your server
- Copy `build/production/CyberShop-nginx` to `/etc/nginx/sites-available/CyberShop` on your server
- Modify the file on your server (`/etc/nginx/sites-available/CyberShop`) with the domain name pointing to your server:
    ```
    server_name <DOMAIN_NAME>;
    ```
- Enable the new site configuration
    ```bash
    cd /etc/nginx/sites-enabled
    rm default
    ln -s /etc/nginx/sites-available/CyberShop CyberShop
    ```
- Run [certbot](https://certbot.eff.org/) on your server to get an SSL certificate
- Build and run the docker container
    ```bash
    docker build -t cybershop_prod --build-arg RAILS_ENV=production https://github.ibm.com/ATAT/CyberShop.git
    docker run -d -p 3000:3000 --env-file .env -v CyberShop:/CyberShop/public cybershop_prod
    ln -s /var/lib/docker/volumes/CyberShop/_data public
    ```
- Visit your domain name from a browser