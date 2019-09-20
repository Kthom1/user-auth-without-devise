# Inc-User

User management without Devise.

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
rake db:create
rake db:schema:load
```

### 2. Run the application

In the app directory run

```bash
rails s
```

To enable live reloading, in another terminal in the same directory run

```bash
bundle exec guard
```

### 3. Testing

This application uses Rspec for testing, and is designed to be tested with Google Chrome.

Google Chrome can be downloaded here: https://www.google.com/chrome/

To run all tests, in the project directory, run

```bash
rspec spec
```

All tests can be found in the project's spec folder. To run tests separately, run

```bash
rspec spec/path_to/example_spec.rb
```

### Closing

If you have any questions, please don't hesitate to ask. Have a nice day.

keenan.thompson67@gmail.com
