# KaribuCli

karibu_cli is the client for the Karibu RPC distributed object system.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'karibu_cli', git: 'git@gitlab.visibleo.fr:visibleornd/karibu_cli.git'
```

And then execute:

    $ bundle


## Configuration
Require The library in your startup file
```ruby
require 'karibu_cli'
```
Add the configuration options
```ruby
KaribuCli::Configuration.configure do |config|
  config.add_service(:test_app, "tcp://127.0.0.1:5050") # With connection string if you know where the service is lauched
  config.add_service(:mercure_service) # without the connection string when the service is registered via consul service discovery
  config.logger = # Defaults to log/environment.log
  config.workers  = # Number of threads to handle your requests - default 10
  config.env = # Setup environment - default to development
  config.symbolize_keys = # Returns symbols after request - default true
end
```

## Usage
You can now call your service with the classes exposed and their arguments
```ruby
KaribuCli.call(:test_app, ['Dummy', 'say', ['hola']])
# Dummy: exposed class
# say: method
# ['hola']: arguments
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
