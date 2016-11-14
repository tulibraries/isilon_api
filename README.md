# IsilonApi

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'isilon_api', :github => 'tulibraries/isilon_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install isilon_api

## Config

You'll need to add configuration for your Isilon cluster so you can connect to the API endpoint. To do 
so in a rails app, create `config/initializers/isilon.rb` with :

```
IsilonApi.configure do |config|
  config.user     = 'example_user'
  config.password = '3x4mpl3_p4$$w0rd'
  config.host     = 'isilon.example.com'
  config.port     = '8080'
  config.units    = 'mb'
end
```
 
## Using

Get some information about quotas

```
isilon = IsilonApi::Base.new

quotas = isilon.get_quotas

quotas.first.usage
278742345
```

~~~~~~~~~~~~~~~~~~~~~

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


~~~~~~~~~~~~~~~~~~~~~

## Report Generation

To generate a report, run `bin/report report.csv` to generate a CSV formatted report. Default units are in mb. To change, 
use the `-u` or `--units=mb|gb|tb|pb` option. Valid units are 'mb', 'gb', 'tb', and 'pb' for megabytes, gigabytes, terabytes, and petabytes.

Use `--help` to see all available options

~~~~~~~~~~~~~~~~~~~~~

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/isilon_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
