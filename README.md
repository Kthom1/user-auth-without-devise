# User Auth Without Devise

## What is this?

 This is an example of basic user management -- account creation, sessions, welcome user email, reset password email -- in Ruby on Rails without using Devise.

## Usage

### 1. Configure your database

This project uses Postgresql.
Postgresql can be downloaded here: https://www.postgresql.org/download/

From the terminal run

```bash
psql postgres
create role incuser with createdb login password 'password';
```

Navigate to the project directory and run

```bash
bundle i
bundle exec figaro install
```

The figaro install command will create an application.yml file in the project's config directory, and add this file to the project's git ignore.

Inside config/application.yml paste

```bash
INC-USER_DATABASE_PASSWORD: "password"
```

Save the change then run

```bash
rake db:create
rake db:schema:load
```

### 2. Run the application

In the app directory run

```bash
bundle exec guard
```

In a separate terminal, in the app directory, run

```bash
rails s
```

Guard enables live reload, so if you would like to try changing anything in the application, that change will immediately be reflected in the browser.

This application was designed to use guard by default in development, so while not running `bundle exec guard` will not prevent the application from working, there will be an error in the browser's console.

If you are not interested in live reload and just want to start the application, navigate to config/environments/development.rb and comment out this line

```bash
config.middleware.insert_after ActionDispatch::Static, Rack::LiveReload
```

You can then simply start the application with the following command in the project directory

```bash
rails s
```

### 3. Testing

This application uses Rspec for testing and is designed to be tested with Google Chrome.
Google Chrome can be downloaded here: https://www.google.com/chrome/

To run all tests, in the project directory, run

```bash
rspec spec
```

All tests can be found in the project's spec folder. To run tests separately, run

```bash
rspec spec/path_to/example_spec.rb
```

## Closing

If you have any questions, please don't hesitate to ask. Have a nice day.

keenan.thompson67@gmail.com
