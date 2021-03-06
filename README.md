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

You may also provide a path to a configuration file with the `-c /path/to/config.yml` or `--config=/path/to/config.yml`.  The config file is a yml file containing

```
---

user: 'example_isilon_user'
password: '3x4mpl3_p4$$w0rd'
host: 'isilon.example.com'
port: '8080'
```
Use `--help` to see all available options

~~~~~~~~~~~~~~~~~~~~~

## Automatic Report Generation

To run the report periodically and email the report to a user, create an entry in the isilon_api user's crontab by executing the `sudo - isilon_api_user crontab -e` command.
The cron entry would look like:

```
0 1 * * 1 source /usr/local/share/isilon_api/.bash_profile ; /usr/local/share/isilon_api/isilon_api/bin/report -c /usr/local/share/isilon_api/isilon_api/config.yml -d /var/log/isilon_api ; /usr/local/share/isilon_api/isilon_api/bin/sendreport
```

Which will run automatically on Monday's at 2:00AM

Restart cron

```bash
sudo service crond restart
```

~~~~~~~~~~~~~~~~~~~~~

## Send the report by email

Create a list of report recipients with a file named `report-recipients.txt`. Use the the example file `report-recipients.txt.example` as a template.  Copy the file to
`report-recipients.txt` and replace the email addresses with the actual addresses of the intended recipients. Run the `bin/sendreport` to generate and email
email a quota report.

~~~~~~~~~~~~~~~~~~~~~
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/isilon_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
