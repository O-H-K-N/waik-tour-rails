source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.6'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails'
gem 'font-awesome-sass', '~> 5.11.2'
gem 'jquery-rails'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

gem 'google-api-client', '~> 0.11'
gem 'sorcery'
gem 'seed-fu'

# Admin Tool
gem 'ransack'
gem 'kaminari'
gem 'rails-i18n'
gem 'enum_help'

gem 'rake'
gem 'net-smtp'
gem 'net-imap'
gem 'net-pop'

gem 'annotate'

group :development, :test do
  #Debugger
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-doc'
  gem 'pry-rails'

  # Code analyse
  gem 'rubocop', require: false
  gem 'rubocop-rails', require:false

  # rspec
  gem 'capybara'
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem 'faker'
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
