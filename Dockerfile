FROM ruby:2.3.4
ARG RAILS_ENV=development
ENV RAILS_ENV $RAILS_ENV

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV INSTALL_PATH /CyberShop
RUN mkdir -p $INSTALL_PATH

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

# Ensure gems are cached and only get updated when they change.
# This will drastically increase build times when your gems do not change.
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN if [ "${RAILS_ENV}" = "production" ]; then bundle install --without development test; else bundle install; fi

# Copy in the application code from your work station at the current directory
# over to the working directory.
COPY . .

# Expose a volume so that nginx will be able to read in assets in production.
VOLUME ["$INSTALL_PATH/public"]

# Expose port 3000 to the Docker host, so we can access it from the outside.
EXPOSE 3000

# Command sets SECRET_KEY_BASE and precompiles assets in production, and then resets database and starts the server
CMD if [ "${RAILS_ENV}" = "production" ]; then export SECRET_KEY_BASE=$(rake secret) && rake assets:precompile; fi && rake db:reset && rails server -b 0.0.0.0