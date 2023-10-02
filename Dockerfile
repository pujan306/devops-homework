# Use the official Ruby image as the base image
FROM ruby:3.0.0

# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install gem dependencies
RUN bundle install

# Copy the entire Rails app into the container
COPY . .

# Expose port 3000 for the Rails server
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
