source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "3.0.2"

gem "active_storage_validations"
gem "bcrypt", "3.1.13"
gem "bootsnap", ">= 1.4.4", require: false
gem "bootstrap-sass", "3.4.1"
gem "config"
gem "faker", {git: "https://github.com/faker-ruby/faker.git", branch: "master"}
gem "figaro"
gem "font-awesome-sass", "~> 6.1.2"
gem "image_processing", "1.9.3"
gem "jbuilder", "~> 2.7"
gem "mini_magick", "4.9.5"
gem "mysql2", "~> 0.5"
gem "pagy", "~> 5.10"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.6", ">= 6.1.6"
gem "rails-i18n"
gem "sass-rails", ">= 6"
gem "toastr-rails"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 4.0.1"
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.14.0", require: false
end

group :development do
  gem "listen", "~> 3.3"
  gem "meta_request"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver", ">= 4.0.0.rc1"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
